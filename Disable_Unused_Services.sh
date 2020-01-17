#!/bin/bash

Services(){

echo "####################################################################"
echo "##----Script to Disable Unused & Insecure Services on IN nodes----##"
echo "##-----------Name:Issahaku Kamil | UserID : EKAMISS---------------##"
echo "####################################################################"

ExtrTimeStamp=$(date "+%Y-%m-%d_%H-%M-%S")
echo ""
echo "Note the Date-Time-Stamp in case of a rollback:$ExtrTimeStamp"
echo ""

echo ""
echo "Please Disable Unused and Insecure Services that might be available and"
echo "runnung on the RHEL Operating System. MTN Security Baseline recommends" 
echo "that these services to be disabled: chargen, daytime, discard ,echo, time,"
echo "tftp and xinetd. You have the options to choose whether to install these services or not."
echo ""

# Disable/Enable Chargen Service
echo "Do you want to disable chargen service? yes/no"
read charg
charg=${charg^^}
if [[ "$charg" == "YES" ]]
then
	echo "Disabling chargen service .."
	#Disable chargen service
	chkconfig chargen-dgram off 
	chkconfig chargen-stream off
	status="$?"
	if [[ $status="0" ]]
	then
        	echo ""
        	echo "Chargen Service has been disabled Successfully"
        	echo ""
	elif [[ $status="1" ]]
	then
        	echo ""
		echo "Failed to Disable Chargen, Service not available"
        	echo ""
	else
		echo "exit status=$status"
	fi
elif [[ "$charg" == "NO" ]]
then
        echo ""
        echo "Aborting ..."
        echo ""
else
	echo "exit status=$status"
fi

# Disable Daytime Service
echo ""
echo "Do you want to disable daytime service? yes/no"
read dayt
dayt=${dayt^^}
if [[ "$dayt" == "YES" ]]
then
        echo "Disabling Daytime service .."
        #Disable Daytime service
        chkconfig daytime-dgram off
        chkconfig daytime-stream off
	status="$?"
        if [[ $status="0" ]]
        then
    		echo ""
        	echo "Daytime Service has been disabled Successfully"
        	echo ""
        elif [[ $status="1" ]]
        then
        	echo ""
        	echo "Failed to Disable Daytime, service not available"
        	echo ""
	else
		echo "exit status=$status"
	fi
elif [[ "$dayt" == "NO" ]]
then
        echo ""
        echo "Aborting ..."
        echo ""
else
        echo "exit status=$status"
fi

#Disable/Enable Echo Service
echo ""
echo "Do you want to disable echo service? yes/no"
read ech
ech=${ech^^}
if [[ "$ech" == "YES" ]]
then
        echo "Disabling Echo service .."
        #Disable Echo service
        chkconfig echo-dgram off
        chkconfig echo-stream off
	status="$?"
        if [[ $status="0" ]]
        then
                echo ""
                echo "Echo Service has been disabled Successfully"
                echo ""
        elif [[ $status="1" ]]
        then
                echo ""
                echo "<<<<<<<<<<<<Failed to Disable Echo>>>>>>>>>"
                echo ""
        else
                echo "exit status=$status"
        fi
elif [[ "$ech" == "NO" ]]
then
        echo ""
        echo "Aborting ..."
        echo ""
else
        echo "exit status=$status"
fi


#Disable/Enable time service
echo "Do you want to disable time service? yes/no"
read tim
tim=${tim^^}
if [[ "$tim" == "YES" ]]
then
        echo "Disabling Echo service .."
        #Disable Echo service
        chkconfig time-dgram off
        chkconfig time-stream off
	status="$?"
        if [[ $status="0" ]]
        then
                echo ""
                echo "Time Service has been disabled Successfully"
                echo ""
        elif [[ $status="1" ]]
        then
                echo ""
                echo "<<<<<<<<<<<<Failed to Disable Echo>>>>>>>>>"
                echo ""
        else
                echo "exit status=$status"
        fi
elif [[ "$tim" == "NO" ]]
then
        echo ""
        echo "Aborting ..."
        echo ""
else
        echo "exit status=$status"
fi


#Disable tftp service
echo "Do you want to disable tftp service? yes/no"
read tft
tft=${tft^^}
if [[ "$tft" == "YES" ]]
then
        echo "Disabling tftp service if available.."
        #Disable Echo service
        chkconfig tftp off
	status="$?"
        if [[ $status="0" ]]
        then
                echo ""
                echo "TFTP Service has been disabled Successfully"
                echo ""
        elif [[ $status="1" ]]
        then
                echo ""
                echo "<<<<<<<<<<<<Failed to Disable tftp>>>>>>>>>"
                echo ""
        else
                echo "exit status=$status"
        fi
elif [[ "$tft" == "NO" ]]
then
        echo ""
        echo "Aborting ..."
        echo ""
else
        echo "exit status=$status"
fi

#Disable xinetd service
echo "Do you want to disable xinetd service? yes/no"
read xinet
xinet=${xinet^^}
if [[ "$xinet" == "YES" ]]
then
        echo "Disabling xinetd service if available.."
        #Disable xinetd service
        systemctl disable xinetd
	status="$?"
        if [[ $status="0" ]]
        then
                echo ""
                echo "xinetd Service has been disabled Successfully"
                echo ""
        elif [[ $status="1" ]]
        then
                echo ""
                echo "<<<<<<<<<<<<Failed to Disable xinetd>>>>>>>>>"
                echo ""
        else
                echo "exit status=$status"
        fi
elif [[ "$xinet" == "NO" ]]
then
        echo ""
        echo "Aborting ..."
        echo ""
else
        echo "exit status=$status"
fi
echo ""

#Verify if "ntp" is installed and install if necessary
echo "Do you want to check to see if ntp is installed and enabled? yes/no"
read ntpchk
ntpchk=${ntpchk^^}
if [[ "$ntpchk" == "YES" ]]
then
	# RPM query for the ntp package
	rpm -q ntp > /tmp/ntp-package-chk
	packchk=`cat /tmp/ntp-package-chk`
	status="$?"
	if [[ $status="0" ]]
	then
		echo ""
		echo "NTP package is installed:$packchk"
		echo ""
	elif [[ $status="1" ]]
	then
		echo "NTP package is not installed"
		echo ""
		echo "Do you want to installed ntp"
		read instntp
		instntp=${instntp^^}
		if [[ "$instntp" == "YES" ]]
		then
			echo "Installing.."
			yum install ntp
			status="$?"
			if [[ $status="0" ]]
			then
				echo "ntp installed successfully"
			elif [[ $status="1" ]]
			then
				echo "Failed to install ntp"
			else
				echo "exit status=$status"
			fi
		elif [[ "$instntp" == "NO" ]]
		then
			echo "Aborting ..."
		else
			echo "exit status=$status"
		fi
	else
		echo "exit status=$status"
	fi
elif [[ "$ntpchk" == "NO" ]]
then
	echo "Aborting..."
else
	echo "exit status=$status"
fi

#Verify if "chrony" is installed and install if necessary
echo "Do you want to check to see if chrony is installed and enabled? yes/no"
read chrchk
chrchk=${chrchk^^}
if [[ "$chrchk" == "YES" ]]
then
        # RPM query for the chrony package
        rpm -q chrony
        status="$?"
        if [[ $status="0" ]]
        then
                echo ""
                echo "chrony package is installed:$packchr"
                echo ""
        elif [[ $status="1" ]]
        then
                echo "chrony package is not installed"
                echo ""
                echo "Do you want to install chrony"
                read instchr
                instchr=${instchr^^}
                if [[ "$instchr" == "YES" ]]
			then
                        echo "Installing.."
                        yum install chrony
                        status="$?"
                        if [[ $status="0" ]]
                        then
                                echo "chrony installed successfully"
                        elif [[ $status="1" ]]
                        then
                                echo "Failed to install chrony"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$instchr" == "NO" ]]
                then
                        echo "Aborting ..."
                else
                        echo "exit status=$status"
                fi
        else
                echo "exit status=$status"
        fi
elif [[ "$chrchk" == "NO" ]]
then
        echo "Aborting..."
else
        echo "exit status=$status"
fi

#Verify if "x window system" is installed and Disable
echo "Do you want to check to see if x window system is installed and enabled? yes/no"
read xchk
xchk=${xchk^^}
if [[ "$xchk" == "YES" ]]
then
        # RPM query for all the x window system package
        rpm -qa xorg-x11* 
        status="$?"
        if [[ $status="0" ]]
        then
                echo ""
                echo "x window system packages are installed and according MTN Security Compliance, this must be removed if not in any use"
		echo $xchr
                echo ""
		echo "Do you want to remove x window system? yes/no"
		read remxwin
		remxwin=${remxwin^^}
		if [[ "$remxwin" == "YES" ]]
		then
			yum remove xorg-x11*
			status="$?"
			if [[ $status="0" ]]
			then
				echo "x windows system removed successfully"
			elif [[ $status="1" ]]
			then
				echo "Failed to remove x window system utils"
			else
				echo "exit status=$status"
			fi
		elif [[ "$remxwin" == "NO" ]]
		then
			echo "Aborting..."
		else
			echo "exit status=$status"
		fi

        elif [[ $status="1" ]]
        then
                echo "x window system package is not available"
                echo ""
	else
                echo "exit status=$status"
        fi
elif [[ "$xchk" == "NO" ]]
then
	echo "Aborting..."
else
        echo "exit status=$status"
fi

#Disable avahi server
echo ""
echo "Checking to see if avahi-server is enabled"
echo ""
systemctl is-enabled avahi-daemon
status="$?"
if [[ "$status" == "0" ]]
then
        echo "Avahi Service is Installed and Enabled"
        echo "It is adviceable to disable this service to comply with CIS security compliance"
        echo "Do you want to disable this service daemon? yes/no"
	read Disavahi
	Disavahi=${Disavahi^^}
                if [[ "$Disavahi" == "YES" ]]
                then
                        systemctl disable avahi-daemon
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo " Avahi Daemon disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable avahi-daemon"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Disavahi" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                	echo ""
		fi			
elif [[ "$status" == "1" ]]
then
	echo "Avahi service is disabled successfully"
        echo ""
else
	echo "exit status=$status"
fi

#Disable CUPS
echo ""
echo "Checking to see if cups is enabled"
echo ""
systemctl is-enabled cups
status="$?"
if [[ "$status" == "0" ]]
then
        echo "CUPS is Installed and Enabled"
        echo "Disable this service to comply with CIS security compliance"
        echo "Do you want to disable this service"
	read Discups
	Discups=${Discups^^}
                if [[ "$Discups" == "YES" ]]                
                then
                        systemctl disable cups
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo " Cups disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable Cups"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Discups" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "CUPS  is not disabled"
else
	echo "exit status=$status"
fi

#Disable DHCP
echo ""
echo "Checking to see if DHCP is enabled"
echo ""
systemctl is-enabled dhcpd
status="$?"
if [[ "$status" == "0" ]]
then
        echo "DHCP is Enabled"
        echo "Disable this service if not required to comply with CIS security compliance"
        echo "Do you want to disable DHCP service? yes/no"
	read Disdhcp
	Disdhcp=${Disdhcp^^}
                if [[ "$Disdhcp" == "YES" ]]
                then
                        systemctl disable dhcpd
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo " DHCP disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable DHCP"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Disdhcp" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "DHCP  daemon is not disabled"
else
	echo "exit status=$status"
fi

#Disable telnet
echo ""
echo "Checking to see if Telnet is enabled"
echo ""
systemctl is-enabled telnet.socket
status="$?"
if [[ "$status" == "0" ]]
then
        echo "telnet is Installed and Enabled"
	echo "Disable this service to comply with CIS security compliance"
        echo "Do want to disable telnet service"
        read Distel
	Distel=${Distel^^}
                if [[ "$Distel" == "YES" ]]
                then
                        systemctl disable telnet.socket
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then 
                                echo " Telnet disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable Telnet"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Distel" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "Telnet  is not enabled"
else
	echo "exit status=$status"
fi

#Disable telnet-client
echo ""
echo "Checking to see if telnet-client is enabled"
echo ""
rpm -q telnet
status="$?"
if [[ "$status" == "0" ]]
then
        echo "telnet package is Installed"
        echo "Do you want to remove telnet client? yes/no"
	read Distelc
	Distelc=${Distelc^^}
                if [[ "$Distelc" == "YES" ]]
                then
                        yum remove telnet
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo " Telnet removed successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to remove Telnet"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Distelc" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "Telnet package is not installed"
else
        echo "exit status=$status"
fi

#Disable NFS
echo ""
echo "Checking to see if nfs is enabled"
echo ""
systemctl is-enabled nfs
status="$?"
if [[ "$status" == "0" ]]
then
        echo "NFS is Enabled"
        echo "Disable this service to comply with CIS security compliance"
        echo "Do you want to disable this service? yes/no"
        read Disnfs
	Disnfs=${Disnfs^^}
                if [[ "$Disnfs" == "YES" ]]
                then
                        systemctl disable nfs
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo " nfs disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable nfs"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Disnfs" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "nfs  is not enabled"
else
	echo "exit status=$status"
fi

#Disable NFS server
echo ""
echo "Checking to see if nfs-server is enabled"
echo ""
systemctl is-enabled nfs-server
status="$?"
if [[ "$status" == "0" ]]
then
        echo "NFS-server is Enabled"
        echo "Disable this service to comply with CIS security compliance"
        echo "Do you want to disable nfs-server service? yes/no"
	read Disnfc
	Disnfc=${Disnfc^^}
                if [[ "$Disnfc" == "YES" ]]
                then
                        systemctl disable nfs-server
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo " nfs-server disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable nfs-server"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Disnfc" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "nfs-server  is not enabled"
else
	echo "exit status=$status"
fi

#Disable rpc
echo ""
echo "Checking to see if nfs-server is enabled"
echo ""
systemctl is-enabled rpcbind
status="$?"
if [[ "$status" == "0" ]]
then
        echo "rpcbind is Enabled"
        echo "Disable this service to comply with CIS security compliance"
        echo "Do you want to disable rpcbind service? yes/no"
	read Disrpc
	Disrpc=${Disrpc^^}
                if [[ "$Disrpc" == "YES" ]]
                then
                        systemctl disable rpcbind
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo " rpc disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable rpc"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Disnfc" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "rpcbind  is not enabled"
else 
	echo"exit status=$status"
fi
#end

#Disable FTP
echo ""
echo "Checking to see if ftp is enabled"
echo ""
systemctl is-enabled vsftpd
status="$?"
if [[ "$status" == "0" ]]
then
        echo "FTP is Enabled"
        echo "Disable this service to comply with CIS security compliance"
        echo "Do want to disable ftp service? yes/no"
	read Disftp
	Disftp=${Disftp^^}
                if [[ "$Disftp" == "YES" ]]
                then
                        systemctl disable vsftpd
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo " vsftpd disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable vsftpd"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Disftp" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "ftp  is not enabled"
else
	echo "exit status=$status"

fi

#Disable Web Service
echo ""
echo "Checking to see if httpd is enabled"
echo ""
systemctl is-enabled httpd
status="$?"
if [[ "$status" == "0" ]]
then
        echo "web service is Enabled"
        echo "Disable this service to comply with CIS security compliance"
        echo "Do you want to disable httpd service..."
	read Dishttp
	Dishttp=${Dishttp^^}
                if [[ "$Dishttp" == "YES" ]]
                then
                        systemctl disable httpd
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo "http disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable http"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Dishttp" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "httpd  is not enabled"
else
	echo "exit status=$status"
fi

#Disable SMB
echo ""
echo "Checking to see if SMB is enabled"
echo ""
systemctl is-enabled smb
status="$?"
if [[ "$status" == "0" ]]
then
        echo "SMB is Enabled"
        echo "Disable this service to comply with CIS security compliance"
        echo "Disabling smb service..."
	read Dismb
	Dismb=${Dismb^^}
                if [[ "$Dismb" == "YES" ]]
                then
                        systemctl disable smb
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo "smb disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable smb"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Dismb" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "smb  is not enabled"
else
	echo "exit status=$status"
fi

#Disable IMAP and POP3
echo ""
echo "Checking to see if IMAP is enabled"
echo ""
systemctl is-enabled dovecot
status="$?"
if [[ "$status" == "0" ]]
then
        echo "IMAP and POP3 is Enabled"
        echo "Disable this service to comply with CIS security compliance"
        echo "DO you want to disable pop3 and imap service..."
	read Dismap
	Dismap=${Dismap^^}
                if [[ "$Dismap" == "YES" ]]
                then
                        systemctl disable dovecot
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo "imap/pop3 disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable imap/pop3"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Dismap" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "imap and pop3  is not enabled"
else
	echo "exit status=$status"
fi

#Disable NIS server
echo ""
echo "Checking to see if IMAP is enabled"
echo ""
systemctl is-enabled ypserv
status="$?"
if [[ "$status" == "0" ]]
then
        echo "NIS is Enabled"
        echo "Disable this service to comply with CIS security compliance"
        echo "Disabling NIS service..."
        read Disnis
	Disnis=${Disnis^^}
                if [[ "$Disnis" == "YES" ]]
                then
                        systemctl disable ypserv
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo "NIS disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable NIS"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Disnis" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
                fi
elif [[ "$status" == "1" ]]
then
        echo "NIS  is not enabled"
else
	echo "exit status=$status"
fi

#Disable NIS-client
echo ""
echo "Checking to see if IMAP is enabled"
echo ""
rpm -q ypbind
status="$?"
if [[ "$status" == "0" ]]
then
	echo "ypbind package is installed"
	echo "Do you want to disable ypbind? yes/no..."
	read Disnisc
	Disnisc=${Disnisc^^}
                if [[ "$Disnisc" == "YES" ]]
                then
                        systemctl disable dovecot
                        status="$?"
                        if [[ "$status" == "0" ]]
                        then
                                echo "imap/pop3 disabled successfully"
                        elif [[ "$status" == "1" ]]
                        then
                                echo "Failed to disable imap/pop3"
                        else
                                echo "exit status=$status"
                        fi
                elif [[ "$Disnis" == "NO" ]]
                then
                        echo "Aborting..."
                else
                        echo "exit status=$status"
                        echo ""
               	fi
elif [[ "$status" == "1" ]]
then
	echo "ypbind is not installed"
else
	exit 0;
fi
	

#Disable rsh-server
echo ""
echo "Checking to see if rsh-server is enabled"
echo ""
systemctl is-enabled rsh-socket
status="$?"
if [[ "$status" == "0" ]]
then
	echo "rsh-server is Enabled"
        echo "Kindly disable this service to comply with CIS security compliance"
        echo "Do you want ot disable rsh-server? yes/no..."
	read Disrsh
	Disrsh=${Disrsh^^}
                if [[ "$Disrsh" == "YES" ]]
                then
		        systemctl disable rsh-socket
        		status="$?"
        		if [[ "$status" == "0" ]]
        		then
                		echo "rsh is disabled successfully"
        		elif [[ "$status" == "1" ]]
        		then
                		echo "rsh was not disabled"
        		else
                		echo "exit status=$status" ;
        		fi
		elif [[ "$status" == "1" ]]
		then
        		echo "rsh  is not enabled"
		else
        		echo "exit status=$status"
		fi
elif [[ "$status" == "1" ]]
then
	echo "rsh-server is disabled"
else
	echo "status=$status"
fi
#Disable rsh-client
echo ""
echo "Checking to see if rsh-client is installed"
echo ""
rpm -q rsh
status="$?"
if [[ "$status" == "0" ]]
then
        echo "rsh-client package is installed"
	echo "Would you like to remove it? yes/no"
	yum remove rsh
        status="$?"
        if [[ "$status" == "0" ]]
        then
                echo "rsh has been removed successfully"
        elif [[ "$status" == "1" ]]
        then
                echo "Could not remove rsh"
        else
                exit 0;
        fi
elif [[ "$status" == "1" ]]
then
        echo "rsh is not installed"
else    
	echo "status=$status";
fi
echo ""
. rollback.sh
roll
}

