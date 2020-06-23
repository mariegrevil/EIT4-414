/*******************************************************************************
* File Name: OutputD.h  
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

#if !defined(CY_PINS_OutputD_H) /* Pins OutputD_H */
#define CY_PINS_OutputD_H

#include "cytypes.h"
#include "cyfitter.h"
#include "cypins.h"
#include "OutputD_aliases.h"

/* APIs are not generated for P15[7:6] */
#if !(CY_PSOC5A &&\
	 OutputD__PORT == 15 && ((OutputD__MASK & 0xC0) != 0))


/***************************************
*        Function Prototypes             
***************************************/    

/**
* \addtogroup group_general
* @{
*/
void    OutputD_Write(uint8 value);
void    OutputD_SetDriveMode(uint8 mode);
uint8   OutputD_ReadDataReg(void);
uint8   OutputD_Read(void);
void    OutputD_SetInterruptMode(uint16 position, uint16 mode);
uint8   OutputD_ClearInterrupt(void);
/** @} general */

/***************************************
*           API Constants        
***************************************/
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup driveMode Drive mode constants
     * \brief Constants to be passed as "mode" parameter in the OutputD_SetDriveMode() function.
     *  @{
     */
        #define OutputD_DM_ALG_HIZ         PIN_DM_ALG_HIZ
        #define OutputD_DM_DIG_HIZ         PIN_DM_DIG_HIZ
        #define OutputD_DM_RES_UP          PIN_DM_RES_UP
        #define OutputD_DM_RES_DWN         PIN_DM_RES_DWN
        #define OutputD_DM_OD_LO           PIN_DM_OD_LO
        #define OutputD_DM_OD_HI           PIN_DM_OD_HI
        #define OutputD_DM_STRONG          PIN_DM_STRONG
        #define OutputD_DM_RES_UPDWN       PIN_DM_RES_UPDWN
    /** @} driveMode */
/** @} group_constants */
    
/* Digital Port Constants */
#define OutputD_MASK               OutputD__MASK
#define OutputD_SHIFT              OutputD__SHIFT
#define OutputD_WIDTH              1u

/* Interrupt constants */
#if defined(OutputD__INTSTAT)
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup intrMode Interrupt constants
     * \brief Constants to be passed as "mode" parameter in OutputD_SetInterruptMode() function.
     *  @{
     */
        #define OutputD_INTR_NONE      (uint16)(0x0000u)
        #define OutputD_INTR_RISING    (uint16)(0x0001u)
        #define OutputD_INTR_FALLING   (uint16)(0x0002u)
        #define OutputD_INTR_BOTH      (uint16)(0x0003u) 
    /** @} intrMode */
/** @} group_constants */

    #define OutputD_INTR_MASK      (0x01u) 
#endif /* (OutputD__INTSTAT) */


/***************************************
*             Registers        
***************************************/

/* Main Port Registers */
/* Pin State */
#define OutputD_PS                     (* (reg8 *) OutputD__PS)
/* Data Register */
#define OutputD_DR                     (* (reg8 *) OutputD__DR)
/* Port Number */
#define OutputD_PRT_NUM                (* (reg8 *) OutputD__PRT) 
/* Connect to Analog Globals */                                                  
#define OutputD_AG                     (* (reg8 *) OutputD__AG)                       
/* Analog MUX bux enable */
#define OutputD_AMUX                   (* (reg8 *) OutputD__AMUX) 
/* Bidirectional Enable */                                                        
#define OutputD_BIE                    (* (reg8 *) OutputD__BIE)
/* Bit-mask for Aliased Register Access */
#define OutputD_BIT_MASK               (* (reg8 *) OutputD__BIT_MASK)
/* Bypass Enable */
#define OutputD_BYP                    (* (reg8 *) OutputD__BYP)
/* Port wide control signals */                                                   
#define OutputD_CTL                    (* (reg8 *) OutputD__CTL)
/* Drive Modes */
#define OutputD_DM0                    (* (reg8 *) OutputD__DM0) 
#define OutputD_DM1                    (* (reg8 *) OutputD__DM1)
#define OutputD_DM2                    (* (reg8 *) OutputD__DM2) 
/* Input Buffer Disable Override */
#define OutputD_INP_DIS                (* (reg8 *) OutputD__INP_DIS)
/* LCD Common or Segment Drive */
#define OutputD_LCD_COM_SEG            (* (reg8 *) OutputD__LCD_COM_SEG)
/* Enable Segment LCD */
#define OutputD_LCD_EN                 (* (reg8 *) OutputD__LCD_EN)
/* Slew Rate Control */
#define OutputD_SLW                    (* (reg8 *) OutputD__SLW)

/* DSI Port Registers */
/* Global DSI Select Register */
#define OutputD_PRTDSI__CAPS_SEL       (* (reg8 *) OutputD__PRTDSI__CAPS_SEL) 
/* Double Sync Enable */
#define OutputD_PRTDSI__DBL_SYNC_IN    (* (reg8 *) OutputD__PRTDSI__DBL_SYNC_IN) 
/* Output Enable Select Drive Strength */
#define OutputD_PRTDSI__OE_SEL0        (* (reg8 *) OutputD__PRTDSI__OE_SEL0) 
#define OutputD_PRTDSI__OE_SEL1        (* (reg8 *) OutputD__PRTDSI__OE_SEL1) 
/* Port Pin Output Select Registers */
#define OutputD_PRTDSI__OUT_SEL0       (* (reg8 *) OutputD__PRTDSI__OUT_SEL0) 
#define OutputD_PRTDSI__OUT_SEL1       (* (reg8 *) OutputD__PRTDSI__OUT_SEL1) 
/* Sync Output Enable Registers */
#define OutputD_PRTDSI__SYNC_OUT       (* (reg8 *) OutputD__PRTDSI__SYNC_OUT) 

/* SIO registers */
#if defined(OutputD__SIO_CFG)
    #define OutputD_SIO_HYST_EN        (* (reg8 *) OutputD__SIO_HYST_EN)
    #define OutputD_SIO_REG_HIFREQ     (* (reg8 *) OutputD__SIO_REG_HIFREQ)
    #define OutputD_SIO_CFG            (* (reg8 *) OutputD__SIO_CFG)
    #define OutputD_SIO_DIFF           (* (reg8 *) OutputD__SIO_DIFF)
#endif /* (OutputD__SIO_CFG) */

/* Interrupt Registers */
#if defined(OutputD__INTSTAT)
    #define OutputD_INTSTAT            (* (reg8 *) OutputD__INTSTAT)
    #define OutputD_SNAP               (* (reg8 *) OutputD__SNAP)
    
	#define OutputD_0_INTTYPE_REG 		(* (reg8 *) OutputD__0__INTTYPE)
#endif /* (OutputD__INTSTAT) */

#endif /* CY_PSOC5A... */

#endif /*  CY_PINS_OutputD_H */


/* [] END OF FILE */
