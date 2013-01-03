# kbt

Stupid kernel backtrace decoder. Uses /proc/kallsyms to resolve symbol
names. First word (delimited by spaces) of every line is assumed to be an
address to resolve. If something goes wrong, input line is echoed untouched to
the stdout.

# usage

    $ cat backtrace
    0xffffffff814919e0 : 0xffffffff814919e0
    0xffffffff811252f7 : 0xffffffff811252f7
    0xffffffff810b0040 : 0xffffffff810b0040
    0xffffffff81178570 : 0xffffffff81178570
    0xffffffff810af84f : 0xffffffff810af84f
    0xffffffff81491ea9 : 0xffffffff81491ea9
    0xffffffff810af949 : 0xffffffff810af949
    0xffffffff810b048a : 0xffffffff810b048a
    0xffffffff81260e5a : 0xffffffff81260e5a
    0xffffffffa14b2d6b : 0xffffffffa14b2d6b [stap_25786]
    0xffffffff81260e5a : 0xffffffff81260e5a
    0xffffffff810b21cd : 0xffffffff810b21cd
    0xffffffff81496454 : 0xffffffff81496454
    0xffffffffa14b16f3 : 0xffffffffa14b16f3 [stap_25786]
    0xffffffff81119dad : 0xffffffff81119dad
    0xffffffff810232be : 0xffffffff810232be
    0xffffffff810b2c6d : 0xffffffff810b2c6d
    0xffffffff810230b1 : 0xffffffff810230b1
    0xffffffff8149a47f : 0xffffffff8149a47f

    $ kbt < backtrace
    0xffffffff814919e0 : __schedule
    0xffffffff811252f7 : __alloc_pages_nodemask
    0xffffffff810b0040 : get_futex_key
    0xffffffff81178570 : __mem_cgroup_try_charge
    0xffffffff810af84f : get_futex_value_locked
    0xffffffff81491ea9 : schedule
    0xffffffff810af949 : futex_wait_queue_me
    0xffffffff810b048a : futex_wait
    0xffffffff81260e5a : strlcpy
    0xffffffffa14b2d6b : function_gettimeofday_us
    0xffffffff81260e5a : strlcpy
    0xffffffff810b21cd : do_futex
    0xffffffff81496454 : do_page_fault
    0xffffffffa14b16f3 : enter_inode_uprobe
    0xffffffff81119dad : uprobe_notify_resume
    0xffffffff810232be : syscall_trace_leave
    0xffffffff810b2c6d : sys_futex
    0xffffffff810230b1 : syscall_trace_enter
    0xffffffff8149a47f : tracesys
