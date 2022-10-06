# README-networking.md
A set of networking tools that aid in troubleshooting and
configuring networking on the Seagate Central.

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for notes and procedures specific to these tools.

# NOTICE : THIS IS A WORK IN PROGRESS.
Everything seems to be working at the moment but still needs tidying up.

## iperf
A tool that helps to analyze networking performance between
a "client" and a "server" device. 

https://iperf.fr/

## netstat
A full featured version of the useful "netstat" tool for showing
network connections.

## ethtool
View and change low level driver characteristics for the ethernet
interface.

## iproute2
The standard "ip" commands that can be used to configure and view
network settings. Includes commands ip, ss, nstat and others.

## dropwatch
Monitor packet drops. This requires that the kernel on the unit be
recompiled with the CONFIG_NET_DROP_MONITOR flag enabled.

## Build Procedure
### Source code download and extraction
Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically by running the
**download-src-networking.sh** script.

See the **download-src-networking.sh** script for version numbers
and source package URLs.
    
## "iperf" basic usage
Start a process on a listening "server" as follows.

    iperf3 -s 
    
On the "client" issue the following command to test transmission speeds
from the client to the server.

    iperf3 -c <server-ip-address>

On the "client" issue the following command to test transmission speeds
from the server to the client

    iperf3 -c <server-ip-address> -R

Both the server and the client will report statistics about how fast a
network stream was maintained.

## "netstat" basic usage

     netstat -a

## "ethtool" basic usage

    ethtool eth0 
    ethtool -k eth0 : Show basic offload properties
    ethtool -K eth0 FEATURE <on/off> : Enable or disable features
    ethtool -g eth0 : Show ethernet tx/rx ring properties

## "dropwatch" basic usage
There is only one command line option for "dropwatch" so it is almost always
invoked as follows.

    dropwatch -lkas
    
Then at the dropwatch prompt issue the "start" command. Hit CTRL-C to end 
monitoring.

    dropwatch> start
    
Note again that the kernel must be recompiled with the CONFIG_NET_DROP_MONITOR
option enabled for this tool to be able to monitor drops.
