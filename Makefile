all: kbt

kbt: kbt.hs
	ghc --make -O3 kbt.hs -o kbt

clean:
	rm -rf *.o *.hi kbt
