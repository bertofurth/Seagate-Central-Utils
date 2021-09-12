# README-syncthing.md
Syncthing is a modern, open source file synchronisation tool.

https://syncthing.net/

This tool only works on the Seagate Central if it has an upgraded
Linux kernel installed as per the 
Seagate-Central-Slot-In-v5.x-Kernel
project at

https://github.com/bertofurth/Seagate-Central-Slot-In-v5.x-Kernel

Syncthing will not work with the original Seagate Central v2.6.35
Linux kernel.

Note that this procedure does NOT require the cross compilation
toolkit to be installed.

## Obtain syncthing
### Option 1 - Download syncthing binary
You can obtain a precompiled **Linux ARM** version of syncthing
from the syncthing download page at

https://syncthing.net/downloads/

The downloaded file will be a tar.gz archive that can be extracted
with the "tar -xf" command. 

The "syncthing" binary in the extracted folder is the one that needs
to be transferred to the Seagate Central.

### Option 2 - Cross compile syncthing
Make sure you have a recent version of "go" installed on your build 
system. This procedure was tested using "go1.16" which was the latest
available as of the time of writing.

Download and extract the latest stable version of syncthing source
code. In this example we download the latest version available as of
tiem time of writing, v1.18.2

    wget https://github.com/syncthing/syncthing/releases/download/v1.18.2/syncthing-source-v1.18.2.tar.gz
    tar -xf syncthing-source-v1.18.2.tar.gz

Change into the extracted source code directory and execute the 
following command to cross compile syncthing for the arm 32 
platform

     go run build.go -goos linux -goarch arm build

A new file called "syncthing" will be built. It should be about 20M 
in size.

## syncthing.sh
syncthing does not come with an "init" based startup script so we 
have included a custom startup script in this project called
"syncthing-init.sh" to work on the Seagate Central.

Note that this script assumes that there is a user called "syncthing"
that will be running the syncthing service. For this reason you should
create a user "syncthing" on the Seagate Central using the Web 
Management interface. Alternately edit the "syncthing-init.sh" script
to specify a different userID.

**Security Note** Be aware that the "synthing.sh" script will activate
the syncthing GUI on port 8384 of the Segate Central Ethernet by default.
Many people consider it best practise to disable the syncthing GUI
after is has been configured. You may need to modify the "syncthing.sh"
startup script accordingly.

## Transfer syncthing to the Seagate Central
Copy "syncthing" and "syncthing-init.sh" to the Seagate Central.

## Install syncthing on the Seagate Central
Log into the Seagate Central via ssh and issue the su command to become
the root user.

Copy the syncthing binary to the /usr/local/bin directory and make sure
to set the appropriate file permissions.

    install -o root -m 755 syncthing /usr/local/bin

Install the syncthing.sh startup script

    install -o root -m 755 syncthing-init.sh /etc/init.d

Configure the script to be invoked at system startup.

    update-rc.d syncthing-init.sh defaults 30

## Start syncthing and configure a GUI password
Start syncthing by rebooting the Seagate Central or manually by issuing
the following command.

/etc/init.d/syncthing.sh start

Once syncthing has started for the first time, log in to the configuration 
gui webpage by browsing to port 8384 of your NAS IP address. For example

    http://192.0.2.99:8384

When you initially log in to the GUI you will be confronted with a warning
message asking you to configure a password for the GUI straight away. 

## Troubleshooting
The syncthing logs are located at /var/log/syncthing

I would suggest that since the Seagate Central is not a particularly powerful
platform that you only give syncthing "light" duties. It may be that during
the initial sync between a client and the Seagate Central or while a large
data transer is taking place the system may be temporarily be a little
overwhelmed.

Additionally I would not suggest enabling full encryption functionality
as this may further strain the limited CPU resources of the unit.
