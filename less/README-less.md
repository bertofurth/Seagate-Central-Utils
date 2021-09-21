# README-less.md
less is a "pager", meaning it is used to display text files in
a terminal or ssh session.

https://greenwoodsoftware.com/less/faq.html

The version of "less" included with the Seagate Central is the
devil's spawn. (It's based on "busybox") It doesn't support the
search function which is one of the most useful parts of "less".

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for "less" specific notes and procedures.

## Build Procedure
### Source code download and extraction
This procedure was tested using the following versions of software.
Unless otherwise noted these are the latest stable releases at the
time of writing. Hopefully later versions, or at least those with
the same major version numbers, will still work with this guide.

* ncurses-0.6.22 - http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz    
* less-590 - http://mirrors.kernel.org/gnu/less/less-590.tar.gz

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-src-less.sh** script.

### Seagate Central libraries and headers
We need to copy over one specific library file from the Seagate
Central to the build host, namely libncurses, so that it can be
linked to during the build process.

Create an appropriate sub directory under the base working 
directory to store the library in. By default we use the "sc-libs"
subdirectory to store Seagate Central libraries.

    mkdir -p sc-libs/usr/lib
    
In this example we copy the required library using the scp command
and we rename it to "libncurses.so". You will need to substitute your
own username and NAS IP address.  

    scp admin@192.0.2.99:/usr/lib/libncurses.so.5.0.7 sc-libs/usr/lib/libncurses.so
       
After executing the scp command you'll be prompted for the password
for that username on the Seagate Central.

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
* 
#### Movement
* Up arrow or k - Up
* Down arrow or j - Down
* f - Forward one window
* b - Back one window
* g or < - start of file
* G or > - end of file
* <num>g or <num>G - Goto line number <num>
* F - Keep displaying more text (like tail -f)

#### Search
* /pattern  - Search for "pattern" forwards (regexp)
* ?pattern - Search for "pattern" backwards (regexp)
* n - Go to the next match of "pattern"
* N - Go to the previous match "pattern"
* &pattern - Show only lines that match "pattern" (regexp)
* ctrl-C or &<enter> - Show all lines of the file (after running &pattern)
* ? or & then up arrow : Scroll through search pattern history
* -I - ignore case in your search pattern 
    
#### Display
* -N - show line numbers
* = or ctrl-G - show current file name and position in file

#### Marking
* mx - Replace "x" with any letter. Mark a position in the file
* 'x - Go back to mark "x"

