# Based on typewritten theme https://github.com/reobin/typewritten

# git status variables
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}:%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[cyan]%} +"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%} !"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%} —"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[green]%} »"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[white]%} #"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[blue]%} ?"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[yellow]%} $"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[blue]%} •|"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[blue]%} |•"

# git status display
local git_info='$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

# current user and hostname
local user_host='%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[yellow]%}%m %{$reset_color%}'

# default: blue, if return code other than 0: red
local prompt_color="%(?,%{$fg[blue]%},%{$fg[red]%})"
local promptend=' ${prompt_color}» %{$reset_color%}'

# current directory display
local directory_path='%{$fg[blue]%}%c'

# last command return code
local return_code='%(?,,%{$fg[red]%} RC=%?%{$reset_color%})'

# prompt definition
PROMPT="${directory_path}"
PROMPT+="${git_info}"
PROMPT+="${return_code}"
PROMPT+="${promptend}"

# prompt cursor fix when exiting vim
local cursor="\e[?16;0;224c"
_fix_cursor() {
  echo -ne "${cursor}"
}
precmd_functions+=(_fix_cursor)
