/**
  * @page Ramp generation with CCMRAM usage in an STM32F303 based single drive configuration
  * 
  * @verbatim
  ********************** (C) COPYRIGHT 2020 STMicroelectronics *******************
  *
  * @file    NUCLEO-G431RB\Demonstration\CCMRAM\readme.txt 
  *
  * @author  Motor Control SDK Team
  * @brief   How to generate a Speed Ramp and use the CCMRAM.
  ******************************************************************************
  * This notice applies to any and all portions of this file
  * that are not between comment pairs USER CODE BEGIN and
  * USER CODE END. Other portions of this file, whether 
  * inserted by the user or by software development tools
  * are owned by their respective copyright owners.
  *
  * Copyright (c) 2020 STMicroelectronics International N.V. 
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
  * This demonstration shows how the Motor Control SDK uses the CCMRAM present on  
  * some STM32 devices: it places some of the critical Motor Control routines in 
  * CCMRAM. 
  *
  * This demonstration uses the following API of the Motor Control library:
  * 
  * - MC_StartMotor1()
  * - MC_StopMotor1()
  *
  * It also defines the following preprocessor symbol to trigger the use of the CCMRAM:
  *
  * - CCMRAM
  *
  * For more information on the usage of CCMRAM in software projects on STM32, refer to 
  * Application Note AN4296 "Overview and tips for using STM32F303/328/334/358xx CCM RAM
  * with IAR EWARM, Keil MDK-ARM and GNU-based toolchains", available on the ST website:
  * https://www.st.com.
  * 
  * @par Directory contents 
  * 
  * - NUCLEO-G431RB\Demonstration\CCMRAM\Src\main.c   Main C source code
  * - NUCLEO-G431RB\Demonstration\CCMRAM\Src\ramp.c   Example configuration file
  * 
  * @par Hardware and Software environment 
  * 
  * - This demonstration runs on a NUCLEO-G431RB + X-NUCLEO-IHM07M1 + Shinano setup.
  * - This demonstration can be run on different board if configured with the ST MC Workbench.
  * 
  * @par How to use it ? 
  * 
  * In order to make the program work, you must do the following:
  *
  * 1. Open the file CCMRAM.stmcx with ST Motor Control Workbench and save 
  *    it to another, empty, location.
  *    BEWARE: Do not change the name of the CCMRAM.stmcx file, otherwise the 
  *            example will not work properly;
  * 2. Click on the "Generate" button to create the demonstration source code, selecting the IDE to use: 
  *    EWARM or MDK-ARM or ST cubeIDE;
  * 3. Open the generated project with this IDE;
  * 5. Build the project and load the resulting binary image into your MCU board;
  * 6. Reset your MCU board;
  * 7. Run the example.
  * 
  * 
  * ******************** (C) COPYRIGHT 2020 STMicroelectronics *******************
 **/