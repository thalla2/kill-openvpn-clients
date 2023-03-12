Requirements: 

- OpenVPN community edition
- nc
- The 'management' value defined on in OpenVPN's server.conf
 
[root@vpn:/root]$ grep management /etc/openvpn/server/server.conf
management 127.0.0.1 7505
[root@vpn:/root]$

Install: 
- Download kill_vpn_clients.sh and place it on your server
- Edit the PORT, KILLTIME and TMPFILE to meet your specific needs
	PORT - Port of the "management" OpenVPN interface.
	KILLTIME - Number of seconds where it should kill a VPN session, default is 12 hours.  
	TMPFILE - A temporary file used to parse the connected users
- Add it to cron to run $x minutes/hours
	echo '0 * * * * root /root/kill_vpn_clients.sh >> /var/log/kill_vpn_clients.log' > /etc/cron.d/kill_vpn_clients


