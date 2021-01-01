<#if ! _device_name_mapping_ftl?? >
    <#global _device_name_mapping_ftl = 1>
<#-- +----------------------------------+-----------------+---------------------------------------------------------------------------------------------+-----------------------------------------+
     | Label used in WB views           | #define         |     #assign to be generated for the ioc file                                                |  used in the header file                |
     |                                  | generated by WB |                                                                                             |                                         |
+====+==================================+=================+====================+=================+=================+==================+====+============+=========================================+
|  1 | STM32F030x                       |  STM32F030x     | CS_STM32F0xx       |                 |                 |                  |    |            | #include "Parameters conversion_F0xx.h" |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  |    |            |                                         +
|  2 | STM32F031x                       |  STM32F031x     | CS_STM32F0xx       |                 |                 |                  |    |            |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  |    |            |                                         +
|  3 | STM32F050x                       |  STM32F050x     | CS_STM32F0xx       |                 |                 |                  |    |            |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  | F0 | STM32F0XX  |                                         +
|  4 | STM32F051x                       |  STM32F051x     | CS_STM32F0xx       |                 |                 |                  |    |            |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  |    |            |                                         +
|  5 | STM32F072x                       |  STM32F072x     | CS_STM32F0xx       |                 |                 |                  |    |            |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  |    |            +-----------------------------------------+
|  6 | STSPIN32F0                       |  STSPIN32F0     |                    |                 |                 |                  |    |            | #include "Parameters conversion_F0xx.h" |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  |    |            +-----------------------------------------+
|  7 | STSPIN32F0A                      |  STSPIN32F0A    |                    |                 |                 |                  |    |            | #include "Parameters conversion_F0xx.h" |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  |    |            +-----------------------------------------+
|  8 | STSPIN32F0601                    |  STSPIN32F0601  |                    |                 |                 |                  |    |            |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  |    |            +-----------------------------------------+
|  9 | STSPIN32F0602                    |  STSPIN32F0602  |                    |                 |                 |                  |    |            |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  |    |            +-----------------------------------------+
| 10 | STSPIN32F0251                    |  STSPIN32F0251  |                    |                 |                 |                  |    |            |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  |    |            +-----------------------------------------+
| 11 | STSPIN32F0252                    |  STSPIN32F0252  |                    |                 |                 |                  |    |            |                                         |
+====+==================================+=================+====================+=================+=================+==================+====+============+=========================================+
| 12 | STM32F100 Low Density            |  STM32F100x_LD  | STM32VALUELD       | STM32F10X_LD_VL | STM32F10X_MD_VL | STM32VALUE       |    |            | #include "Parameters conversion_F10x.h" |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+    |            |                                         +
| 13 | STM32F100 Medium Density         |  STM32F100x_MD  | STM32VALUEMD       | STM32F10X_MD_VL |                 | STM32VALUE       |    |            |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+    |            |                                         +
| 14 | STM32F103 High Density           |  STM32F103x_HD  | STM32PERFORMANCEHD | STM32F10X_HD    |                 | STM32HD          | F1 | STM32F1XX  |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+    |            |                                         +
| 15 | STM32F103 Low Density            |  STM32F103x_LD  | STM32PERFORMANCELD | STM32F10X_LD    | STM32F10X_MD    | STM32PERFORMANCE |    |            |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+    |            |                                         +
| 16 | STM32F103 Medium Density         |  STM32F103x_MD  | STM32PERFORMANCEMD | STM32F10X_MD    |                 | STM32PERFORMANCE |    |            |                                         |
+====+==================================+=================+====================+=================+=================+==================+====+============+=========================================+
| 17 | STM32F2xx                        |  STM32F2xx      | CS_STM32F2xx       |                 |                 |                  | F2 | STM32F2XX  | #include "Parameters conversion_F2xx.h" |
+====+==================================+=================+====================+=================+=================+==================+====+============+=========================================+
| 18 | STM32F301x6/8 - STM32F302x6/8    |  STM32F302X8    | STM32F302X8        |                 |                 |                  |    |            | #include "Parameters conversion_F30x.h" |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  |    |            +-----------------------------------------+
| 19 | STM32F302xB                      |  STM32F302xB    | CS_STM32F30x       |                 |                 |                  |    |            |                                         |
+----+----------------------------------+-----------------+--------------------|                 |-----------------+                  |    |            |                                         +
| 20 | STM32F302xC                      |  STM32F302xC    | CS_STM32F30x       | STM32F302X      |                 |                  | F3 | STM32F30X  |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+                  |    |            |                                         +
| 21 | STM32F303xB                      |  STM32F303xB    | CS_STM32F30x       |                 |                 |                  |    |            |                                         |
+----+----------------------------------+-----------------+--------------------|                 +-----------------+                  |    |            |                                         +
| 22 | STM32F303xC OR STM32F303xE       |  STM32F303xC    | CS_STM32F30x       | STM32F303X      |                 |                  |    |            |                                         |
+====+==================================+=================+====================+=================+=================+==================+====+============+=========================================+
| 23 | STM32F446xC-xE                   |  STM32F446xC_xE | STM32F446xx        |                 |                 |                  |    |            | #include "Parameters conversion_F4xx.h" |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+ F4 + STM32F4XX  |                                         +
| 24 | STM32F4xx                        |  STM32F4xx      | CS_STM32F4xx       |                 |                 | STM32F40XX       |    |            |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+                 |                                         +
| 25 | STM32F401XX                      |  STM32F401XX    | CS_STM32F401XX     |                 |                 | STM32F401XX      |    |            |                                         |
+====+==================================+=================+====================+=================+=================+==================+====+============+=========================================+
| 26 | STM32L476xx                      |  STM32L476XX    | STM32L476xx        |                 |                 | STM32L476XX      |    |            |                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+ L4 + STM32L4XX  |                                         +
| 27 | STM32L452xx                      |  STM32L452XX    | STM32L452xx        |                 |                 | STM32L452XX      |    |            |                                         |
+====+==================================+=================+====================+=================+=================+==================+====+============+=========================================+
| 28 | STM32F746XX                      |  STM32F746XX    | STM32F746XX        |                 |                 | STM32F746XX      | F7 + STM32F746XX|                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+                                                           +
| 29 | STM32F769XX                      |  STM32F769XX    | STM32F769XX        |                 |                 | STM32F769XX      | F7 + STM32F769XX|                                         |
+====+==================================+=================+====================+=================+=================+==================+====+============+=========================================+
| 30 | STM32G071xx                      |  STM32G071XX    | STM32G071XX        |                 |                 | STM32G071XX      | G0 + STM32G071XX|                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+                                                           +
| 31 | STM32G081xx                      |  STM32G081XX    | STM32G081XX        |                 |                 | STM32G081XX      | G0 + STM32G081XX|                                         |
+====+==================================+=================+====================+=================+=================+==================+====+============+=========================================+
| 32 | STM32G431CB                      |  STM32G431CB    | STM32G431CB        |                 |                 | STM32G431CB      | G4 + STM32G431CB|                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+-----------------+                                         +
| 33 | STM32G431RB                      |  STM32G431RB    | STM32G431RB        |                 |                 | STM32G431RB      | G4 + STM32G431RB|                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+-----------------+                                         +
| 34 | STM32G474QE                      |  STM32G474QE    | STM32G474QE        |                 |                 | STM32G474QE      | G4 + STM32G474QE|                                         |
+----+----------------------------------+-----------------+--------------------+-----------------+-----------------+------------------+-----------------+=========================================+
| 35 | STM32H745XX                      |  STM32H745XX    | STM32H745XX        |                 |                 | STM32H745XX      | H7 + STM32H745XX|                                         |
+====+==================================+=================+====================+=================+=================+==================+====+============+=========================================+
-->


