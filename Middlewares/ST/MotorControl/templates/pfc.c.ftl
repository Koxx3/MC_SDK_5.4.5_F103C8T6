<#ftl strip_whitespace = true>
<#if !MC??>
	<#if SWIPdatas??>
	<#list SWIPdatas as SWIP>
		<#if SWIP.ipName == "MotorControl">
			<#if SWIP.parameters??>
			<#assign MC = SWIP.parameters>
			<#break>
			</#if>
		</#if>
	</#list>
	</#if>
	<#if MC??>
	<#else>
	<#stop "No MotorControl SW IP data found">
	</#if>
</#if>
<#-- Condition for STM32F302x8x MCU -->
<#assign CondMcu_STM32F302x8x = (McuName?? && McuName?matches("STM32F302.8.*"))>
<#-- Condition for STM32F072xxx MCU -->
<#assign CondMcu_STM32F072xxx = (McuName?? && McuName?matches("STM32F072.*"))>
<#-- Condition for STM32F030xxx MCU -->
<#assign CondMcu_STM32F030xxx = (McuName?? && McuName?matches("STM32F030.*"))>
<#-- Condition for Line STM32F1xx Value -->
<#assign CondLine_STM32F1_LD = (McuName?? && (McuName?matches("STM32F103.(4|6).*")))>
<#-- Condition for Line STM32F1xx Performance -->
<#assign CondLine_STM32F1_MD = (McuName?? && McuName?matches("STM32F103.(8|B).*"))>
<#-- Condition for Line STM32F1xx High Density -->
<#assign CondLine_STM32F1_HD = (McuName?? && McuName?matches("STM32F103.(C|D|E|F|G).*")) >
<#-- Condition for STM32F0 Family -->
<#assign CondFamily_STM32F0 = (FamilyName?? && FamilyName=="STM32F0")>
<#-- Condition for STM32F1 Family -->
<#assign CondFamily_STM32F1 = (CondLine_STM32F1_LD || CondLine_STM32F1_MD || CondLine_STM32F1_HD)>
<#-- Condition for STM32F3 Family -->
<#assign CondFamily_STM32F3 = (FamilyName?? && FamilyName == "STM32F3") >
<#-- Condition for STM32F4 Family -->
<#assign CondFamily_STM32F4 = (FamilyName?? && FamilyName == "STM32F4") >
<#-- Condition for STM32G4 Family -->
<#assign CondFamily_STM32G4 = (FamilyName?? && FamilyName == "STM32G4") >
<#-- Condition for STM32L4 Family -->
<#assign CondFamily_STM32L4 = (FamilyName?? && FamilyName == "STM32L4") >
<#-- Condition for STM32F7 Family -->
<#assign CondFamily_STM32F7 = (FamilyName?? && FamilyName == "STM32F7") >
<#-- Condition for STM32H7 Family -->
<#assign CondFamily_STM32H7 = (FamilyName?? && FamilyName == "STM32H7") >
<#-- Condition for STM32G0 Family -->
<#assign CondFamily_STM32G0 = (FamilyName?? && FamilyName=="STM32G0") >

<#if CondFamily_STM32F3>
  <#assign FIRST_TRIG_CH = "3" >
  <#assign SEC_TRIG_CH = "1" >
  <#assign DUTY_CH = "1" >
  <#assign TIM_TRIG = "TIMx_2" >
  <#assign TIM_AC_MAIN = "TIMx_2" >
  <#assign CH_AC_MAIN = "2" >  
<#elseif CondFamily_STM32F1>
  <#assign FIRST_TRIG_CH = "4" >
  <#assign SEC_TRIG_CH = "3" >
  <#assign DUTY_CH = "2" >
  <#assign TIM_TRIG = "TIMx" >
  <#assign TIM_AC_MAIN = "TIMx" >
  <#assign CH_AC_MAIN = "1" > 
</#if>

/**
  ******************************************************************************
  * @file    pfc.c
  * @author  Motor Control SDK Team, ST Microelectronics
  * @brief   This file provides firmware functions that implement the
  *          Power Factor Correction component of the Motor Control SDK.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2019 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under Ultimate Liberty license
  * SLA0044, the "License"; You may not use this file except in compliance with
  * the License. You may obtain a copy of the License at:
  *                             www.st.com/SLA0044
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "pfc.h"

/** @addtogroup MCSDK
  * @{
  */

/** @defgroup PFC Power Factor Correction
 *
  * @brief Power Factor Correction components of the Motor Control SDK
  *
  * TODO: Complete the documentation of the PFC doxygen group ...
  * @{
  */

/* External variables --------------------------------------------------------*/

/* Private typedef -----------------------------------------------------------*/

/* Private defines -----------------------------------------------------------*/
/* ADC masks */
#define CR2_EXTTRIG_EXTSELSOFT_SWSTART_Set  ((uint32_t)0x004E0000)
#define CR2_EXTTRIG_EXTSELT3TRGO ((uint32_t)0xFFB9FFFF)

/* ADC DISCEN mask */
#define CR1_DISCEN_Set              ((uint32_t)0x00000800)

#define SIN_COS_TABLE {\
0x0000,0x00C9,0x0192,0x025B,0x0324,0x03ED,0x04B6,0x057F,\
0x0648,0x0711,0x07D9,0x08A2,0x096A,0x0A33,0x0AFB,0x0BC4,\
0x0C8C,0x0D54,0x0E1C,0x0EE3,0x0FAB,0x1072,0x113A,0x1201,\
0x12C8,0x138F,0x1455,0x151C,0x15E2,0x16A8,0x176E,0x1833,\
0x18F9,0x19BE,0x1A82,0x1B47,0x1C0B,0x1CCF,0x1D93,0x1E57,\
0x1F1A,0x1FDD,0x209F,0x2161,0x2223,0x22E5,0x23A6,0x2467,\
0x2528,0x25E8,0x26A8,0x2767,0x2826,0x28E5,0x29A3,0x2A61,\
0x2B1F,0x2BDC,0x2C99,0x2D55,0x2E11,0x2ECC,0x2F87,0x3041,\
0x30FB,0x31B5,0x326E,0x3326,0x33DF,0x3496,0x354D,0x3604,\
0x36BA,0x376F,0x3824,0x38D9,0x398C,0x3A40,0x3AF2,0x3BA5,\
0x3C56,0x3D07,0x3DB8,0x3E68,0x3F17,0x3FC5,0x4073,0x4121,\
0x41CE,0x427A,0x4325,0x43D0,0x447A,0x4524,0x45CD,0x4675,\
0x471C,0x47C3,0x4869,0x490F,0x49B4,0x4A58,0x4AFB,0x4B9D,\
0x4C3F,0x4CE0,0x4D81,0x4E20,0x4EBF,0x4F5D,0x4FFB,0x5097,\
0x5133,0x51CE,0x5268,0x5302,0x539B,0x5432,0x54C9,0x5560,\
0x55F5,0x568A,0x571D,0x57B0,0x5842,0x58D3,0x5964,0x59F3,\
0x5A82,0x5B0F,0x5B9C,0x5C28,0x5CB3,0x5D3E,0x5DC7,0x5E4F,\
0x5ED7,0x5F5D,0x5FE3,0x6068,0x60EB,0x616E,0x61F0,0x6271,\
0x62F1,0x6370,0x63EE,0x646C,0x64E8,0x6563,0x65DD,0x6656,\
0x66CF,0x6746,0x67BC,0x6832,0x68A6,0x6919,0x698B,0x69FD,\
0x6A6D,0x6ADC,0x6B4A,0x6BB7,0x6C23,0x6C8E,0x6CF8,0x6D61,\
0x6DC9,0x6E30,0x6E96,0x6EFB,0x6F5E,0x6FC1,0x7022,0x7083,\
0x70E2,0x7140,0x719D,0x71F9,0x7254,0x72AE,0x7307,0x735E,\
0x73B5,0x740A,0x745F,0x74B2,0x7504,0x7555,0x75A5,0x75F3,\
0x7641,0x768D,0x76D8,0x7722,0x776B,0x77B3,0x77FA,0x783F,\
0x7884,0x78C7,0x7909,0x794A,0x7989,0x79C8,0x7A05,0x7A41,\
0x7A7C,0x7AB6,0x7AEE,0x7B26,0x7B5C,0x7B91,0x7BC5,0x7BF8,\
0x7C29,0x7C59,0x7C88,0x7CB6,0x7CE3,0x7D0E,0x7D39,0x7D62,\
0x7D89,0x7DB0,0x7DD5,0x7DFA,0x7E1D,0x7E3E,0x7E5F,0x7E7E,\
0x7E9C,0x7EB9,0x7ED5,0x7EEF,0x7F09,0x7F21,0x7F37,0x7F4D,\
0x7F61,0x7F74,0x7F86,0x7F97,0x7FA6,0x7FB4,0x7FC1,0x7FCD,\
0x7FD8,0x7FE1,0x7FE9,0x7FF0,0x7FF5,0x7FF9,0x7FFD,0x7FFE}

