WORDCHARS='*?_-.[]~=&!#$%^(){}<>'

setopt auto_cd

cmd_foo=foo
preexec(){ cmd_foo=$1; }
precmd(){ if [ "$cmd_foo" ]; then lcmd_foo=$cmd_foo; cmd_foo=; else; git status 2> /dev/null || ls; fi; }
