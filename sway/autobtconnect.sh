#! /bin/sh

on() {
    bluetoothctl power on
    bluetoothctl connect $1
}

off() {
    bluetoothctl power off
}

power_on() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        return 0
    else
        return 1
    fi
}

toggle() {
    if power_on; then
	off
    else
        on
    fi
}

case "$1" in
    on)
        on
        ;;
    off)
        off
        ;;
    toggle)
        toggle
        ;;
    *)
	echo "Usage: $0 {on|off|toggle} <device_mac>"
	exit 1
	;;
esac