#define SIN_MASK        0x0300u
#define U0_90           0x0200u
#define U90_180         0x0300u
#define U180_270        0x0000u
#define U270_360        0x0100u

#define MAXFREQERRNO 4 /*!< Number of errors allowed on Mains frequency calc*/
#define MAXAMPLERRNO 4 /*!< Number of errors allowed on Mains amplitude calc*/
#define TIMREGSDELAY 34 /*clock cycles*/


/* Private macros ------------------------------------------------------------*/

/* Global variables ----------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/
static const int16_t hSin_Cos_Table2[256] = SIN_COS_TABLE;

/* Private function prototypes -----------------------------------------------*/
bool PFC_ON( PFC_Handle_t * pHandle );
static inline void PFC_CurrentRegulation( PFC_Handle_t * pHandle );
static bool PFC_StartUpVoltGen( PFC_Handle_t * pHandle );
static void PFC_VoltageRegulation( PFC_Handle_t * pHandle );
<#if CondFamily_STM32F3>
static void PFC_SetAOReferenceVoltage(uint32_t DAC_Channel, uint16_t hDACVref);
</#if>  

/* Functions -----------------------------------------------------------------*/

/**
 * @brief Initializes the PFC component pointed by @p pHandle
 */
__weak void PFC_Init( PFC_Handle_t * pHandle )
{
  int16_t hDutyCorrCk;
  int16_t hPropDelayCorrCk;
  int16_t hADCTrigCk;
  int16_t hADCTrigDualCk;
  int16_t hMinTonDualCk;
  ADC_TypeDef * ADCx = pHandle->pParams->ADCx; 
  TIM_TypeDef * TIMx = pHandle->pParams->TIMx;    
<#if CondFamily_STM32F3>  
  TIM_TypeDef * TIMx_2 = pHandle->pParams->TIMx_2;       
<#elseif CondFamily_STM32F1>
  DMA_TypeDef * DMAx = pHandle->pParams->DMAx;
</#if>  
  
  /* Initializing PID regulators for current and voltage */
  PID_HandleInit( & pHandle->cPICurr );                                                                             
  PID_HandleInit( & pHandle->cPIVolt );                                                                             

  /* Initializing the State Machine */
  STM_Init( & pHandle->pSTM );                                                                                      

  /* The PFC component is not enabled at startup */
  pHandle->bPFCen = false;                                                                                         

  /* Initializing the execution rate counters for the current and voltage loops */
  pHandle->bCurrLoopCnt = pHandle->pParams->bCurrentLoopRate;                                                        
  pHandle->bVoltLoopCnt = pHandle->pParams->bVoltageLoopRate;                                                        

  /* ADC is not PFC calibrated. This calibration is about getting the value that is measured by the ADC
   * when the motor is idle. This is used as an offset. */
  pHandle->bADCCalibrated = false;                                                                                      
  pHandle->bADCCalArrayIndex = 0; /* Initializing the ADC calibration array */                                          

  /* duty cycle correction, TIM cks*/
  hDutyCorrCk = pHandle->pParams->hPropDelayOffTimCk - pHandle->pParams->hPropDelayOnTimCk;                             
  /* propagation delay correction, TIM cks*/
  hPropDelayCorrCk = (pHandle->pParams->hPropDelayOffTimCk + pHandle->pParams->hPropDelayOnTimCk)/2;                    

  /* ADC trigger point when 1 sample is allowed, TIM cks*/
  hADCTrigCk =  pHandle->pParams->hADCLatencyTimeTimCk + pHandle->pParams->hADCSamplingTimeTimCk/2;                     
  /* ADC trigger point when 2 samples are allowed, TIM cks*/
  hADCTrigDualCk = pHandle->pParams->hADCLatencyTimeTimCk + pHandle->pParams->hADCSamplingTimeTimCk +           
                   pHandle->pParams->hADCConversionTimeTimCk/2;                                                         

  /* Min Ton for 2 samples*/
  hMinTonDualCk = pHandle->pParams->hADCSamplingTimeTimCk*2 + pHandle->pParams->hADCConversionTimeTimCk;                

  /* ADC total conversion time, TIM cks*/
  pHandle->hADCTotalCk = pHandle->pParams->hADCLatencyTimeTimCk + pHandle->pParams->hADCSamplingTimeTimCk*2 +
                         pHandle->pParams->hADCConversionTimeTimCk;                                                     

  /* Min duty*/
  pHandle->hMinDuty = pHandle->pParams->hADCSamplingTimeTimCk - hDutyCorrCk;
  if (pHandle->hMinDuty < 0)
  {
    pHandle->hMinDuty = 0;                                                                                              
  }

  pHandle->hMinDutyDualTrig = hMinTonDualCk - hDutyCorrCk; /* Min duty for the dual sampling strategy*/                 
  pHandle->h1SamplTrig = hPropDelayCorrCk - hADCTrigCk; /* sampling point correction for 1 sampling*/                   
  pHandle->h2SamplTrig = hPropDelayCorrCk - hADCTrigDualCk; /* sampling point correction for 2 samplings*/              

  /* Max TIM counter allowed to set CMR regs*/ /* TODO: Clarify ! */
  pHandle->hMaxTimCnt = pHandle->pParams->hPWMARR - (((uint64_t)TIMREGSDELAY) * 72000000uL)/pHandle->pParams->wCPUFreq;  

  pHandle->hMainsFrequencyHiCyc = (int16_t)((pHandle->pParams->wPWMFreq*10) / pHandle->pParams->hMainsFreqLowTh);         
  pHandle->hMainsFrequencyLoCyc = (int16_t)((pHandle->pParams->wPWMFreq*10) / pHandle->pParams->hMainsFreqHiTh);          
 
  pHandle->bMainsFreqErrorNo = (uint8_t)MAXFREQERRNO;                                                                      
  pHandle->bMainsVoltageErrorNo = (uint8_t)MAXAMPLERRNO;                                                                   

<#if CondFamily_STM32F3>
  
  LL_DBGMCU_APB1_GRP1_FreezePeriph( LL_DBGMCU_APB1_GRP1_TIM4_STOP  );
  LL_DBGMCU_APB2_GRP1_FreezePeriph( LL_DBGMCU_APB2_GRP1_TIM16_STOP  );
     
  LL_TIM_OC_SetCompareCH1(TIMx, 0); /* inactive state */
  LL_TIM_OC_EnablePreload(TIMx, LL_TIM_CHANNEL_CH1);
  LL_TIM_CC_EnableChannel(TIMx, LL_TIM_CHANNEL_CH1);    
  LL_TIM_ClearFlag_BRK(TIMx);
  LL_TIM_EnableIT_BRK(TIMx);
  LL_TIM_EnableAllOutputs(TIMx);
  
  LL_TIM_OC_SetCompareCH1(TIMx_2, (uint32_t)(pHandle->pParams->hPWMARR/2 + pHandle->hADCTotalCk));
  LL_TIM_OC_SetCompareCH3(TIMx_2, (uint32_t) (pHandle->pParams->hPWMARR/2) );
  LL_TIM_OC_EnablePreload(TIMx_2, (LL_TIM_CHANNEL_CH1|LL_TIM_CHANNEL_CH3)); 
  
  /* enable channel 3 for ADC triggering */
  LL_TIM_CC_EnableChannel(TIMx_2, LL_TIM_CHANNEL_CH3);
  LL_TIM_CC_EnableChannel(TIMx_2, LL_TIM_CHANNEL_CH2);
  LL_TIM_EnableIT_CC1(TIMx_2);
    
    
  if ( LL_ADC_IsInternalRegulatorEnabled(ADCx) == 0u)
  {
    /* Enable ADC internal voltage regulator */
    LL_ADC_EnableInternalRegulator(ADCx);
  
    /* Wait for Regulator Startup time, once for both */
    /* Note: Variable divided by 2 to compensate partially              */
    /*       CPU processing cycles, scaling in us split to not          */
    /*       exceed 32 bits register capacity and handle low frequency. */
    volatile uint32_t wait_loop_index = ((LL_ADC_DELAY_INTERNAL_REGUL_STAB_US / 10UL) * (SystemCoreClock / (100000UL * 2UL)));      
    while(wait_loop_index != 0UL)
    {
      wait_loop_index--;
    }
  }

  LL_ADC_StartCalibration( ADCx, LL_ADC_SINGLE_ENDED );
  while ( LL_ADC_IsCalibrationOnGoing( ADCx) == 1u) 
  {}
  /* ADC Enable (must be done after calibration) */
  /* ADC5-140924: Enabling the ADC by setting ADEN bit soon after polling ADCAL=0 
  * following a calibration phase, could have no effect on ADC 
  * within certain AHB/ADC clock ratio.
  */
  while (  LL_ADC_IsActiveFlag_ADRDY( ADCx ) == 0u)  
  { 
    LL_ADC_Enable(  ADCx );
  }
  
  /* start ADC conversion on external trigger event */
  LL_ADC_INJ_StartConversion(ADCx);
  
  LL_OPAMP_Enable( OPAMP4 );
  LL_OPAMP_Lock( OPAMP4 );
  
  PFC_SetAOReferenceVoltage(LL_DAC_CHANNEL_2, (uint16_t)(pHandle->pParams->hDAC_OCP_Threshold));
  
  LL_COMP_Enable ( COMP5 );
  LL_COMP_Lock( COMP5 );
    
  LL_TIM_SetCounter(TIMx, 3);
  LL_TIM_SetCounter(TIMx_2, 0);


  /* Clear all pending interrupts */
  LL_TIM_ClearFlag_CC1(TIMx_2);

  /* Enable the counting timer*/
  LL_TIM_EnableCounter(TIMx_2);
  LL_TIM_EnableCounter(TIMx);

  /* Wait for synch with the AC main */
  LL_TIM_ClearFlag_CC2(TIMx_2);
  while (LL_TIM_IsActiveFlag_CC2(TIMx_2)== 0)
  {}
  pHandle->hMainsSync = 0;
  LL_TIM_ClearFlag_CC2(TIMx_2);

  LL_TIM_EnableIT_CC1(TIMx_2);   /*PFC scheduler, TIM4 ch1*/

<#elseif CondFamily_STM32F1>

#if 0 /* ETRFault is always enabled in the current implementation */
  if ( pHandle->pParams->ETRFault == ENABLE ) {
#endif /* 0 */
    /* Enable clearing Output Compare 2 on external trigger.*/
    LL_TIM_OC_EnableClear( TIMx, LL_TIM_CHANNEL_CH2 );

    /* Enable Trigger Interrupt */
    LL_TIM_EnableIT_TRIG( TIMx );
#if 0 /* ETRFault is always enabled in the current implementation */
  } else { /* Nothing to do here*/ }
#endif /* 0 */

  /* Enable the ADC */
  LL_ADC_Enable( ADCx );

  /* Perform ADC Calibration */
  LL_ADC_StartCalibration( ADCx );
  while ( LL_ADC_IsCalibrationOnGoing( ADCx ) == 1 ) ;

  /* When debugging let timer's counter clock be stopped when core is halted */
  LL_DBGMCU_APB1_GRP1_FreezePeriph( LL_DBGMCU_APB1_GRP1_TIM3_STOP  );

  /* Reset timer counter */
  TIMx->CNT = 0U;
  /* CC4 DMA request enable */
  LL_TIM_EnableDMAReq_CC4( TIMx );
  /* Clear Timer's CC3 pending interrupt if any . */
  LL_TIM_ClearFlag_CC3( TIMx );
  /* Enable the counter of the timer */
  LL_TIM_EnableCounter( TIMx );
  /* Enable Timer's CC3 interrupt */
  LL_TIM_EnableIT_CC3( TIMx );

  /* Enable Capture/Compare registers for Channels 1 & 2 */
  LL_TIM_CC_EnableChannel( TIMx, LL_TIM_CHANNEL_CH1 );
  LL_TIM_CC_EnableChannel( TIMx, LL_TIM_CHANNEL_CH2 );

  /* Enable the ADC injected scan */
  LL_ADC_INJ_StartConversionExtTrig( ADCx, LL_ADC_INJ_TRIG_EXT_RISING );

  /* Complete DMA's configuration */
  LL_DMA_SetDataLength( DMAx, pHandle->pParams->DMAChannel, 1);
  LL_DMA_ConfigAddresses( DMAx, pHandle->pParams->DMAChannel,
                          (uint32_t) & pHandle->JSWSTART_CR2, (uint32_t) & ADCx->CR2,
                          LL_DMA_DIRECTION_MEMORY_TO_PERIPH );
  LL_DMA_EnableChannel( DMAx, pHandle->pParams->DMAChannel );

  /* Keep the value of the ADC->CR2 register for Triggering Injected conversion by DMA. */
  pHandle->JSWSTART_CR2 = ADCx->CR2 | ADC_CR2_JSWSTART;
<#else>
#error PFC spported only for F1 and F3
</#if> 
}

