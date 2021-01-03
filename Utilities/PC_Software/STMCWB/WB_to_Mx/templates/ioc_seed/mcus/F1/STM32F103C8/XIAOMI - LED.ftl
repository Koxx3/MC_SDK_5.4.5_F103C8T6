# PINs for the XIAOMI LED
${ Mcu.PINs("PD0-OSC_IN", "PD1-OSC_OUT") }
#
# LED GPIO
#
PD0-OSC_IN.Locked=false
PD1-OSC_OUT.Locked=true
PD1-OSC_OUT.GPIO_Label=LED
PD1-OSC_OUT.GPIOParameters=GPIO_Label
PD1-OSC_OUT.Signal=GPIO_Output
#