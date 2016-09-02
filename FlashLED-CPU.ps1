# Boobie Basix - LED Control Example
# Version: 0.1 - 2016/09/02
# Cobbled together by: Simon Lock (2016)
# WWW: www.aergan.com
# Twitter: twitter.com/a3rgan
#
# Description: Turns on PIN04 for 2 seconds when CPU Threshold is reached, then turns it back off again after 2 seconds when below threshold.
# Assumes you have set PIN04 as an Output.


$BB_COMPort = "COM12"    # COM Port Boobie Basix is on
$BB_PIN = "04"           # PIN LED is attached to
$CPU_Threshold = 40      # CPU Threshold as reported by Load Percentage


$BB_State = 0
$CPUValue = 0

$BoobieBasix = New-Object System.IO.Ports.SerialPort $BB_COMPort,57600,None,8,one
$BoobieBasix.Open()
$BoobieBasix.WriteLine(“w$($BB_PIN)1 `r”)
$BoobieBasix.Close()


Do {
    Start-Sleep 2
    $CPUValue = (Get-WmiObject win32_processor | Select LoadPercentage | Format-List | out-string).Trim(" .-`t`n`r") -replace "LoadPercentage : ", ""
    If ($CPUValue -ge $CPU_Threshold -and $BB_State -eq 0)
    {
        $BB_State = 1
        $BoobieBasix.Open()
        $BoobieBasix.WriteLine(“w$($BB_PIN)0 `r”)
        Start-Sleep -m 50
        $BoobieBasix.ReadExisting()
        $BoobieBasix.Close()
    }
    Start-Sleep 2
    If ($CPUValue -lt $CPU_Threshold -And $BB_State -eq 1)
    {
        $BB_State = 0
        $BoobieBasix.Open()
        $BoobieBasix.WriteLine(“w$($BB_PIN)1 `r”)
        Start-Sleep -m 50
        $BoobieBasix.ReadExisting()
        $BoobieBasix.Close()
      }
} while($True)