<#include "utils.ftl" >
<#function mcu_type>
    <#if MCU_TYPE??>
        <#return MCU_TYPE >
    <#else>
         <#--  1 --> <#if     defined(STM32F030x)    > <#return "STM32F030x"    >
         <#--  2 --> <#elseif defined(STM32F031x)    > <#return "STM32F031x"    >
         <#--  3 --> <#elseif defined(STM32F050x)    > <#return "STM32F050x"    >
         <#--  4 --> <#elseif defined(STM32F051x)    > <#return "STM32F051x"    >
         <#--  5 --> <#elseif defined(STM32F072x)    > <#return "STM32F072x"    >
         <#--  6 --> <#elseif defined(STSPIN32F0)    > <#return "STSPIN32F0"    >
         <#--  7 --> <#elseif defined(STSPIN32F0A)   > <#return "STSPIN32F0A"   >
         <#--  8 --> <#elseif defined(STSPIN32F0601)   > <#return "STSPIN32F0601"   >
         <#--  9 --> <#elseif defined(STSPIN32F0602)   > <#return "STSPIN32F0602"   >
         <#-- 10 --> <#elseif defined(STSPIN32F0251)   > <#return "STSPIN32F0251"   >
         <#-- 11 --> <#elseif defined(STSPIN32F0252)   > <#return "STSPIN32F0252"   >
         <#-- 12 --> <#elseif defined(STM32F100x_LD) > <#return "STM32F100x_LD" >
         <#-- 13 --> <#elseif defined(STM32F100x_MD) > <#return "STM32F100x_MD" >
         <#-- 14 --> <#elseif defined(STM32F103x_HD) > <#return "STM32F103x_HD" >
         <#-- 15 --> <#elseif defined(STM32F103x_LD) > <#return "STM32F103x_LD" >
         <#-- 16 --> <#elseif defined(STM32F103x_MD) > <#return "STM32F103x_MD" >
         <#-- 17 --> <#elseif defined(STM32F2xx)     > <#return "STM32F2xx"     >
         <#-- 18 --> <#elseif defined(STM32F302X8)   > <#return "STM32F302X8"   >
         <#-- 19 --> <#elseif defined(STM32F302xB)   > <#return "STM32F302xB"   >
         <#-- 20 --> <#elseif defined(STM32F302xC)   > <#return "STM32F302xC"   >
         <#-- 21 --> <#elseif defined(STM32F303xB)   > <#return "STM32F303xB"   >
         <#-- 22 --> <#elseif defined(STM32F303xC)   > <#return "STM32F303xC"   >
         <#-- 23 --> <#elseif defined(STM32F446xC_xE)> <#return "STM32F446xC_xE">
         <#-- 24 --> <#elseif defined(STM32F4xx)     > <#return "STM32F4xx"     >
         <#-- 25 --> <#elseif defined(STM32F401XX)   > <#return "STM32F401XX"   >
         <#-- 26 --> <#elseif defined(STM32L476XX)   > <#return "STM32L476XX"   >
         <#-- 27 --> <#elseif defined(STM32L452XX)   > <#return "STM32L452XX"   >
         <#-- 28 --> <#elseif defined(STM32F746XX)   > <#return "STM32F746XX"   >
         <#-- 29 --> <#elseif defined(STM32F769XX)   > <#return "STM32F769XX"   >
         <#-- 30 --> <#elseif defined(STM32G071XX)   > <#return "STM32G071XX"   >
         <#-- 31 --> <#elseif defined(STM32G081XX)   > <#return "STM32G081XX"   >
         <#-- 32 --> <#elseif defined(STM32G431CB)   > <#return "STM32G431CB"   >
         <#-- 33 --> <#elseif defined(STM32G431RB)   > <#return "STM32G431RB"   >
         <#-- 34 --> <#elseif defined(STM32G474QE)   > <#return "STM32G474QE"   >
         <#-- 35 --> <#elseif defined(STM32H745XX)   > <#return "STM32H745XX"   >
                     <#else                          > <#return "UNKNOWN_MCU"   ></#if>
    </#if>
