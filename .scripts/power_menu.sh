LOCK="i3lock -i $HOME/Pictures/wallpapers/wallp15.png"
declare -A CMDS
CMDS=(
				[" shutdown"]="systemctl poweroff"
				[" restart"]="systemctl reboot"
				[" logout"]="systemctl exit"
				[" sleep"]="systemctl suspend"
				[" screenlock"]="$LOCK"
				)
list_gen() {
	for i in "${!CMDS[@]}"
	do
					echo "$i"
	done
}
main() {
	SEC=$( (list_gen) | rofi -dmenu -matching fuzzy -no-custom -location 0 -p "power menu" )
	if [[ -n $SEC ]]
	then
					RUN=${CMDS[$SEC]}
					eval "${RUN}"
	else
					exit
	fi
}

main

exit 0
