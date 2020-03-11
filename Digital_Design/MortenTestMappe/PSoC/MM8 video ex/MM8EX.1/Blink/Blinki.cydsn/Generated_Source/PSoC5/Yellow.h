/*******************************************************************************
* File Name: Yellow.h  
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

#if !defined(CY_PINS_Yellow_H) /* Pins Yellow_H */
#define CY_PINS_Yellow_H

#include "cytypes.h"
#include "cyfitter.h"
#include "cypins.h"
#include "Yellow_aliases.h"

/* APIs are not generated for P15[7:6] */
#if !(CY_PSOC5A &&\
	 Yellow__PORT == 15 && ((Yellow__MASK & 0xC0) != 0))


/***************************************
*        Function Prototypes             
***************************************/    

/**
* \addtogroup group_general
* @{
*/
void    Yellow_Write(uint8 value);
void    Yellow_SetDriveMode(uint8 mode);
uint8   Yellow_ReadDataReg(void);
uint8   Yellow_Read(void);
void    Yellow_SetInterruptMode(uint16 position, uint16 mode);
uint8   Yellow_ClearInterrupt(void);
/** @} general */

/***************************************
*           API Constants        
***************************************/
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup driveMode Drive mode constants
     * \brief Constants to be passed as "mode" parameter in the Yellow_SetDriveMode() function.
     *  @{
     */
        #define Yellow_DM_ALG_HIZ         PIN_DM_ALG_HIZ
        #define Yellow_DM_DIG_HIZ         PIN_DM_DIG_HIZ
        #define Yellow_DM_RES_UP          PIN_DM_RES_UP
        #define Yellow_DM_RES_DWN         PIN_DM_RES_DWN
        #define Yellow_DM_OD_LO           PIN_DM_OD_LO
        #define Yellow_DM_OD_HI           PIN_DM_OD_HI
        #define Yellow_DM_STRONG          PIN_DM_STRONG
        #define Yellow_DM_RES_UPDWN       PIN_DM_RES_UPDWN
    /** @} driveMode */
/** @} group_constants */
    
/* Digital Port Constants */
#define Yellow_MASK               Yellow__MASK
#define Yellow_SHIFT              Yellow__SHIFT
#define Yellow_WIDTH              1u

/* Interrupt constants */
#if defined(Yellow__INTSTAT)
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup intrMode Interrupt constants
     * \brief Constants to be passed as "mode" parameter in Yellow_SetInterruptMode() function.
     *  @{
     */
        #define Yellow_INTR_NONE      (uint16)(0x0000u)
        #define Yellow_INTR_RISING    (uint16)(0x0001u)
        #define Yellow_INTR_FALLING   (uint16)(0x0002u)
        #define Yellow_INTR_BOTH      (uint16)(0x0003u) 
    /** @} intrMode */
/** @} group_constants */

    #define Yellow_INTR_MASK      (0x01u) 
#endif /* (Yellow__INTSTAT) */


/***************************************
*             Registers        
***************************************/

/* Main Port Registers */
/* Pin State */
#define Yellow_PS                     (* (reg8 *) Yellow__PS)
/* Data Register */
#define Yellow_DR                     (* (reg8 *) Yellow__DR)
/* Port Number */
#define Yellow_PRT_NUM                (* (reg8 *) Yellow__PRT) 
/* Connect to Analog Globals */                                                  
#define Yellow_AG                     (* (reg8 *) Yellow__AG)                       
/* Analog MUX bux enable */
#define Yellow_AMUX                   (* (reg8 *) Yellow__AMUX) 
/* Bidirectional Enable */                                                        
#define Yellow_BIE                    (* (reg8 *) Yellow__BIE)
/* Bit-mask for Aliased Register Access */
#define Yellow_BIT_MASK               (* (reg8 *) Yellow__BIT_MASK)
/* Bypass Enable */
#define Yellow_BYP                    (* (reg8 *) Yellow__BYP)
/* Port wide control signals */                                                   
#define Yellow_CTL                    (* (reg8 *) Yellow__CTL)
/* Drive Modes */
#define Yellow_DM0                    (* (reg8 *) Yellow__DM0) 
#define Yellow_DM1                    (* (reg8 *) Yellow__DM1)
#define Yellow_DM2                    (* (reg8 *) Yellow__DM2) 
/* Input Buffer Disable Override */
#define Yellow_INP_DIS                (* (reg8 *) Yellow__INP_DIS)
/* LCD Common or Segment Drive */
#define Yellow_LCD_COM_SEG            (* (reg8 *) Yellow__LCD_COM_SEG)
/* Enable Segment LCD */
#define Yellow_LCD_EN                 (* (reg8 *) Yellow__LCD_EN)
/* Slew Rate Control */
#define Yellow_SLW                    (* (reg8 *) Yellow__SLW)

/* DSI Port Registers */
/* Global DSI Select Register */
#define Yellow_PRTDSI__CAPS_SEL       (* (reg8 *) Yellow__PRTDSI__CAPS_SEL) 
/* Double Sync Enable */
#define Yellow_PRTDSI__DBL_SYNC_IN    (* (reg8 *) Yellow__PRTDSI__DBL_SYNC_IN) 
/* Output Enable Select Drive Strength */
#define Yellow_PRTDSI__OE_SEL0        (* (reg8 *) Yellow__PRTDSI__OE_SEL0) 
#define Yellow_PRTDSI__OE_SEL1        (* (reg8 *) Yellow__PRTDSI__OE_SEL1) 
/* Port Pin Output Select Registers */
#define Yellow_PRTDSI__OUT_SEL0       (* (reg8 *) Yellow__PRTDSI__OUT_SEL0) 
#define Yellow_PRTDSI__OUT_SEL1       (* (reg8 *) Yellow__PRTDSI__OUT_SEL1) 
/* Sync Output Enable Registers */
#define Yellow_PRTDSI__SYNC_OUT       (* (reg8 *) Yellow__PRTDSI__SYNC_OUT) 

/* SIO registers */
#if defined(Yellow__SIO_CFG)
    #define Yellow_SIO_HYST_EN        (* (reg8 *) Yellow__SIO_HYST_EN)
    #define Yellow_SIO_REG_HIFREQ     (* (reg8 *) Yellow__SIO_REG_HIFREQ)
    #define Yellow_SIO_CFG            (* (reg8 *) Yellow__SIO_CFG)
    #define Yellow_SIO_DIFF           (* (reg8 *) Yellow__SIO_DIFF)
#endif /* (Yellow__SIO_CFG) */

/* Interrupt Registers */
#if defined(Yellow__INTSTAT)
    #define Yellow_INTSTAT            (* (reg8 *) Yellow__INTSTAT)
    #define Yellow_SNAP               (* (reg8 *) Yellow__SNAP)
    
	#define Yellow_0_INTTYPE_REG 		(* (reg8 *) Yellow__0__INTTYPE)
#endif /* (Yellow__INTSTAT) */

#endif /* CY_PSOC5A... */

#endif /*  CY_PINS_Yellow_H */


/* [] END OF FILE */
