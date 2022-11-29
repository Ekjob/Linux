# Auto-start the ssh agent and add necessary keys once per reboot.
#
# This is recommended to be added to your ~/.bash_aliases (preferred) or ~/.bashrc file on any
# remote ssh server development machine that you generally ssh into, and from which you must ssh
# into other machines or servers, such as to push code to GitHub over ssh. If you only graphically
# log into this machine, however, there is no need to do this, as Ubuntu's Gnome window manager,
# for instance, will automatically start and manage the `ssh-agent` for you instead.
#
# See:
# https://github.com/ElectricRCAircraftGuy/eRCaGuy_dotfiles/tree/master/home/.ssh#auto-starting-the-the-ssh-agent-on-a-remote-ssh-based-development-machine

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    echo "'ssh-agent' has not been started since the last reboot. Starting 'ssh-agent' now."
    eval "$(ssh-agent -s)"
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
# see if any key files are already added to the ssh-agent, and if not, add them
ssh-add -l > /dev/null
if [ "$?" -ne "0" ]; then
    echo "No ssh keys have been added to your 'ssh-agent' since the last reboot. Adding default keys now."
    ssh-add
fi
