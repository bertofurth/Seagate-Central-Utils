# README-iperf.md
iperf is a tool that helps to analyze networking performance between
a "client" and a "server" device. 

https://iperf.fr/

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

* iperf-3.11 - https://downloads.es.net/pub/iperf/iperf-3.11.tar.gz

Download the required source code archives for each component to 
the **src** subdirectory of the base working directory and extract
them. This can be done automatically for the versions listed above
by running the **download-src-iperf.sh** script.
    
## "iperf" basic usage

From

https://www.tecmint.com/test-network-throughput-in-linux/

On the "server"

    iperf3 -s -f K 
    
On the "client"

    iperf3 -c <server-ip-address> -f K

