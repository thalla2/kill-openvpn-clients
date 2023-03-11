Requirements: 

- OpenVPN community edition
- The 'management' option turned on in server.conf 
  [root@vpn:/root]$ grep management /etc/openvpn/server/server.conf
  management 127.0.0.1 7505
  [root@vpn:/root]$
- nc

Install: 
- Download kill_vpn_clients.sh and place it on your server
- Edit the variables to meet your specific needs
- Add it to cron to run $x minutes/hours
