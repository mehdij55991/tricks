w/ args
-------
$ gdb --tui --args ./test arg1 arg2

run to main
-----------
(gdb) start

run to line
-----------
(gdb) until 124
(gdb) until main.c:124

tui
---
- https://sourceware.org/gdb/onlinedocs/gdb/TUI-Commands.html
- refresh ctrl-l
- layout [split,src,asm]
