The OpenVPN server (community edition) doesn't support a "max connected" time.  This simple script will generate a list of users currently connected to the VPN and kill their session automatically once they reach the max connected time.  

Requirements: 

- OpenVPN community edition
- nc
- The 'management' value defined on in OpenVPN's server.conf <br /><br />
 
> [root@vpn:/root]$ grep management /etc/openvpn/server/server.conf<br />
> management 127.0.0.1 7505<br />
> [root@vpn:/root]$<br />

Install: 
- Download kill_vpn_clients.sh and place it on your server
- Edit the PORT, KILLTIME and TMPFILE to meet your specific needs<br />
>	PORT - Port of the "management" OpenVPN interface.<br />
>	KILLTIME - Number of seconds where it should kill a VPN session, default is 12 hours. <br />
>	TMPFILE - A temporary file used to parse the connected users<br />
- Add it to cron to run $x minutes/hours<br />
>	echo '0 * * * * root /root/kill_vpn_clients.sh >> /var/log/kill_vpn_clients.log' > /etc/cron.d/kill_vpn_clients
