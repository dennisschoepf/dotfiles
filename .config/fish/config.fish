if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_user_key_bindings
  fish_vi_key_bindings
end

# Set variables from bash_profile
egrep "^export " ~/.bash_profile | while read e
	set var (echo $e | sed -E "s/^export ([A-Za-z_]+)=(.*)\$/\1/")
	set value (echo $e | sed -E "s/^export ([A-Za-z_]+)=(.*)\$/\2/")

	# remove surrounding quotes if existing
	set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

	if test $var = "PATH"
		# replace ":" by spaces. this is how PATH looks for Fish
		set value (echo $value | sed -E "s/:/ /g")

		# use eval because we need to expand the value
		eval set -xg $var $value

		continue
	end

	# evaluate variables. we can use eval because we most likely just used "$var"
	set value (eval echo $value)

	#echo "set -xg '$var' '$value' (via '$e')"
	set -xg $var $value
end

# Set language
set -x LANG en_US.UTF-8

# Set path
set -gx PATH "$HOME/.cargo/bin" "/usr/local/go/bin" "$HOME/.cargo/env" "/opt/homebrew/bin" "/Users/dennis/.local/share/nvm/v16.14.2/bin" "$ANDROID_HOME/emulator" "$ANDROID_HOME/tools" "$ANDROID_HOME/tools/bin" "$ANDROID_HOME/platform-tools" $PATH;

# Aliases
alias npd="npm run dev"
alias lg="lazygit"
alias g="git"
alias la="exa -F -l -a -h --icons --git"
alias ll="exa -F -l --icons --git"
alias ls="exa -F --icons --git"
alias killrnport="kill -9 \`lsof -i :8081 -F 'p' | head -n 1 | sed \"s/p//g\"\`"

# Work Aliases
alias cdr="cd ~/Projects/ride"
alias cdrq="cd ~/Projects/ride/apps/native/qickets"
alias cdrl="cd ~/Projects/ride/apps/lib"
alias cdrqs="cd ~/Projects/ride/apps/backend/edge-services/qickets-service"

starship init fish | source