/** @brief Sets the variables of the PFC component pointed by pHandle to their initial state and returns the boost status */
bool PFC_ON( PFC_Handle_t * pHandle )
{
  int16_t hStartUpVoltageIncrease;
  bool bRet = false;
  int16_t hVoltageLevel;

  PID_SetIntegralTerm( & pHandle->cPICurr, 0 );
  PID_SetIntegralTerm( & pHandle->cPIVolt, 0 );

  if ( pHandle->pVBS != MC_NULL )
  {
    hVoltageLevel = VBS_GetAvBusVoltage_V( pHandle->pVBS );
  }
  else
  {
    hVoltageLevel = *(pHandle->pBusVoltage);
  }

  hStartUpVoltageIncrease = pHandle->hTargetVoltageReference - hVoltageLevel;

  if ( hStartUpVoltageIncrease > 0 ) /*check boost condition*/
  {
    pHandle->hStartUpVoltageIncrease = hStartUpVoltageIncrease;

    pHandle->hStartUpStep = 0;

    pHandle->hVoltageReference = hVoltageLevel;
    pHandle->hStartUpInitialLevel = hVoltageLevel;

    pHandle->hMainsVoltageVpk = hVoltageLevel;

    pHandle->hCurrentReferenceAmpl = 0;
    pHandle->hCurrentReference = 0;

    pHandle->bCurrLoopCnt = pHandle->pParams->bCurrentLoopRate;
    pHandle->bVoltLoopCnt = pHandle->pParams->bVoltageLoopRate;

    pHandle->bDualSampling = false;

    pHandle->hDuty = pHandle->hMinDuty;
    pHandle->hFirstTrig = pHandle->pParams->hPropDelayOnTimCk;
    pHandle->hSecondTrig = pHandle->pParams->hPropDelayOnTimCk + pHandle->hADCTotalCk;

    pHandle->bStartUpEnd = false;

    pHandle->bMainsSynthStage = 0;

    pHandle->bMainsFreqErrorNo = (uint8_t)MAXFREQERRNO;

    pHandle->bMainsVoltageErrorNo = (uint8_t)MAXAMPLERRNO;

    bRet = true;
  }

  return bRet;
}

