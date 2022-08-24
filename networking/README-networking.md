# README-networking.md
A set of networking tools that aid in troubleshooting and
configuring networking on the Seagate Central.

# NOTICE : THIS IS A WORK IN PROGRESS.
Everything seems to be working at the moment but still needs tidying up.

## iperf
A tool that helps to analyze networking performance between
a "client" and a "server" device. 

https://iperf.fr/

## ethtool
View and change low level driver characteristics for the ethernet
interface.

## netstat
A full featured version of the useful "netstat" tool for showing
network connections.

## dropwatch
Monitor packet drops

The build and installation instructions below are designed to be
read in conjunction with the main set of instructions in the
**README.md** file located in the base directory of the
Seagate-Central-Utils project. 

Refer to **README.md** for the overall guidelines and refer to the
instructions below for notes and procedures specific to "pEmacs".

## Build Procedure
### Source code download and extraction
Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically by running the
**download-src-networking.sh** script.

See the **download-src-networking.sh** script for version numbers
and source package URLs.
    
## "iperf" basic usage

From

https://www.tecmint.com/test-network-throughput-in-linux/

On the "server"

    iperf3 -s -f K 
    
On the "client"

    iperf3 -c <server-ip-address> -f K

## "ethtool" basic usage

    ethtool eth0 
    ethtool -k eth0 : Show basic offload properties
    ethtool -K eth0 FEATURE <on/off> : Enable or disable features

## "dropwatch" basic usage
There is only one command line option for "dropwatch" so it is almost always
invoked as follows.

    dropwatch -lkas
    
