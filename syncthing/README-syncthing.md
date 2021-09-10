# README-syncthing.md
Syncthing is a modern, open source file synchronisation tool.

https://syncthing.net/

This tool only works on the Seagate Central if it has an upgraded
Linux kernel installed as per the 
Seagate-Central-Slot-In-v5.x-Kernel
project at

https://github.com/bertofurth/Seagate-Central-Slot-In-v5.x-Kernel

syncthing will not work with the original Seagate Central kernel.

# Obtain syncthing
## Option 1 - Download syncthing
You can download the precompiled **Linux ARM** version of syncthing
from the syncthing page at

https://syncthing.net/downloads/

The downloaded file will be a tar.gz archive that can be extracted
with the "tar -xf" command. 

The "syncthing" binary in the extracted folder is the one that needs
to be transferred to the Seagate Central.

## Option 2 - Cross compile syncthing
Make sure you have the most recent version of "go" installed on
your build system. As of writing this is "go1.16".

Download and extract the latest stable version of syncthing source
code. In this example we download version 1.18.2

    wget https://github.com/syncthing/syncthing/releases/download/v1.18.2/syncthing-source-v1.18.2.tar.gz
    tar -xf syncthing-source-v1.18.2.tar.gz

Change into the extracted source code directory and execute the 
following command to cross compile syncthing for the arm 32 
platform

     go run build.go -goos linux -goarch arm build

A new file called "syncthing" will be built. It should be about 20M 
in size.

# syncthing.sh
syncthing does not come with an "init" based startup script so I 
have created my own very simple one as seen in this project directory
called "syncthing.sh".

Note that this script assumes that there is a user called "syncthing"
that will be running the syncthing service. For this reason you should
either edit the script to use a different existing Seagate Central user
or create a user "syncthing" on the Seagate Central using the Web 
Management interface.

Also be aware that the script is setup to activate the syncthing GUI
on port 8384 of the Segate Central Ethernet interface. If this is not
desirable then the script needs to be edited accordingly.

## Transfer syncthing to the Seagate Central
Copy "syncthing" and "syncthing.sh" to the Seagate Central.

## Install syncthing on the Seagate Central
Log into the Seagate Central via ssh and issue the su command to become
the root user.

Copy the syncthing binary to the /usr/bin directory and make sure to set
the appropriate file permissions.

    install -o root -m 755 syncthing /usr/bin

Install the syncthing.sh startup script

    install -o root -m 755 syncthing.sh /etc/init.d

Configure the script to be invoked at system startup.

    update-rc.d syncthing.sh defaults 30

## Start syncthing and configure a GUI password
Start syncthing by rebooting the Seagate Central or manually by issuing
the following command.

/etc/init.d/syncthing.sh start

Once syncthing has started for the first time, log in to the configuration 
gui webpage by browsing to port 8384 of your NAS IP address. For example

    http://192.168.1.99:8384

When you initially log in to the GUI you will be confronted with a warning
message asking you to configure a password for the GUI straight away. 

## Troubleshooting
The syncthing logs are located at /var/log/syncthing

I would suggest that since the Seagate Central is not a particularly powerful
platform that you only give syncthing "light" duties. 


