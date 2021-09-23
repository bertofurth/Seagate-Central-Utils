# README-pEmacs.md
pEmacs / Perfect Emacs / "pe" is a small footprint Emacs editor clone.

https://github.com/hughbarney/pEmacs

"pe" supports all of the major key combinations that standard GNU
emacs does but without some of the more sophisticated and less
frequently used features.

I quickly added this useful tool to the Seagate Central because I
I can't stand the "nano" editor and despite my sincerest efforts, I'm 
not a "vi" guy.

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for notes and procedures specific to "less".

## Build Procedure
### Source code download and extraction
This procedure was tested using the following versions of software.
Unless otherwise noted these are the latest stable releases at the
time of writing. Hopefully later versions, or at least those with
the same major version numbers, will still work with this guide.

* ncurses-6.2 - http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz    
* pEmacs - https://github.com/hughbarney/pEmacs

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-src-pEmacs.sh** script.

## Installation
To invoke pEmacs simply run the command "pe file-name" in the same 
way as any other editor is invoked.

If you are inclined, you can also create a symbolic link as follows
so that calling "emacs" will execute "pe".

    ln -s pe /usr/local/bin/emacs
    
## "pe" basic usage
To exit from "pe" simply type Ctrl-X followed by Ctrl-C at which point
you'll be asked whether you want to save your file.

Beyond that, all the keystrokes are the same as for the GNU emacs editor
except for a few small exceptions. Please refer to the useful guide at the
pEmacs homepage for an overview of the available commands.

https://github.com/hughbarney/pEmacs

Any basic GNU emacs tutorial or guide will also apply to "pe".
