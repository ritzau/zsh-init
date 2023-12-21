source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
# [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
# [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

# ALT-B - switch branch
fzf-git-checkout-widget() {
  git rev-parse --git-dir > /dev/null 2>&1 || return 5

  local cmd="git branch -a --format='%(refname:short)'"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local branch="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$branch" ]]; then
    zle redisplay
    return 0
  fi
  git checkout "$branch"
  unset branch # ensure this doesn't end up appearing in prompt expansion
  local ret=$?
  zle fzf-redraw-prompt
  return $ret
}
zle     -N    fzf-git-checkout-widget
# bindkey '\eB' fzf-git-checkout-widget
bindkey '^[b' fzf-git-checkout-widget

cd-up-widget() {
  local GIT_DIR

  GIT_DIR=$(git rev-parse --show-toplevel) && [[ $PWD != $GIT_DIR ]] && cd "$GIT_DIR" || cd "$HOME"
  zle fzf-redraw-prompt
  return 0
}
zle     -N    cd-up-widget
# bindkey '\e[1;3A' cd-up-widget
bindkey '^[u' cd-up-widget

bindkey '\e[1;3D' backward-word
bindkey '\e[1;3C' forward-word

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$key[Up]" up-line-or-beginning-search
bindkey "$key[Down]" down-line-or-beginning-search
