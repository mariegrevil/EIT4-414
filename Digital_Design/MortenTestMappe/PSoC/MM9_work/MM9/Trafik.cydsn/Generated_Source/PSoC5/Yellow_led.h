/*******************************************************************************
* File Name: Yellow_led.h  
* Version 2.20
*
* Description:
*  This file contains Pin function prototypes and register defines
*
* Note:
*
********************************************************************************
* Copyright 2008-2015, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
*******************************************************************************/

#if !defined(CY_PINS_Yellow_led_H) /* Pins Yellow_led_H */
#define CY_PINS_Yellow_led_H

#include "cytypes.h"
#include "cyfitter.h"
#include "cypins.h"
#include "Yellow_led_aliases.h"

/* APIs are not generated for P15[7:6] */
#if !(CY_PSOC5A &&\
	 Yellow_led__PORT == 15 && ((Yellow_led__MASK & 0xC0) != 0))


/***************************************
*        Function Prototypes             
***************************************/    

/**
* \addtogroup group_general
* @{
*/
void    Yellow_led_Write(uint8 value);
void    Yellow_led_SetDriveMode(uint8 mode);
uint8   Yellow_led_ReadDataReg(void);
uint8   Yellow_led_Read(void);
void    Yellow_led_SetInterruptMode(uint16 position, uint16 mode);
uint8   Yellow_led_ClearInterrupt(void);
/** @} general */

