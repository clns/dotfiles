# .bash_profile is executed for login shells, when a shell is opened and user is logged in.
# On Mac OS X there is an exception to this and .bash_profile is called each time instead of .bashrc

if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi
