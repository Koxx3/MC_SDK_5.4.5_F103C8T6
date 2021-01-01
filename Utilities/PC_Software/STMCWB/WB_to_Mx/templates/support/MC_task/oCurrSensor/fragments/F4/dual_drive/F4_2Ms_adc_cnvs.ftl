<#import "../../../../ADC/ADC_cs_info.ftl" as info >

<#function F4_2Ms_adc_cnvs senses>
    <#local M1 = 1
            M2 = 2 >

    <#switch senses>
<#--####################################################################################################################
#                                                 F4 2Motors 3Sh - 3Sh                                                 #
########################################################################################################################
                                                       +-------+
                                       ( U )-----------|       |-----------( U )
                                                       | ADC_1 |
                    M1      M1    M1              +----|       |----+              M2      M2    M2M2
                    M1M1  M1M1  M1M1              |    +-------+    |              M2M2  M2M2  M2   M2
                    M1  M1  M1    M1   ( V )------+                 +-------( V )  M2  M2  M2      M2
                    M1      M1    M1              |    +-------+    |              M2      M2    M2
                    M1      M1    M1              +----|       |----+              M2      M2  M2M2M2
                                                       | ADC_2 |
                                       ( W )-----------|       |-----------( W )
                                                       +-------+                                                     -->
        <#case "3Sh_IR_3Sh_IR">
            <#local adc1_cnvs = [ info.adc_info(M1, "U")   ,   info.adc_info(M2, "U")
                                , info.adc_info(M1, "V")   ,   info.adc_info(M2, "V") ]

                    adc2_cnvs = [ info.adc_info(M1, "V")   ,   info.adc_info(M2, "V")
                                , info.adc_info(M1, "W")   ,   info.adc_info(M2, "W") ]>
            <#break>



<#--####################################################################################################################
#                                                 F4 2Motors 3Sh - ICS                                                 #
########################################################################################################################
                                                       +-------+
                                       ( U )-----------|       |
                                                       | ADC_1 |-----------( U )
                    M1      M1    M1              +----|       |                   M2      M2    M2M2
                    M1M1  M1M1  M1M1              |    +-------+                   M2M2  M2M2  M2   M2
                    M1  M1  M1    M1   ( V )------+                                M2  M2  M2      M2
                    M1      M1    M1              |    +-------+                   M2      M2    M2
                    M1      M1    M1              +----|       |                   M2      M2  M2M2M2
                                                       | ADC_2 |-----------( V )
                                       ( W )-----------|       |
                                                       +-------+                                                     -->
        <#case "3Sh_IR_ICS">
            <#local adc1_cnvs = [ info.adc_info(M1, "U")   ,    info.adc_info(M2, "U")
                                , info.adc_info(M1, "V")   ]

                    adc2_cnvs = [ info.adc_info(M1, "V")   ,    info.adc_info(M2, "V")
                                , info.adc_info(M1, "W")   ]>
            <#break>



<#--####################################################################################################################
#                                                 F4 2Motors ICS - 3Sh                                                 #
########################################################################################################################
                                                       +-------+
                                                       |       |-----------( U )
                                       ( U )-----------| ADC_1 |
                    M1      M1    M1                   |       |---+               M2      M2    M2M2
                    M1M1  M1M1  M1M1                   +-------+   |               M2M2  M2M2  M2   M2
                    M1  M1  M1    M1                               +-------( V )   M2  M2  M2      M2
                    M1      M1    M1                   +-------+   |               M2      M2    M2
                    M1      M1    M1                   |       |---+               M2      M2  M2M2M2
                                       ( V )-----------| ADC_2 |
                                                       |       |-----------( W )
                                                       +-------+                                                     -->
        <#case "ICS_3Sh_IR">
            <#local adc1_cnvs = [ info.adc_info(M1, "U")   ,    info.adc_info(M2, "U")
                                                           ,    info.adc_info(M2, "V") ]

                    adc2_cnvs = [ info.adc_info(M1, "V")   ,    info.adc_info(M2, "V")
                                                           ,    info.adc_info(M2, "W") ]>
            <#break>



<#--####################################################################################################################
#                                                 F4 2Motors ICS - ICS                                                 #
########################################################################################################################
                                                       +-------+
                                                       |       |
                                       ( U )-----------| ADC_1 |-----------( U )
                    M1      M1    M1                   |       |                   M2      M2    M2M2
                    M1M1  M1M1  M1M1                   +-------+                   M2M2  M2M2  M2   M2
                    M1  M1  M1    M1                                               M2  M2  M2      M2
                    M1      M1    M1                   +-------+                   M2      M2    M2
                    M1      M1    M1                   |       |                   M2      M2  M2M2M2
                                       ( V )-----------| ADC_2 |-----------( V )
                                                       |       |
                                                       +-------+                                                     -->
        <#case "ICS_ICS">
            <#local adc1_cnvs = [ info.adc_info(M1, "U")    ,   info.adc_info(M2, "U") ]

                    adc2_cnvs = [ info.adc_info(M1, "V")    ,   info.adc_info(M2, "V") ]>
            <#break >



        <#default >
            <#local adc1_cnvs = [] adc2_cnvs = []>
    </#switch>

    <#return [adc1_cnvs, adc2_cnvs]>
</#function>