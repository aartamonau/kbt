module Main (main) where

import Data.Maybe (fromMaybe, fromJust)
import Data.Word (Word64)
import Data.Map (Map)
import qualified Data.Map as Map
import Control.Monad (forM_)
import Safe (readMay)

type Address = Word64
type Name = String
type Symbol = (Address, Name)

ksyms :: FilePath
ksyms = "/proc/kallsyms"

maybe0x :: String -> String
maybe0x s@('0' : 'x' : _) = s
maybe0x s = "0x" ++ s

readAddress :: String -> Maybe Address
readAddress = readMay . maybe0x

readSymbol :: String -> Symbol
readSymbol s = (fromJust $ readAddress address, name)
  where [address, _, name] = take 3 (words s)

readKsyms :: IO (Map Address Name)
readKsyms = do
  symbols <- fmap lines (readFile ksyms)
  return $ Map.fromList (map readSymbol symbols)

decodeAddress :: Map Address Name -> Address -> Maybe Name
decodeAddress syms addr = fmap snd $ Map.lookupLE addr syms

main :: IO ()
main = do
  syms  <- readKsyms
  addrs <- fmap lines getContents

  forM_ addrs $ \addrStr ->
    case words addrStr of
      (addrStr' : _) ->
        case readAddress addrStr' of
          Just addr ->
            putStrLn $ addrStr' ++ " : " ++ fromMaybe addrStr' (decodeAddress syms addr)
          Nothing ->
            putStrLn addrStr
      _ ->
        putStrLn addrStr
