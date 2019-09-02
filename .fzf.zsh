# Setup fzf
# ---------
if [[ ! "$PATH" == */home/skyla/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/skyla/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/skyla/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/skyla/.fzf/shell/key-bindings.zsh"
