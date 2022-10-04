#!/bin/sh
lock() {
    i3lock -c 303030
}

case "$1" in
    lock)
        logger -t i3exit "Locking"
        lock
        ;;
    logout)
        logger -t i3exit "Logout"
        i3-msg exit
        ;;
    suspend)
        lock && systemctl suspend
        ;;
    hibernate)
        lock && systemctl hibernate
        ;;
    reboot)
        logger -t i3exit "Reboot"
        systemctl reboot
        ;;
    shutdown)
        #systemctl poweroff
        logger -t i3exit "shutdown"
        sudo shutdown now
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