</#function>
<#macro device_mapping >
    <#local MCU_TYPE = mcu_type()>
    <#local device =
<#--    |         #define by WB    | extra #define that have to be generated                                                             -->
<#--  1 |   --> { "STM32F030x"     : [                     "F0", "STM32F0XX"]
<#--  2 |   --> , "STM32F031x"     : [                     "F0", "STM32F0XX"]
<#--  3 | F0--> , "STM32F050x"     : [                     "F0", "STM32F0XX"]
<#--  4 |   --> , "STM32F051x"     : [                     "F0", "STM32F0XX"]
<#--  5 |   --> , "STM32F072x"     : [                     "F0", "STM32F0XX"]
<#--  6 |   --> , "STSPIN32F0"     : [                     "F0", "STM32F0XX"]
<#--  7 |   --> , "STSPIN32F0A"    : [                     "F0", "STM32F0XX"]
<#--  8 |   --> , "STSPIN32F0601"  : [                     "F0", "STM32F0XX"]
<#--  9 |   --> , "STSPIN32F0602"  : [                     "F0", "STM32F0XX"]
<#-- 10 |   --> , "STSPIN32F0251"  : [                     "F0", "STM32F0XX"]
<#-- 11 |   --> , "STSPIN32F0252"  : [                     "F0", "STM32F0XX"]

