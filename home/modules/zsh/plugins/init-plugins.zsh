#########################
#	PLUGINS		#
#########################
# Add and remove any zsh plugins here.
# This file needs to be sourced in your zshrc to load the plugins.

source ~/.config/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh	# Advanced Search
source ~/.config/plugins/zsh-window-title/zsh-window-title.zsh 				# Zsh's Window Title
source ~/.config/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 			# Zsh Autosuggestions
source ~/.config/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 		# Zsh Syntax Highlighting
source ~/.config/plugins/zsh-completion/zsh-completion.zsh 				# Zsh Completion
source ~/.config/plugins/zsh-environment/zsh-environment.zsh 				# Zsh Environment Plugin
source ~/.config/plugins/zsh-input/zsh-input.zsh 					# Zsh Input Plugin

# zsh-history-substring-search
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
