# frp-related binaries
This folder is only for x64!!!
1. frpc -> The clinet of frp, should run on created dockers
2. frps -> The server of frp, should run on the machine with WAN ip
3. vpnPortManServer (home-made) -> a simple online database to maintain the allocated vpn ports, can be queried by websocket, should run on the machine with WAN ip
4. vpnPortManCli (home-made) -> to get  vpn port from vpnPortManServer, should run on created docker. usage: ./vpnPortManCli [ws:/{ip}:{port}] [message]
