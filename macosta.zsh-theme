#
# PROMPT
#
PROMPT_BRACKET_BEGIN='%{$fg_bold[white]%}['
PROMPT_HOST='%{$fg_bold[cyan]%}%m'
PROMPT_SEPARATOR='%{$reset_color%}:'
PROMPT_DIR='%{$fg_bold[yellow]%}%d'
PROMPT_BRACKET_END='%{$fg_bold[white]%}]'
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"


PROMPT_USER='%{$fg_bold[white]%}%n'
PROMPT_SIGN='%{$reset_color%}%#'

GIT_PROMPT_INFO='$(git_prompt_info)'

# My current prompt looks like:
# [host:current_dir] (git_prompt_info)
# [username]%
PROMPT="╭─${PROMPT_BRACKET_BEGIN}${PROMPT_USER}@${PROMPT_HOST}${PROMPT_SEPARATOR}${PROMPT_DIR}${PROMPT_BRACKET_END}${GIT_PROMPT_INFO}
╰─%B${user_symbol}%b "

RPROMPT='%{$fg_bold[green]%}[%*]%{$reset_color%}'

#
# Git repository
#
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=''
