/**
  * @page MCSDK - STEVAL-CTM010V1 + Selni
  *
  * @verbatim
  ********************** (C) COPYRIGHT 2019 STMicroelectronics *******************
  *
  * @file    STEVAL-CTM010V1\Demonstration\PositionControl\readme.txt 
  *
  * @author  Motor Control SDK Team
  * @brief   How to generate a Position Control mode.
  *
  ******************************************************************************
  * This notice applies to any and all portions of this file
  * that are not between comment pairs USER CODE BEGIN and
  * USER CODE END. Other portions of this file, whether 
  * inserted by the user or by software development tools
  * are owned by their respective copyright owners.
  *
  * Copyright (c) 2019 STMicroelectronics International N.V. 
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without 
  * modification, are permitted, provided that the following conditions are met:
  *
  * 1. Redistribution of source code must retain the above copyright notice, 
  *    this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of other 
  *    contributors to this software may be used to endorse or promote products 
  *    derived from this software without specific written permission.
  * 4. This software, including modifications and/or derivative works of this 
  *    software, must execute solely and exclusively on microcontroller or
  *    microprocessor devices manufactured by or for STMicroelectronics.
  * 5. Redistribution and use of this software other than as permitted under 
  *    this license is void and will automatically terminate your rights under 
  *    this license. 
  *
  * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS" 
  * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT 
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
  * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
  * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT 
  * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
  * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  * @endverbatim
  *
  * @par Demonstration description 
  * 
  * The example contains a demo of PFC on STEVAL-CTM010V1
  * 
  * 
  * @par Directory contents 
  * 
  * - "STEVAL-CTM010V1\Demonstration\PFC\PFC.stmcx"	Workbench project file.
  * 
  * @par Hardware and Software environment 
  * 
  * This demonstration runs on the [STEVAL-CTM010V1] + [Selni] HW setup.
  *   
  * @par How to use it ? 
  * 
  * In order to build the demonstration program, do the following:
  *
  * 1. Open the "PFC.stmcx" file with STM32 Motor Control Workbench PC software tool and save 
  *    it to another, empty, location.
  *    BEWARE: Do not change the name of the PFC.stmcx file, otherwise the 
  *            example will not work properly
  * 2. Click on the "update" button to create the demonstration source code, selecting the IDE 
  *    to use: EWARM, MDK-ARM or cubeIDE;
  * 3. Open the generated project with this IDE, if cubeIDE is selected then compile in release mode;
  * 4. Build the project and load the resulting binary image into your MCU board;
  * 5. Reset your MCU board;
  * 6. Run the example : through the STM32 MC Workbench monitor GUI (Start Motor), or/and by pressing the Start/Stop button.
  * 7. Reach at 100W power consumption
  * 8. got to "Registers" tab and click on "PFC Enable" button
  * 
  * ******************** (C) COPYRIGHT 2019 STMicroelectronics *******************
 **/