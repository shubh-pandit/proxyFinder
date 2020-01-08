# proxyFinder
A Visual Basic Script to find a working proxy in a network.


Iterates through the last two fragments of an IP address (172.16.XXX.XXX) to find a working proxy by pinging google.com. If a successful response is recieved, the proxy is displayed to the user. 

Requires guesswork to find the port (use the most common ones), and the first two fragments of the IP address. The port 8080 is used at default.

The server to be pinged can be changed at your own convenience if the requests get blocked at the server being used.

Finding a workable proxy may take 4-5 hours but the time taken can be reduced by using some guesswork.
