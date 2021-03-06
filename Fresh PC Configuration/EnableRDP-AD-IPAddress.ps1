# Enabling Remote Desktop on Machine
(Get-WmiObject Win32_TerminalServiceSetting -Namespace root\cimv2\TerminalServices).SetAllowTsConnections(1,1) | Out-Null
(Get-WmiObject -Class "Win32_TSGeneralSetting" -Namespace root\cimv2\TerminalServices -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(0) | Out-Null

# Disable firewall
set-NetFirewallProfile -Profile Domain -Enabled False
set-NetFirewallProfile -Profile Public -Enabled False
set-NetFirewallProfile -Profile Private -Enabled False

# Setting the network-adapter properties
$netadapter = Get-NetAdapter -Name Ethernet
$netadapter | Set-NetIPInterface -Dhcp Disabled
$netadapter | New-NetIPAddress -IPAddress 10.2.20.91 -PrefixLength 16 -DefaultGateway 10.2.0.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "10.2.20.31,171.70.168.183"

# Changing computer's name
#$computername = Get-WmiObject Win32_ComputerSystem
#$name = Read-Host -Prompt "Please Enter the ComputerName you want to use."
#$computername.Rename($name)

# Adding machine to Domain
Add-Computer -DomainName VSGDEV -ComputerName "localhost" -newname "WIN-RAHUL"
restart-computer