/** @brief Returns a pointer on the state machine used by the PFC component pointed by pHandle */
__weak STM_Handle_t * PFC_GetStateMachine( PFC_Handle_t * pHandle )
{
  return & pHandle->pSTM;
}

/** @brief Enables the PFC component pointed by pHandle. Returns true if successful, false otherwise */
__weak bool PFC_Enable( PFC_Handle_t * pHandle )
{
  pHandle->bPFCen = true;

  return true;
}

/** @brief Disables the PFC component pointed by pHandle. Returns true if successful, false otherwise */
__weak bool PFC_Disable( PFC_Handle_t * pHandle )
{
  pHandle->bPFCen = false;
  STM_NextState( & pHandle->pSTM, ANY_STOP );

  return true;
}

/** @brief Returns true if the PFC component pointed by @p pHandle is enabled, false otherwise */
__weak bool PFC_IsEnabled( PFC_Handle_t * pHandle )
{
  return pHandle->bPFCen;
}

/**
 * @brief Sets the DC boost voltage reference to be maintained by a PFC component
 *
 * The DC boost voltage reference of the PFC component pointed by @p pHandle is set
 * to @p hVoltRef volts.
 *
 * @p hVoltRef shall be positive (>0).
 */
__weak void PFC_SetBoostVoltageReference( PFC_Handle_t * pHandle, int16_t hVoltRef )
{
  pHandle->hTargetVoltageReference = hVoltRef;
  pHandle->hVoltageReference = hVoltRef;
}

/** @brief Returns the DC boost voltage reference to be maintained by the PFC component pointed by @p pHandle, in volts. */
__weak int16_t PFC_GetBoostVoltageReference( PFC_Handle_t * pHandle )
{
  return pHandle->hTargetVoltageReference;
}

/**
 * @brief Sets the duration of the startup phase of a PFC component.
 *
 *  The duration of the startup phase of the PFC component pointed by @p pHandle is set
 *  to @p hStartUpDuration.
 *
 *  @p hStartUpDuration is expressed in milliseconds and shall be positive (>0).
 */
__weak void PFC_SetStartUpDuration( PFC_Handle_t * pHandle, int16_t hStartUpDuration )
{
  pHandle->hStartUpDuration = hStartUpDuration;
}

/** @brief Returns the duration of the PFC startup phase of the PFC component pointed by @p pHandle, in ms. */
__weak int16_t PFC_GetStartUpDuration( PFC_Handle_t * pHandle )
{
  return pHandle->hStartUpDuration;
}

/** @brief Returns a pointer on the Current PID regulator of the PFC component pointed by @p pHandle */
__weak PID_Handle_t* PFC_GetCurrentLoopPI( PFC_Handle_t * pHandle )
{
  return & pHandle->cPICurr;
}

/** @brief Returns a pointer on the Voltage PID regulator of the PFC component pointed by @p pHandle */
__weak PID_Handle_t* PFC_GetVoltageLoopPI( PFC_Handle_t * pHandle )
{
  return & pHandle->cPIVolt;
}

/** @brief Returns the last Mains Voltage measured by the PFC component pointed by @p pHandle, in volts (0-to-pk) */
__weak int16_t PFC_GetMainsVoltage( PFC_Handle_t * pHandle )
{
  int16_t hRet = 0;
  State_t STMState = STM_GetState( & pHandle->pSTM );

  switch ( STMState )
  {
  case RUN:
    hRet = pHandle->hMainsVoltageVpk;
    break;

  default:
    hRet = pHandle->hVoltageLevel;
    break;
  }

  return hRet;
}

/** @brief Returns the last Mains Frequency measured by the PFC component pointed by @p pHandle, in tenth of Hz */
__weak int16_t PFC_GetMainsFrequency( PFC_Handle_t * pHandle )
{
  /* Mains frequency computation*/
  uint32_t wtemp;
  wtemp = pHandle->pParams->wPWMFreq * 10;
  wtemp /= pHandle->hMainsPeriod;

  pHandle->hMainsFrequency = (uint16_t)wtemp;

  return pHandle->hMainsFrequency;
}

/** @brief Returns the last average VBus value known to the PFC component pointed by @p pHandle, in volts. */
__weak int16_t PFC_GetAvBusVoltage_V( PFC_Handle_t * pHandle )
{
  return pHandle->hVoltageLevel;
}


/* @brief Acknowledges faults pending on the PFC component pointed by @p pHandle. Returns true if successful,
 *        false otherwise. */
__weak bool PFC_AcknowledgeFaults( PFC_Handle_t * pHandle )
{
  return STM_FaultAcknowledged( & pHandle->pSTM );
}

