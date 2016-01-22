#! /usr/bin/env bash
set -e

echo ">> Installing for apt-based system."

add-apt-repository -y ppa:openjdk-r/ppa
add-apt-repository -y ppa:neovim-ppa/unstable
add-apt-repository -y ppa:rael-gc/scudcloud
add-apt-repository -y ppa:ubuntu-lxc/lxd-stable
add-apt-repository -y ppa:caffeine-developers/ppa

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

apt-get update

apt-get install -ym bash bash-completion \
    gparted hfsutils stow coreutils exuberant-ctags encfs htop \
    neovim openjdk-8-jdk scudcloud \
    xsel mercurial gist cmake python-dev python-pip python3-dev python3-pip nodejs npm golang-go scala \
    gradle leiningen maven ansible awscli \
    jq docker.io vagrant virtualbox shellcheck markdown \
    chromium-browser spotify-client visualvm fonts-inconsolata \
    gnome-screensaver touchegg caffeine

curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /tmp/chrome.deb && \
sudo dpkg -i /tmp/chrome.deb && rm /tmp/chrome.deb

curl https://dist.keybase.io/linux/deb/keybase-latest-amd64.deb -o /tmp/keybase.deb && \
sudo dpkg -i /tmp/keybase.deb && rm /tmp/keybase.deb

curl http://launchpadlibrarian.net/227235832/tmux_2.1-3_amd64.deb -o /tmp/tmux.deb && \
sudo dpkg -i /tmp/tmux.deb && rm /tmp/tmux.deb

sudo -u roboll git clone https://github.com/roboll/elementary-dropbox /tmp/elementary-dropbox && \
sudo -u roboll /tmp/elementary-dropbox/install.sh -y && \
rm -r /tmp/elementary-dropbox

echo "options hid_magicmouse scroll-speed=50 scroll-acceleration=1" | \
    sudo tee /etc/modprobe.d/magicmouse.conf > /dev/null

cat <<MOUSE > /usr/share/X11/xorg.conf.d/10-magicmouse.conf
Section "InputClass"
        Identifier "Rob's Home Mouse"
        Option "ButtonMapping" "1 0 3 5 4 7 6 0 0 0 0 0"
EndSection
MOUSE
