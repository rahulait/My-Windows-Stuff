# Enabling Remote Desktop on Machine
(Get-WmiObject Win32_TerminalServiceSetting -Namespace root\cimv2\TerminalServices).SetAllowTsConnections(1,1) | Out-Null
(Get-WmiObject -Class "Win32_TSGeneralSetting" -Namespace root\cimv2\TerminalServices -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(0) | Out-Null

# Setting the network-adapter properties
$netadapter = Get-NetAdapter -Name Ethernet
$netadapter | Set-NetIPInterface -Dhcp Disabled
$netadapter | Net-NetIPAddress -IPAddress 10.2.20.51 -PrefixLength 21 -DefaultGateway 10.2.0.1
SetDnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "10.2.20.31, 171.70.168.183"

# Changing computer's name
$computername = Get-WmiObject Win32_ComputerSystem
$name = Read-Host -Prompt "Please Enter the ComputerName you want to use."
$computername.Rename($name)

# Adding machine to Domain
Add-Computer -DomainName VSGDEV -ComputerName "localhost" 