#if defined (CCMRAM)
#if defined (__ICCARM__)
#pragma location = ".ccmram"
#elif defined (__CC_ARM)
__attribute__( ( section ( ".ccmram" ) ) )
#endif
#endif

__weak void PFC_TIM_CC_IRQHandler( PFC_Handle_t * pHandle )
{
  ADC_TypeDef * ADCx = pHandle->pParams->ADCx; 
  TIM_TypeDef * TIMx = pHandle->pParams->TIMx;  
<#if CondFamily_STM32F3>    
  TIM_TypeDef * TIMx_2 = pHandle->pParams->TIMx_2;  
</#if>    
  bool FCurrReg = false;

  uint16_t hFaultNowMessage = 0u;
  uint16_t hFaultOverMessage = 0u;

  if (LL_TIM_IsActiveFlag_CC${SEC_TRIG_CH}(${TIM_TRIG}) != 0)
  {
    LL_TIM_ClearFlag_CC${SEC_TRIG_CH}(${TIM_TRIG});
    LL_TIM_ClearFlag_UPDATE(${TIM_TRIG});
    LL_TIM_ClearFlag_UPDATE(TIMx);
    
  /*SCHEDULER UPDATE*/

  pHandle->bCurrLoopCnt--;
  if ( pHandle->bCurrLoopCnt == 0 )
  {
    pHandle->bCurrLoopCnt = pHandle->pParams->bCurrentLoopRate;
    FCurrReg = true;
  }

  /*SCHEDULER EXECUTION*/

  pHandle->STMState = STM_GetState( & pHandle->pSTM );

  /*State Conditional execution*/
  switch ( pHandle->STMState )
  {
  case IDLE:
    if ( pHandle->hMainsSync <= ( pHandle->hMainsPeriod/20 ) )
    {
      /* do calibration */
      pHandle->hADCCalArray[pHandle->bADCCalArrayIndex] = (uint16_t)(ADCx->JDR1);
      if ( pHandle->bADCCalArrayIndex == (PFC_ADCCAL_ARRAY_LENGHT-1) )
      {
        pHandle->bADCCalArrayIndex = 0;
        pHandle->bADCCalibrated = true;
      }
      else
      {
        pHandle->bADCCalArrayIndex ++;
      }
    }

      if (pHandle->bMainsPk == true)
      {
        pHandle->bMainsPk = false;
        pHandle->hMainsVoltageS16 = (uint16_t)(ADCx->JDR3);
        pHandle->hMainsVoltageVpk = (int16_t)(pHandle->hMainsVoltageS16 / pHandle->pParams->hMainsConversionFactor);
      }
    
    if ( pHandle->bPFCen ) /*PFC is enabled*/
    {
      if ( pHandle->bADCCalibrated == true )
      {
        if (pHandle->hMotorPower >= pHandle->pParams->OutputPowerActivation)  /*Power > Hth*/
        {
          if ( pHandle->hMainsSync == 0 )
          {
            if( STM_NextState( & pHandle->pSTM, IDLE_START ) == false )
            {
              STM_FaultProcessing( & pHandle->pSTM, PFC_SWE, 0 );
            }
          }
        }
      }
    }
    break;

  case IDLE_START:
    if ( PFC_ON( pHandle ) )
    {
      LL_TIM_OC_SetCompareCH${DUTY_CH}( TIMx, pHandle->hDuty );
      LL_TIM_OC_SetCompareCH${SEC_TRIG_CH}( ${TIM_TRIG}, pHandle->hSecondTrig );
      LL_TIM_OC_SetCompareCH${FIRST_TRIG_CH}( ${TIM_TRIG}, pHandle->hFirstTrig );
      LL_TIM_EnableAllOutputs(TIMx);

      if ( STM_NextState( & pHandle->pSTM, START ) == false )
      {
        STM_FaultProcessing( & pHandle->pSTM, PFC_SWE, 0 );
      }

      /*calculate calibration value*/
      {
        uint8_t bIndexTemp = 0;
        uint32_t wSumTemp = 0;

        while ( bIndexTemp < PFC_ADCCAL_ARRAY_LENGHT )
        {
          wSumTemp += pHandle->hADCCalArray[bIndexTemp];
          bIndexTemp ++;
        }

        pHandle->hADCCalibration = ((uint16_t)(wSumTemp / (PFC_ADCCAL_ARRAY_LENGHT)))/2;
      }
    }
    else /* PFC_ON returns false*/
    {
      if( STM_NextState( & pHandle->pSTM, ANY_STOP ) == false )
      {
        STM_FaultProcessing( & pHandle->pSTM, PFC_SWE, 0 );
      }
    }
    break;

  case START:
    if ( FCurrReg )
    {
      PFC_CurrentRegulation( pHandle );

      /* Vmains reading*/
      pHandle->hMainsVoltageS16 = (uint16_t)(ADCx->JDR3);

      __disable_irq(); /*enter critical section*/
      if (!LL_TIM_IsActiveFlag_UPDATE(TIMx))
      {
        if ( LL_TIM_GetCounter(TIMx) < pHandle->hMaxTimCnt )
        {
          LL_TIM_OC_SetCompareCH${DUTY_CH}( TIMx, pHandle->hDuty );
          LL_TIM_OC_SetCompareCH${SEC_TRIG_CH}( ${TIM_TRIG}, pHandle->hSecondTrig );
          LL_TIM_OC_SetCompareCH${FIRST_TRIG_CH}( ${TIM_TRIG}, pHandle->hFirstTrig );         
        }
        else
        {
          __enable_irq(); /*exit critical section*/
          if (pHandle->pParams->bCurrentLoopRate == 1)
          {
            pHandle->bCurrLoopCnt = pHandle->pParams->bCurrentLoopRate + 1;
          }
        }
      }
      else
      {
        __enable_irq(); /*exit critical section*/
        if (pHandle->pParams->bCurrentLoopRate == 1)
        {
          pHandle->bCurrLoopCnt = pHandle->pParams->bCurrentLoopRate + 1;
        }
      }
      __enable_irq(); /*exit critical section*/

      if ( pHandle->bStartUpEnd )
      {
        if ( STM_NextState( & pHandle->pSTM, START_RUN ) == false )
        {
          STM_FaultProcessing( & pHandle->pSTM, PFC_SWE, 0 );
        }
        if ( STM_NextState( & pHandle->pSTM, RUN ) == false )
        {
          STM_FaultProcessing( & pHandle->pSTM, PFC_SWE, 0 );
        }
      }
    }
    else
    {
      LL_TIM_OC_SetCompareCH${DUTY_CH}( TIMx, pHandle->hDuty );
      LL_TIM_OC_SetCompareCH${SEC_TRIG_CH}( ${TIM_TRIG}, pHandle->hSecondTrig );
      LL_TIM_OC_SetCompareCH${FIRST_TRIG_CH}( ${TIM_TRIG}, pHandle->hFirstTrig );    
    }

    break;

  case START_RUN:
    STM_FaultProcessing( & pHandle->pSTM, PFC_SWE, 0 ); /* START_RUN skipped in the flow*/
    break;

  case RUN:
    if ( FCurrReg )
    {
      PFC_CurrentRegulation( pHandle );
      /* Vmains reading*/
      pHandle->hMainsVoltageS16 = (uint16_t)(ADCx->JDR3);

      __disable_irq(); /*enter critical section*/
      if ( ! LL_TIM_IsActiveFlag_UPDATE( TIMx ) )
      {
        if ( LL_TIM_GetCounter( TIMx ) < pHandle->hMaxTimCnt )
        {
          LL_TIM_OC_SetCompareCH${DUTY_CH}( TIMx, pHandle->hDuty );
          LL_TIM_OC_SetCompareCH${SEC_TRIG_CH}( ${TIM_TRIG}, pHandle->hSecondTrig );
          LL_TIM_OC_SetCompareCH${FIRST_TRIG_CH}( ${TIM_TRIG}, pHandle->hFirstTrig ); 
        }
        else
        {
          __enable_irq(); /*exit critical section*/
          if ( pHandle->pParams->bCurrentLoopRate == 1)
          {
            pHandle->bCurrLoopCnt = pHandle->pParams->bCurrentLoopRate + 1;
          }
        }
      }
      else
      {
        __enable_irq(); /*exit critical section*/
        if ( pHandle->pParams->bCurrentLoopRate == 1)
        {
          pHandle->bCurrLoopCnt = pHandle->pParams->bCurrentLoopRate + 1;
        }
      }
      __enable_irq(); /*exit critical section*/
    }
    else
    {
      LL_TIM_OC_SetCompareCH${DUTY_CH}( TIMx, pHandle->hDuty );
      LL_TIM_OC_SetCompareCH${SEC_TRIG_CH}( ${TIM_TRIG}, pHandle->hSecondTrig );
      LL_TIM_OC_SetCompareCH${FIRST_TRIG_CH}( ${TIM_TRIG}, pHandle->hFirstTrig ); 
    }

    break;

  case ANY_STOP:
    /* output disable */  
    LL_TIM_OC_SetCompareCH${DUTY_CH}( TIMx, 0 );
  

    if ( STM_NextState( & pHandle->pSTM, STOP ) == false )
    {
      STM_FaultProcessing( & pHandle->pSTM, PFC_SWE, 0 );
    }
    break;

  case STOP:
    if ( STM_NextState( & pHandle->pSTM, STOP_IDLE ) == false )
    {
      STM_FaultProcessing( & pHandle->pSTM, PFC_SWE, 0 );
    }
    break;

  case STOP_IDLE:
    if ( STM_NextState( & pHandle->pSTM, IDLE ) == false )
    {
      STM_FaultProcessing( & pHandle->pSTM, PFC_SWE, 0 );
    }
    break;


  case FAULT_NOW:
    /* output disable */
    LL_TIM_OC_SetCompareCH${DUTY_CH}( TIMx, 0 );

    /*check protections*/
    {
      uint8_t bPin;
      uint8_t bAux;
      bPin = LL_GPIO_IsInputPinSet( pHandle->pParams->hFaultPort, pHandle->pParams->hFaultPin );

      bAux = !((pHandle->pParams->bFaultPolarity) ^ bPin);

      if (bAux)
      {
        hFaultNowMessage |= PFC_HW_PROT;
      }
      else
      {
        hFaultOverMessage |= PFC_HW_PROT;
      }

      hFaultOverMessage |= PFC_SWE;
      hFaultOverMessage |= PFC_SW_OVER_VOLT;
      hFaultOverMessage |= PFC_SW_MAIN_VOLT;

      STM_FaultProcessing( & pHandle->pSTM, hFaultNowMessage, hFaultOverMessage );
    }

    break;

  case FAULT_OVER:
    break;
  default:
    break;  
  }

  /*High Frequency Task, any state*/

  /*Synch with mains voltage*/
  pHandle->hMainsSync ++;

  if (pHandle->hMainsSync <= pHandle->hMainsFrequencyLoCyc)
  {
    LL_TIM_ClearFlag_CC${CH_AC_MAIN}( ${TIM_AC_MAIN} );
  }
  else
  {
  if ( LL_TIM_IsActiveFlag_CC${CH_AC_MAIN}( ${TIM_AC_MAIN} ) )
  {
    LL_TIM_ClearFlag_CC${CH_AC_MAIN}( ${TIM_AC_MAIN} );

        if ( pHandle->hMainsSync > pHandle->hMainsFrequencyLoCyc )
        {
          if ( pHandle->hMainsSync < pHandle->hMainsFrequencyHiCyc )
          {
            pHandle->hMainsPeriod = pHandle->hMainsSync;
            pHandle->hMainsSync = 0;
            pHandle->bMainsPk = false;
  
            pHandle->bMainsFreqErrorNo = MAXFREQERRNO;
            STM_FaultProcessing( & pHandle->pSTM, 0, PFC_SW_MAINS_FREQ );
          }
          else
          {
            if ( pHandle->bMainsFreqErrorNo == 0 )
            {
              STM_FaultProcessing( & pHandle->pSTM, PFC_SW_MAINS_FREQ, 0 );
              pHandle->bMainsFreqErrorNo = MAXFREQERRNO;
            }
  
            pHandle->bMainsFreqErrorNo --;
          }
        }
        else
        {
          if ( pHandle->bMainsFreqErrorNo == 0 )
          {
            STM_FaultProcessing( & pHandle->pSTM, PFC_SW_MAINS_FREQ, 0 );
            pHandle->bMainsFreqErrorNo = MAXFREQERRNO;
          }
  
          pHandle->bMainsFreqErrorNo --;
        }
      }
    }
    if ( (pHandle->hMainsSync) == (pHandle->hMainsPeriod/4) )
    {
      pHandle->bMainsPk = true;
    }
  }
  else
  {
    /* output disable */
    LL_TIM_OC_SetCompareCH${DUTY_CH}(TIMx,0);
    STM_FaultProcessing(&pHandle->pSTM, PFC_HW_PROT, 0);
  }
}
<#if CondFamily_STM32F1>
__weak void PFC_TIM_TRIG_IRQHandler( PFC_Handle_t * pHandle )
{
  /* ETR -- a software error. */
  LL_TIM_OC_SetCompareCH2( pHandle->pParams->TIMx, 0 );
  /* TODO: Check if this is needed here as it is done in the IRQ handler */
  LL_TIM_ClearFlag_TRIG( pHandle->pParams->TIMx );

  STM_FaultProcessing( & pHandle->pSTM, PFC_HW_PROT, 0 );
}


