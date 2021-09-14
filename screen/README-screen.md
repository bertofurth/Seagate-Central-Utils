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

Another feature of GNU screen is that the primary ssh session can
be disconnected but the terminal sessions within screen will keep
running. This means that processes invoked in a "screen" can continue
to run even when the client ssh session is disconnected. Later on
the connection to the existing screen session can be resumed.

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for GNU screen specific notes and procedures.

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
by running the **download-screen-src.sh** script.

### Seagate Central libraries and headers
We need to copy over one specific library file from the Seagate
Central to the build host, namely "/usr/lib/libncurses.so.5.0.7", 
so that it can be linked to during the build process.

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

### Basic GNU screen usage

Invoke screen by simply running the "screen" command.

A more sophisticated way of invoking screen is to specify an identity
for the screen session as follows

    screen -S my-session

Once screen is running new screens can be created by pressing
"Control-a" followed by "c".

Switch between screens with the following key commands

* Move to the "next" screen - Ctrl-a  "space"
* Move to the "previous" screen - Ctrl-a  "backspace"
* List available screens - Ctrl-a  "w"
* Move straight to screen number X - Ctrl-a  "X" (Where X is a digit)
* Disconnect from screen - Ctrl-a  "D"
* Help - Ctrl-a  "?"

After disconnecting from a screen session, you can list the running
screen sessions with the "screen -ls" command as per the following 
example

    $ ./screen -ls
    There is a screen on:
            32000.my-session   (Detached)
    1 Socket in /tmp/uscreens/S-admin.

Now you can reconnect to that screen with the "screen -x "
command by either using the numerical screen number or
the session name

    screen -x 32000
    
or

    screen -x my-session

You can even establish another ssh session from another client
and have that other client connect to the **same** screen session. 
That is, you can have multiple clients watching what's going on
in a particular terminal session at the same time.

I would suggest trying to find a good instructional **video**
describing how to use GNU screen as reading about it does not do
it justice.

