# README-less.md
less is a "pager", meaning it is used to display text files in
a terminal or ssh session.

https://greenwoodsoftware.com/less/faq.html

The version of "less" included with the native Seagate Central
firmware is the devil's spawn!! It doesn't support the search 
function which is one of the most useful features of "less".

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
* less-590 - http://mirrors.kernel.org/gnu/less/less-590.tar.gz

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-src-less.sh** script.

### "less" basic usage
View a text file using less by running the less command as per the 
following example.

     less textfile.txt

You can also "pipe" the output of another command to less.

     dmesg | less
     
Here are my personal favorite key commands that can be used while
viewing data in less. 

#### Quit and Help
* q - quit
* h - help

#### Movement
* Up arrow or k - Up
* Down arrow or j - Down
* f - Forward one window
* b - Back one window
* g or < - start of file
* G or > - end of file
* NNg or NNG - Goto line number "NN" where "NN" is a number
* F - Keep displaying more text (like tail -f)

#### Search
* /pattern  - Search for "pattern" forwards (regexp)
* ?pattern - Search for "pattern" backwards (regexp)
* n - Go to the next match of "pattern"
* N - Go to the previous match "pattern"
* &pattern - Show only lines that match "pattern" (regexp)
* ctrl-C - Show all lines of the file (after running &pattern)
* /, ? or & then up/down arrow - Scroll through search history.
* -I - Ignore case in search patterns 

#### Display
* -N - show line numbers
* = or ctrl-G - show current file name and position in file

#### Marking
* mx - Replace "x" with any letter. Mark a position in the file
* 'x - Go back to mark "x"

#### The LESS environment variable
The LESS environment variable can be used to configure the behavior
of the "less" program by specifying the "less" command line
parameters to apply each time "less" runs.

For example, by default "less" will perform case sensitive searches 
when using the "/pattern" command.  Many users prefer that it performs
case *insentitive* searches unless a capital letter is used in the
specified "pattern" search term.

This can be configured by using the "-i" flag.

In addition many people prefer that "less" always show the current
file name and position in file while displaying data. This can be
controlled with the "-M" flag.

Both of these flags can be set by either appending them to the "less"
command when it is run, or by specifying them in the LESS environment 
variable as follows.

    export LESS="-i -M"

This variable can be set in a shell startup script such as ".bashrc".
