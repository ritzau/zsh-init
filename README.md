# Init scripts for ZSH

Put this in `.zshrc`
```zsh
for f in ~/.zsh/<0-99>-*.zsh
do
  source "$f"
done
```