#if 0 /* This function is only needed when ETRFault is disabled.
         However, ETRFault is always enabled in the current implementation. */
/** @brief  Handles External lines interrupt request. */
__weak void EXTIx_IRQHandler( PFC_Handle_t * pHandle )
{
  if ( LL_EXTI_IsActiveFlag_0_31( pHandle->pParams->hEXTIPinSource ) )
  {
    LL_TIM_OC_DisablePreload( pHandle->pParams->TIMx, LL_TIM_CHANNEL_CH2 );

    /* output disable */
    /*TIM_SetCompare2(TIM3, 0);*/
    LL_TIM_OC_SetCompareCH2( pHandle->pParams->TIMx, 0 );

    LL_EXTI_ClearFlag_0_31( pHandle->pParams->hEXTIPinSource );

    LL_TIM_OC_EnablePreload( pHandle->pParams->TIMx );

    STM_FaultProcessing( & pHandle->pSTM, PFC_HW_PROT, 0 );
  }
}
#endif /* 0 */
</#if>
/**
  * @brief  Generates hStartUpVoltageReference during startup phase;
  *         hStartUpVoltageReference will go from measured DC bus to hVoltageReference
  * @retval true if hStartUpVoltageReference has reached hVoltageReference,
  *         false otherwise
  */