<#-- 12 |   --> , "STM32F100x_LD"  : ["STM32VALUE"       , "F1", "STM32F1XX"]
<#-- 13 |   --> , "STM32F100x_MD"  : ["STM32VALUE"       , "F1", "STM32F1XX"]
<#-- 14 | F1--> , "STM32F103x_HD"  : ["STM32HD"          , "F1", "STM32F1XX"]
<#-- 15 |   --> , "STM32F103x_LD"  : ["STM32PERFORMANCE" , "F1", "STM32F1XX"]
<#-- 16 |   --> , "STM32F103x_MD"  : ["STM32PERFORMANCE" , "F1", "STM32F1XX"]

<#-- 17 | F2--> , "STM32F2xx"      : [                     "F2", "STM32F2XX"]
                                                           
<#-- 18 |   --> , "STM32F302X8"    : [                     "F3", "STM32F30X"]
<#-- 19 |   --> , "STM32F302xB"    : [                     "F3", "STM32F30X"]
<#-- 20 | F3--> , "STM32F302xC"    : [                     "F3", "STM32F30X"]
<#-- 21 |   --> , "STM32F303xB"    : [                     "F3", "STM32F30X"]
<#-- 22 |   --> , "STM32F303xC"    : [                     "F3", "STM32F30X"]
                                                           
<#-- 23 | F4--> , "STM32F446xC_xE" : [                     "F4", "STM32F4XX"]
<#-- 24 |   --> , "STM32F4xx"      : [                     "F4", "STM32F4XX"]
<#-- 25 |   --> , "STM32F401XX"    : [                     "F4", "STM32F401XX"]

<#-- 26 | L4--> , "STM32L476XX"    : [                     "L4", "STM32L476XX"]
<#-- 27 | L4--> , "STM32L452XX"    : [                     "L4", "STM32L452XX"]

<#-- 28 | F7--> , "STM32F746XX"    : [                     "F7", "STM32F746XX"]
<#-- 29 | F7--> , "STM32F769XX"    : [                     "F7", "STM32F769XX"]

<#-- 30 | G0--> , "STM32G071XX"    : [                     "G0", "STM32G071XX"]
<#-- 31 | G0--> , "STM32G081XX"    : [                     "G0", "STM32G081XX"]

<#-- 32 | G4--> , "STM32G431RB"    : [                     "G4", "STM32G431RB"]

<#-- 33 | G4_ESC--> , "STM32G431CB": [                     "G4", "STM32G431CB"]

<#-- 34 | G4--> , "STM32G474QE"    : [                     "G4", "STM32G474QE"]

<#-- 35 | H7--> , "STM32H745XX"    : [                     "H7", "STM32H745XX"]

<#--        --> , "UNKNOWN_MCU"    : []
    }>
    <#list device[MCU_TYPE] as def>
        <@'<#global ${def}=true>'?interpret />
    </#list>
</#macro>
<@device_mapping />
</#if>