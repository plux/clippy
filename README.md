# clippy

Small interface to xclip from Erlang.

Example usage:

```
1> clippy:get().
"Content of clipboard"

2> clippy:put(hello).
ok

3> clippy:get().     
hello
```