static bool PFC_StartUpVoltGen( PFC_Handle_t * pHandle )
{
  bool bRet = false;

  int32_t wtemp;

  wtemp = (int32_t)pHandle->hStartUpVoltageIncrease * pHandle->hStartUpStep;
  wtemp /= pHandle->hStartUpDuration;

  pHandle->hVoltageReference =  pHandle->hStartUpInitialLevel + (int16_t)wtemp;

  if (pHandle->hStartUpStep == pHandle->hStartUpDuration)
  {
    bRet = true;
  }
  else
  {
    pHandle->hStartUpStep++;
  }

  return bRet;
}

/**
  * @brief  Voltage Regulation Algorithm execution
  * @param  none
  * @retval none
  */
static void PFC_VoltageRegulation( PFC_Handle_t * pHandle )
{
  int32_t wBusVoltageError;
  int32_t wLoadFeedForward;
  int32_t wCurrentReferenceTemp;
  uint16_t hNominalCurrent = pHandle->pParams->hNominalCurrent;

  wBusVoltageError = pHandle->hVoltageReference - pHandle->hVoltageLevel;

  wCurrentReferenceTemp = PI_Controller( &pHandle->cPIVolt, wBusVoltageError );

  /*MAINS VOLTAGE PEAK MEASUREMENT*/
  if ( pHandle->bMainsPk == true )
  {
    pHandle->bMainsPk = false;

    pHandle->hMainsVoltageVpk = (int16_t)(pHandle->hMainsVoltageS16 / pHandle->pParams->hMainsConversionFactor);

    if ( pHandle->hMainsVoltageVpk > (pHandle->hVoltageReference + 10) )
    {
      pHandle->bMainsVoltageErrorNo--;
      if ( pHandle->bMainsVoltageErrorNo == 0 )
      {
        STM_FaultProcessing( & pHandle->pSTM, PFC_SW_MAIN_VOLT, 0 );
      }
    }
    else
    {
      pHandle->bMainsVoltageErrorNo = MAXFREQERRNO;
    }
  }

  /*LINE & LOAD FEEDFORWARD*/
  if ( pHandle->pVBS != MC_NULL )
  {
    wLoadFeedForward = ((int32_t)(pHandle->hMotorPower) * pHandle->pParams->hCurrentConversionFactor)/pHandle->hMainsVoltageVpk;

    if (wLoadFeedForward > hNominalCurrent) /* saturation to avoid PI cannot compensate*/
    {
      wLoadFeedForward = hNominalCurrent;
    }
  }

  /* Check saturation of wCurrentReferenceTemp */
  if (wCurrentReferenceTemp > hNominalCurrent)
  {
    wCurrentReferenceTemp = hNominalCurrent;
  }
  else if (wCurrentReferenceTemp < 0)
  {
    wCurrentReferenceTemp = 0;
  } else {}

  pHandle->hCurrentReferenceAmpl = (uint16_t)(wCurrentReferenceTemp);
}

#if defined (CCMRAM)
#if defined (__ICCARM__)
#pragma location = ".ccmram"
#elif defined (__CC_ARM)
__attribute__( ( section ( ".ccmram" ) ) )
#endif
#endif

static inline void PFC_CurrentRegulation( PFC_Handle_t * pHandle )
{
  int32_t wCurrentReference;
  int16_t hDuty;
  int16_t hFirstTrig;
  int16_t hSecondTrig;
  int32_t wCurrentError;
  int32_t wtemp;
  int32_t wCurrentLevel;
  int32_t wJDR1;
  int32_t wJDR2;

  /*CURRENT READING CORRECTION & VALIDATION*/
  wJDR1 = (int32_t)LL_ADC_INJ_ReadConversionData32( pHandle->pParams->ADCx, LL_ADC_INJ_RANK_1 );
  wJDR2 = (int32_t)LL_ADC_INJ_ReadConversionData32( pHandle->pParams->ADCx, LL_ADC_INJ_RANK_2 );

  if ( pHandle->bDualSampling == true )
  {
    wCurrentLevel = ( wJDR1 + wJDR2)/4; /* div2 for averaging*/
  }
  else
  {
    wCurrentLevel = wJDR1/2;
  }

  wCurrentLevel -= pHandle->hADCCalibration;

  if (wCurrentLevel < 0)
  {
    wCurrentLevel = 0;
  }

  /* 2nd - 1st to be stored and filtered */

  /*CURRENT WAVEFORM SYNTH*/

  if ( pHandle->bMainsSynthStage == 0 )
  {
    int32_t wMainsSync;

    wMainsSync = (int32_t)(pHandle->hMainsSync) * 1024;
    wMainsSync = wMainsSync/(int32_t)(pHandle->hMainsPeriod);

    pHandle->uhindex = (uint16_t)wMainsSync;

    wCurrentReference = pHandle->hCurrentReference;

    pHandle->bMainsSynthStage = 1;

  }
  else if (pHandle->bMainsSynthStage == 1)
  {
    switch ((uint16_t)(pHandle->uhindex) & SIN_MASK)
    {
    case U0_90:
      pHandle->hMainsSynth = hSin_Cos_Table2[(uint8_t)(pHandle->uhindex)];
      break;

    case U90_180:
      pHandle->hMainsSynth = hSin_Cos_Table2[(uint8_t)(0xFFu-(uint8_t)(pHandle->uhindex))];
      break;

    case U180_270:
      pHandle->hMainsSynth = -hSin_Cos_Table2[(uint8_t)(pHandle->uhindex)];
      break;

    case U270_360:
      pHandle->hMainsSynth =  -hSin_Cos_Table2[(uint8_t)(0xFFu-(uint8_t)(pHandle->uhindex))];
      break;
    default:
      break;
    }

      wCurrentReference = pHandle->hCurrentReference;

      pHandle->bMainsSynthStage = 2;
  }
  else
  {
    pHandle->hMainsSynth = (pHandle->hMainsSynth < 0 ? -pHandle->hMainsSynth :
                           pHandle->hMainsSynth); /*ABS value*/

    wCurrentReference = ((int32_t)pHandle->hMainsSynth) * pHandle->hCurrentReferenceAmpl;
    wCurrentReference = wCurrentReference/32768;

    pHandle->hCurrentReference = (uint16_t)wCurrentReference; /*stored*/

    pHandle->bMainsSynthStage = 0;

  }

  /*CURRENT REGULATION (PI)*/
  wCurrentError = wCurrentReference - wCurrentLevel;
  hDuty = PI_Controller( & pHandle->cPICurr, wCurrentError );

  /*DUTY CYCLES CALCULATION C2,C3,C4,ADC data alignment for next cycle*/
  wtemp = (int32_t)hDuty * pHandle->pParams->hPWMARR;
  wtemp = wtemp/32768;

  hDuty = (int16_t)wtemp;

  if ( hDuty < pHandle->hMinDuty )
  {
    hDuty = pHandle->hMinDuty;
  }

//  hCorrDuty = hDuty + pHandle->hDutyCorrCk;     /* hCorrDuty is the real Ton*/
//
//  if (hCorrDuty <  pHandle->hMinTonCk)              /* MIN TON correction to read charging current*/
//  {
//    hDuty =  pHandle->hMinDuty;
//  }

  if (hDuty > pHandle->hMinDutyDualTrig)
  {
    hFirstTrig = hDuty/2 + pHandle->h2SamplTrig;
    pHandle->bDualSampling = false;
  }
  else
  {
    hFirstTrig = hDuty/2 + pHandle->h1SamplTrig;
    pHandle->bDualSampling = true;
  }

//  hHalfDuty = hDuty/2 + pHandle->hPropDelayCorrCk;  /* real TOn center */

//  if (hCorrDuty < pHandle->hMinTonDualCk)
//  {
//    hFirstTrig = hHalfDuty - pHandle->hADCTrigCk;
//
//    pHandle->bDualSampling = false;
//  }
//  else                              /*LEAD TIME FOR 2 SAMPLINGS*/
//  {
//    hFirstTrig = hHalfDuty - pHandle->hADCTrigDualCk;
//
//    pHandle->bDualSampling = true;
//  }

  if (hFirstTrig < 0)
  {
    hFirstTrig = 0;
  }

  hSecondTrig = hFirstTrig + pHandle->hADCTotalCk;

  /* Storing results*/
  pHandle->hDuty = hDuty;
  pHandle->hFirstTrig = hFirstTrig;
  pHandle->hSecondTrig = hSecondTrig;

#if 0 /* For debug.  */
/*  MC_SetUserDAC(DAC_USER1,(int16_t)(ADC2->JDR1)-32768); */
/*  MC_SetUserDAC(DAC_USER2,(int16_t)((pHandle->hMainsSynth/2))); */
  MC_SetUserDAC(DAC_USER1,(int16_t)(pHandle->hMainsSync * 40));
/*  MC_SetUserDAC(DAC_USER2,(int16_t)(pHandle->hMainsSync * 40)); */
/*  MC_SetUserDAC(DAC_USER2,(int16_t)(pHandle->uhindex * 256)); */
  UI_DACUpdate(0);
#endif /* 0 */

}

