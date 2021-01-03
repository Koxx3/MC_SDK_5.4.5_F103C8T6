# PINs for the Xiaomi power
${ Mcu.PINs("PC14-OSC32_IN", "PC15-OSC32_OUT") }
#
# Power and Enable buttons
PC14-OSC32_IN.GPIOParameters=GPIO_Label
PC14-OSC32_IN.GPIO_Label=PWR_BTN
PC14-OSC32_IN.Locked=true
PC14-OSC32_IN.Signal=GPIO_Input
PC15-OSC32_OUT.GPIOParameters=PinState,GPIO_Label
PC15-OSC32_OUT.GPIO_Label=TPS_ENA
PC15-OSC32_OUT.Locked=true
PC15-OSC32_OUT.PinState=GPIO_PIN_SET
PC15-OSC32_OUT.Signal=GPIO_Output
#