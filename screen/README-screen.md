# README-screen.md
GNU screen is a terminal multiplexer that allows users to run multiple
terminal sessions and switch between them within the one terminal
session.

https://www.gnu.org/software/screen/screen

GNU screen is useful when connecting to a "headless" server like
the Seagate Central because it means that only one ssh session 
needs to be established to the server, but within that one 
session, multiple sessions running different terminal processes
can be managed. For example, you can quickly switch between "screens",
or display multiple "screens" at once all within the one primary
ssh session.

Another important feature of GNU screen is that the primary ssh
session can be disconnected but the screen terminal sessions created
by screen will keep running anyway. This means that processes invoked
in a "screen" can continue to run even when the client ssh session is
disconnected. Later on the connection to the existing screen session
can be resumed.

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for GNU screen specific notes and procedures.

## TLDNR
The quick "TLDNR" instructions for building screen are the same as the
"TLDNR" instructions in the main README.md file however, you must first 
download the ncurses libraries from the Seagate Central as per the
**Seagate Central libraries and headers** section below. 

## Build Procedure
### Source code download and extraction
This procedure was tested using the following versions of software.
Unless otherwise noted these are the latest stable releases at the
time of writing. Hopefully later versions, or at least those with
the same major version numbers, will still work with this guide.

* ncurses-0.6.22 - http://mirrors.kernel.org/gnu/ncurses/ncurses-6.2.tar.gz    
* screen-4.8.0 - http://mirrors.kernel.org/gnu/screen/screen-4.8.0.tar.gz

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-src-screen.sh** script.

### Basic GNU screen usage
Invoke screen by simply running the "screen" command.

A more sophisticated way of invoking screen is to specify an identity
for the screen session as follows

    screen -S my-session

Once screen is running, new screens can be created by pressing
"Control-a" followed by "c".

Most screen commands are "Ctrl-a" followed by a key. Some other
useful commands to control screen are as follows.

* Move to the "next" screen - Ctrl-a  "space"
* Move to the "previous" screen - Ctrl-a  "backspace"
* List available screens - Ctrl-a  "w"
* Move straight to screen number X - Ctrl-a  "X" (Where X is a digit)
* Disconnect from screen but leave the session running - Ctrl-a  "d"
* Help - Ctrl-a  "?"

Interesting note, if you're used to pressing "Ctrl-a" in a bash
shell session or in an editor to move to the beginning of a line,
you'll need to replace that with "Ctrl-a" followed by "a" while
using screen. It's annoying at first but you'll quickly get used to 
it!!

After disconnecting from a screen session, the session will still
be running. This is one of the most useful aspects of screen as 
it means you can leave a process running while not needing to
maintain an ssh connection to the server.

You can list the running screen sessions with the "screen -ls"
command as per the following example

    $ ./screen -ls
    There is a screen on:
            32000.my-session   (Detached)
    1 Socket in /tmp/uscreens/S-admin.

You can reconnect to a screen session with the "screen -x " command
by either using the numerical screen number or the session name.
For example

    screen -x 32000
    
or

    screen -x my-session

You can even establish another ssh session from another client
and have that other client connect to the **same** screen session. 
That is, multiple clients are able to watch and interact with a
screen terminal session at the same time.

I would suggest trying to find a good instructional **video**
describing how to use GNU screen as reading about it does not do
it justice.

See the "sample-dot-screenrc" and "sample-dot-bashrc" files in
this project directory for an example of a useful screen
and bash configuration file that can work well with screen
on the Seagate Central.

