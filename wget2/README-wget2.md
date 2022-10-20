# README-pEmacs.md
pEmacs / Perfect Emacs / "pe" is a small footprint GNU Emacs 
editor clone (AKA Ersatz Emacs)

https://github.com/hughbarney/pEmacs

"pe" supports the most commonly used key bindings of standard 
GNU Emacs but sheds support for some of the more sophisticated
and less frequently used features.

I quickly added this useful tool to the Seagate Central because I
can't stand the native "nano" editor and despite my sincerest 
efforts, I'm not a "vi" guy.

There are a number of other lightweight Emacs clones such as "atto"
and microemacs (uEmacs) however pEmacs just seems to be the one
that I liked the best.

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for notes and procedures specific to "pEmacs".

## Build Procedure
### Source code download and extraction
This procedure was tested using the following versions of software.
Unless otherwise noted these are the latest stable releases at the
time of writing. Hopefully later versions, or at least those with
the same major version numbers, will still work with this guide.

* ncurses-6.2 - http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz    
* pEmacs - https://github.com/hughbarney/pEmacs (use "git clone")

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-src-pEmacs.sh** script.

## Build Procedure
The following are two **completely optional** patches you can apply
to pEmacs before building it. They simply make "pe" a little
bit closer to real Emacs in ways that I personally find useful.

You can apply both automatically by running the 
"apply-patches-pEmacs.sh" script as follows after the source
code has been downloaded.

     ./apply-patches-pEmacs.sh

### Optional - Patch for arrow key to leave search dialog.
If, like me, you regularly use an arrow key to exit from the Emacs 
search dialog, you'll notice that pEmacs has a quirk in that if you
try to exit from search with an arrow, pEmacs spits out garbage 
characters such as

    [A  [B
    
If you want to workaround this issue then this project contains an
optional patch that you can apply to pEmacs before building it.
The trade-off is that if you actually do use the "ESC" key to exit
from the search dialog then you'll have to subsequently press one
more key to keep working!

I personally never use the "ESC" key to exit from the Emacs search 
dialog. I typically use "Enter" or an arrow key to do so. I'm not sure 
what other people do.

If you'd like to apply the patch then after downloading and extracting
the source code, run the following command from the base working directory.

     patch src/pEmacs/search.c ./0001-pEmacs-Optional-Arrow-exit-search.patch

An important note, the author of pEmacs was aware of this issue but 
resolving it properly would have added quite a bit of size to pEmacs 
which would have gone against the spirit of the project. In my view
it was a worthwhile tradeoff to make.

### Optional - Patch for "Save on exit"
When you try to exit "pe" without saving your work the program will ask 
you if you really want to exit. If you hit "y" then you exit and all 
your changes are lost.

The problem with this is that at this point *real* Emacs will ask if you
want to save your changes. At this point I normally hit "y", then my changes
are saved then Emacs quits.

I constantly found myself exiting "pe" and answering the question as
asked by real Emacs, and subsequently losing my work!!

I wanted to make "pe" more like real Emacs in this regard, so there is 
another optional patch that will insert a question asking if you want
to save your changes before asking if you really want to exit.

The tradeoff with the patch is that it's a little slower exiting "pe" when
you don't want to save your changes than it otherwise would be.

     patch src/pEmacs/main.c ./0002-pEmacs-Optional-Save-on-exit.patch
     
## Installation
### Optional - Create a link from "emacs" to "pe"
If you are inclined, you can create a symbolic link as follows so that 
calling "emacs" will execute "pe".

    ln -s pe /usr/local/bin/emacs
    
## "pe" basic usage
Invoke "pe" in the same way as any other text editor. For example

    pe my-file.txt

To save your work type Ctrl-X followed by Ctrl-S. To exit from "pe" simply
type Ctrl-X followed by Ctrl-C.

Beyond that, all the keystrokes are the same as for the GNU Emacs editor
except for a few small exceptions. Please refer to the useful guide at the
pEmacs homepage for an overview of the available commands and a list of
the commands not ported over from real Emacs.

https://github.com/hughbarney/pEmacs

Any basic GNU Emacs tutorial or guide will also mostly apply to "pe".



