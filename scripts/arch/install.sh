#! /usr/bin/env bash
set -e

echo ">> Installing with arch pacman."

grep archlinuxfr /etc/pacman.conf > /dev/null || {
    echo [archlinuxfr] >> /etc/pacman.conf
    echo SigLevel = Optional >> /etc/pacman.conf
    echo Server = http://repo.archlinux.fr/\$arch >> /etc/pacman.conf
}

pacman --noconfirm -Syu stow neovim xsel xorg-xmodmap htop hfsprogs jdk8-openjdk git mercurial \
    ruby go cmake python-pip python2 python2-pip npm nodejs scala gradle maven docker markdown \
    vagrant virtualbox shellcheck jq keybase tmux tree \
    keybase dropbox pantheon-terminal light-locker yaourt

pacman -Q | grep gnome-terminal && pacman --noconfirm -R gnome-terminal

sudo -u roboll yaourt --noconfirm -S lightdm-webkit2-greeter
sudo -u roboll yaourt --noconfirm -S lightdm-webkit-google-git

sudo -u roboll yaourt --noconfirm -S google-chrome touchegg \
    gtk-theme-arc elementary-icon-theme gnome-shell-extension-dynamic-top-bar \
    ttf-inconsolata-lgc-for-powerline

cp $(dirname "${BASH_SOURCE}")/roboll.jpg /usr/share/roboll.jpg
echo "Icon=/usr/share/roboll.jpg" >> /var/lib/AccountsService/users/roboll

echo "options hid_magicmouse scroll-speed=50 scroll-acceleration=1 emulate_3button=0" | \
    sudo tee /etc/modprobe.d/magicmouse.conf > /dev/null

cat <<MOUSE > /usr/share/X11/xorg.conf.d/10-magicmouse.conf
Section "InputClass"
        Identifier "Rob's Home Mouse"
        Option "ButtonMapping" "1 0 3 5 4 7 6 0 0 0 0 0"
EndSection
MOUSE