/**
  * @brief  PFC medium/low frequency task scheduler; to be called with fixed
  *         periodicity, equal to PFC medium frequency task rate (as set in
  *         PFCParameters.h)
  */
__weak void PFC_Task( PFC_Handle_t * pHandle )
{
  bool FVoltReg = false;

  /*any state*/
  if ( pHandle->pVBS != MC_NULL )
  {
    pHandle->hVoltageLevel = VBS_GetAvBusVoltage_V( pHandle->pVBS );
    pHandle->hMotorPower = MPM_GetAvrgElMotorPowerW( pHandle->pMPW1 );

    if ( pHandle->pMPW2 != MC_NULL)
    {
      pHandle->hMotorPower += MPM_GetAvrgElMotorPowerW( pHandle->pMPW2 );
    }
  }
  else
  {
    pHandle->hVoltageLevel = *(pHandle->pBusVoltage);
    pHandle->hMotorPower = pHandle->pParams->OutputPowerActivation;
  }

  if ( pHandle->hVoltageLevel > pHandle->pParams->SWOverVoltageTh)
  {
    STM_FaultProcessing( & pHandle->pSTM, PFC_SW_OVER_VOLT, 0 );
  }

  /*SCHEDULER UPDATE*/

  pHandle->bVoltLoopCnt--;
  if ( pHandle->bVoltLoopCnt == 0 )
  {
    pHandle->bVoltLoopCnt = pHandle->pParams->bVoltageLoopRate;
    FVoltReg = true;
  }

  /*State Conditional execution*/
  switch ( pHandle->STMState )
  {
  case START:

    if ( FVoltReg )
    {
      pHandle->bStartUpEnd = PFC_StartUpVoltGen( pHandle );
      PFC_VoltageRegulation( pHandle );
    }

    if ( pHandle->hMotorPower < pHandle->pParams->OutputPowerDeActivation )  /*Power < Lth*/
    {
      if( STM_NextState( & pHandle->pSTM, ANY_STOP ) == false )
      {
        STM_FaultProcessing( & pHandle->pSTM, PFC_SWE, 0 );
      }
    }

    break;

  case RUN:

    if ( FVoltReg )
    {
      PFC_VoltageRegulation( pHandle );
    }

    if ( pHandle->hMotorPower < pHandle->pParams->OutputPowerDeActivation )  /*Power < Lth*/
    {
      if ( STM_NextState( & pHandle->pSTM, ANY_STOP ) == false )
      {
        STM_FaultProcessing( & pHandle->pSTM, PFC_SWE, 0 );
      }
    }
    break;
    
  default:
    break;
  }

}


/**
  * @brief  It is called to move the state macchine to the HW fault state.
  * @param  none
  * @retval none
  */
void PFC_OCP_Processing(PFC_Handle_t * pHandle)
{
  STM_FaultProcessing(&pHandle->pSTM, PFC_HW_PROT, 0);
}

<#if CondFamily_STM32F3>
/**
* @brief  It is used to configure the analog output used for protection
*         thresholds.
* @param  DAC_Channel: the selected DAC channel.
*          This parameter can be:
*            @arg DAC_Channel_1: DAC Channel1 selected
*            @arg DAC_Channel_2: DAC Channel2 selected
* @param  hDACVref Value of DAC reference expressed as 16bit unsigned integer.
*         Ex. 0 = 0V 65536 = VDD_DAC.
* @param  Output It enable/disable the DAC output to the external pin.
It must be either equal to ENABLE or DISABLE.
* @retval none
*/
static void PFC_SetAOReferenceVoltage(uint32_t DAC_Channel, uint16_t hDACVref)
{
  LL_DAC_ConvertData12LeftAligned ( DAC1, DAC_Channel, hDACVref );

  /* Enable DAC Channel */
  LL_DAC_TrigSWConversion ( DAC1, DAC_Channel );
  
  if (LL_DAC_IsEnabled ( DAC1, DAC_Channel ) == 1u ) 
  { /* If DAC is already enable, we wait LL_DAC_DELAY_VOLTAGE_SETTLING_US*/
    uint32_t wait_loop_index = ((LL_DAC_DELAY_VOLTAGE_SETTLING_US) * (SystemCoreClock / (1000000UL * 2UL)));      
    while(wait_loop_index != 0UL)
    {
      wait_loop_index--;
    }
  }
  else
  {
    /* If DAC is not enabled, we must wait LL_DAC_DELAY_STARTUP_VOLTAGE_SETTLING_US*/
    LL_DAC_Enable ( DAC1, DAC_Channel );
    uint32_t wait_loop_index = ((LL_DAC_DELAY_STARTUP_VOLTAGE_SETTLING_US) * (SystemCoreClock / (1000000UL * 2UL)));      
    while(wait_loop_index != 0UL)
    {
      wait_loop_index--;
    }    
  }
}
</#if>

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT 2019 STMicroelectronics *****END OF FILE****/
