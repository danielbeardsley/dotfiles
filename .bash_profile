# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

alias logme="tail -f /tmp/dbeardsley_debug.log"

PATH=$PATH:$HOME/bin
export PATH

AWS_LOC="/var/ifixit/aws/id_rsa-gsg-keypair"
export AWS_LOC
