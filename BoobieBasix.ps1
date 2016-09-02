# Boobie Basix - LED Control Example
# Version: 0.1 - 2016/09/02
# Cobbled together by: Simon Lock (2016)
# WWW: www.aergan.com
# Twitter: twitter.com/a3rgan
#
# Description: Turns on PIN04 for 5 seconds then turns it back off again. Assumes you have set PIN04 as an Output.

$BB_COMPort = "COM12"
$BB_PIN = "04"

$BoobieBasix = New-Object System.IO.Ports.SerialPort $BB_COMPort,57600,None,8,one
$BoobieBasix.Open()
$BoobieBasix.WriteLine(“d `r”)
Start-Sleep -m 50
$BoobieBasix.WriteLine(“w$($BB_PIN)0 `r”)
Start-Sleep -m 50
$BoobieBasix.ReadExisting()
Start-Sleep 5
$BoobieBasix.WriteLine(“w$($BB_PIN)1 `r”)
Start-Sleep -m 50
$BoobieBasix.ReadExisting()
$BoobieBasix.Close()
