# Setup fzf
# ---------
if [[ ! "$PATH" == */home/x/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/x/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/x/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/x/.fzf/shell/key-bindings.zsh"