/***************************************
*           API Constants        
***************************************/
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup driveMode Drive mode constants
     * \brief Constants to be passed as "mode" parameter in the Yellow_led_SetDriveMode() function.
     *  @{
     */
        #define Yellow_led_DM_ALG_HIZ         PIN_DM_ALG_HIZ
        #define Yellow_led_DM_DIG_HIZ         PIN_DM_DIG_HIZ
        #define Yellow_led_DM_RES_UP          PIN_DM_RES_UP
        #define Yellow_led_DM_RES_DWN         PIN_DM_RES_DWN
        #define Yellow_led_DM_OD_LO           PIN_DM_OD_LO
        #define Yellow_led_DM_OD_HI           PIN_DM_OD_HI
        #define Yellow_led_DM_STRONG          PIN_DM_STRONG
        #define Yellow_led_DM_RES_UPDWN       PIN_DM_RES_UPDWN
    /** @} driveMode */
/** @} group_constants */
    
/* Digital Port Constants */
#define Yellow_led_MASK               Yellow_led__MASK
#define Yellow_led_SHIFT              Yellow_led__SHIFT
#define Yellow_led_WIDTH              1u

/* Interrupt constants */
#if defined(Yellow_led__INTSTAT)
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup intrMode Interrupt constants
     * \brief Constants to be passed as "mode" parameter in Yellow_led_SetInterruptMode() function.
     *  @{
     */
        #define Yellow_led_INTR_NONE      (uint16)(0x0000u)
        #define Yellow_led_INTR_RISING    (uint16)(0x0001u)
        #define Yellow_led_INTR_FALLING   (uint16)(0x0002u)
        #define Yellow_led_INTR_BOTH      (uint16)(0x0003u) 
    /** @} intrMode */
/** @} group_constants */

    #define Yellow_led_INTR_MASK      (0x01u) 
#endif /* (Yellow_led__INTSTAT) */


/***************************************
*             Registers        
***************************************/

/* Main Port Registers */
/* Pin State */
#define Yellow_led_PS                     (* (reg8 *) Yellow_led__PS)
/* Data Register */
#define Yellow_led_DR                     (* (reg8 *) Yellow_led__DR)
/* Port Number */
#define Yellow_led_PRT_NUM                (* (reg8 *) Yellow_led__PRT) 
/* Connect to Analog Globals */                                                  
#define Yellow_led_AG                     (* (reg8 *) Yellow_led__AG)                       
/* Analog MUX bux enable */
#define Yellow_led_AMUX                   (* (reg8 *) Yellow_led__AMUX) 
/* Bidirectional Enable */                                                        
#define Yellow_led_BIE                    (* (reg8 *) Yellow_led__BIE)
/* Bit-mask for Aliased Register Access */
#define Yellow_led_BIT_MASK               (* (reg8 *) Yellow_led__BIT_MASK)
/* Bypass Enable */
#define Yellow_led_BYP                    (* (reg8 *) Yellow_led__BYP)
/* Port wide control signals */                                                   
#define Yellow_led_CTL                    (* (reg8 *) Yellow_led__CTL)
/* Drive Modes */
#define Yellow_led_DM0                    (* (reg8 *) Yellow_led__DM0) 
#define Yellow_led_DM1                    (* (reg8 *) Yellow_led__DM1)
#define Yellow_led_DM2                    (* (reg8 *) Yellow_led__DM2) 
/* Input Buffer Disable Override */
#define Yellow_led_INP_DIS                (* (reg8 *) Yellow_led__INP_DIS)
/* LCD Common or Segment Drive */
#define Yellow_led_LCD_COM_SEG            (* (reg8 *) Yellow_led__LCD_COM_SEG)
/* Enable Segment LCD */
#define Yellow_led_LCD_EN                 (* (reg8 *) Yellow_led__LCD_EN)
/* Slew Rate Control */
#define Yellow_led_SLW                    (* (reg8 *) Yellow_led__SLW)

/* DSI Port Registers */
/* Global DSI Select Register */
#define Yellow_led_PRTDSI__CAPS_SEL       (* (reg8 *) Yellow_led__PRTDSI__CAPS_SEL) 
/* Double Sync Enable */
#define Yellow_led_PRTDSI__DBL_SYNC_IN    (* (reg8 *) Yellow_led__PRTDSI__DBL_SYNC_IN) 
/* Output Enable Select Drive Strength */
#define Yellow_led_PRTDSI__OE_SEL0        (* (reg8 *) Yellow_led__PRTDSI__OE_SEL0) 
#define Yellow_led_PRTDSI__OE_SEL1        (* (reg8 *) Yellow_led__PRTDSI__OE_SEL1) 
/* Port Pin Output Select Registers */
#define Yellow_led_PRTDSI__OUT_SEL0       (* (reg8 *) Yellow_led__PRTDSI__OUT_SEL0) 
#define Yellow_led_PRTDSI__OUT_SEL1       (* (reg8 *) Yellow_led__PRTDSI__OUT_SEL1) 
/* Sync Output Enable Registers */
#define Yellow_led_PRTDSI__SYNC_OUT       (* (reg8 *) Yellow_led__PRTDSI__SYNC_OUT) 

/* SIO registers */
#if defined(Yellow_led__SIO_CFG)
    #define Yellow_led_SIO_HYST_EN        (* (reg8 *) Yellow_led__SIO_HYST_EN)
    #define Yellow_led_SIO_REG_HIFREQ     (* (reg8 *) Yellow_led__SIO_REG_HIFREQ)
    #define Yellow_led_SIO_CFG            (* (reg8 *) Yellow_led__SIO_CFG)
    #define Yellow_led_SIO_DIFF           (* (reg8 *) Yellow_led__SIO_DIFF)
#endif /* (Yellow_led__SIO_CFG) */

/* Interrupt Registers */
#if defined(Yellow_led__INTSTAT)
    #define Yellow_led_INTSTAT            (* (reg8 *) Yellow_led__INTSTAT)
    #define Yellow_led_SNAP               (* (reg8 *) Yellow_led__SNAP)
    
	#define Yellow_led_0_INTTYPE_REG 		(* (reg8 *) Yellow_led__0__INTTYPE)
#endif /* (Yellow_led__INTSTAT) */

#endif /* CY_PSOC5A... */

#endif /*  CY_PINS_Yellow_led_H */


/* [] END OF FILE */
