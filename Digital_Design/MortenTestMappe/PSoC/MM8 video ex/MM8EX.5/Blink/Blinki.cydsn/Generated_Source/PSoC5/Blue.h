/*******************************************************************************
* File Name: Blue.h  
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

#if !defined(CY_PINS_Blue_H) /* Pins Blue_H */
#define CY_PINS_Blue_H

#include "cytypes.h"
#include "cyfitter.h"
#include "cypins.h"
#include "Blue_aliases.h"

/* APIs are not generated for P15[7:6] */
#if !(CY_PSOC5A &&\
	 Blue__PORT == 15 && ((Blue__MASK & 0xC0) != 0))


/***************************************
*        Function Prototypes             
***************************************/    

/**
* \addtogroup group_general
* @{
*/
void    Blue_Write(uint8 value);
void    Blue_SetDriveMode(uint8 mode);
uint8   Blue_ReadDataReg(void);
uint8   Blue_Read(void);
void    Blue_SetInterruptMode(uint16 position, uint16 mode);
uint8   Blue_ClearInterrupt(void);
/** @} general */

/***************************************
*           API Constants        
***************************************/
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup driveMode Drive mode constants
     * \brief Constants to be passed as "mode" parameter in the Blue_SetDriveMode() function.
     *  @{
     */
        #define Blue_DM_ALG_HIZ         PIN_DM_ALG_HIZ
        #define Blue_DM_DIG_HIZ         PIN_DM_DIG_HIZ
        #define Blue_DM_RES_UP          PIN_DM_RES_UP
        #define Blue_DM_RES_DWN         PIN_DM_RES_DWN
        #define Blue_DM_OD_LO           PIN_DM_OD_LO
        #define Blue_DM_OD_HI           PIN_DM_OD_HI
        #define Blue_DM_STRONG          PIN_DM_STRONG
        #define Blue_DM_RES_UPDWN       PIN_DM_RES_UPDWN
    /** @} driveMode */
/** @} group_constants */
    
/* Digital Port Constants */
#define Blue_MASK               Blue__MASK
#define Blue_SHIFT              Blue__SHIFT
#define Blue_WIDTH              1u

/* Interrupt constants */
#if defined(Blue__INTSTAT)
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup intrMode Interrupt constants
     * \brief Constants to be passed as "mode" parameter in Blue_SetInterruptMode() function.
     *  @{
     */
        #define Blue_INTR_NONE      (uint16)(0x0000u)
        #define Blue_INTR_RISING    (uint16)(0x0001u)
        #define Blue_INTR_FALLING   (uint16)(0x0002u)
        #define Blue_INTR_BOTH      (uint16)(0x0003u) 
    /** @} intrMode */
/** @} group_constants */

    #define Blue_INTR_MASK      (0x01u) 
#endif /* (Blue__INTSTAT) */


/***************************************
*             Registers        
***************************************/

/* Main Port Registers */
/* Pin State */
#define Blue_PS                     (* (reg8 *) Blue__PS)
/* Data Register */
#define Blue_DR                     (* (reg8 *) Blue__DR)
/* Port Number */
#define Blue_PRT_NUM                (* (reg8 *) Blue__PRT) 
/* Connect to Analog Globals */                                                  
#define Blue_AG                     (* (reg8 *) Blue__AG)                       
/* Analog MUX bux enable */
#define Blue_AMUX                   (* (reg8 *) Blue__AMUX) 
/* Bidirectional Enable */                                                        
#define Blue_BIE                    (* (reg8 *) Blue__BIE)
/* Bit-mask for Aliased Register Access */
#define Blue_BIT_MASK               (* (reg8 *) Blue__BIT_MASK)
/* Bypass Enable */
#define Blue_BYP                    (* (reg8 *) Blue__BYP)
/* Port wide control signals */                                                   
#define Blue_CTL                    (* (reg8 *) Blue__CTL)
/* Drive Modes */
#define Blue_DM0                    (* (reg8 *) Blue__DM0) 
#define Blue_DM1                    (* (reg8 *) Blue__DM1)
#define Blue_DM2                    (* (reg8 *) Blue__DM2) 
/* Input Buffer Disable Override */
#define Blue_INP_DIS                (* (reg8 *) Blue__INP_DIS)
/* LCD Common or Segment Drive */
#define Blue_LCD_COM_SEG            (* (reg8 *) Blue__LCD_COM_SEG)
/* Enable Segment LCD */
#define Blue_LCD_EN                 (* (reg8 *) Blue__LCD_EN)
/* Slew Rate Control */
#define Blue_SLW                    (* (reg8 *) Blue__SLW)

/* DSI Port Registers */
/* Global DSI Select Register */
#define Blue_PRTDSI__CAPS_SEL       (* (reg8 *) Blue__PRTDSI__CAPS_SEL) 
/* Double Sync Enable */
#define Blue_PRTDSI__DBL_SYNC_IN    (* (reg8 *) Blue__PRTDSI__DBL_SYNC_IN) 
/* Output Enable Select Drive Strength */
#define Blue_PRTDSI__OE_SEL0        (* (reg8 *) Blue__PRTDSI__OE_SEL0) 
#define Blue_PRTDSI__OE_SEL1        (* (reg8 *) Blue__PRTDSI__OE_SEL1) 
/* Port Pin Output Select Registers */
#define Blue_PRTDSI__OUT_SEL0       (* (reg8 *) Blue__PRTDSI__OUT_SEL0) 
#define Blue_PRTDSI__OUT_SEL1       (* (reg8 *) Blue__PRTDSI__OUT_SEL1) 
/* Sync Output Enable Registers */
#define Blue_PRTDSI__SYNC_OUT       (* (reg8 *) Blue__PRTDSI__SYNC_OUT) 

/* SIO registers */
#if defined(Blue__SIO_CFG)
    #define Blue_SIO_HYST_EN        (* (reg8 *) Blue__SIO_HYST_EN)
    #define Blue_SIO_REG_HIFREQ     (* (reg8 *) Blue__SIO_REG_HIFREQ)
    #define Blue_SIO_CFG            (* (reg8 *) Blue__SIO_CFG)
    #define Blue_SIO_DIFF           (* (reg8 *) Blue__SIO_DIFF)
#endif /* (Blue__SIO_CFG) */

/* Interrupt Registers */
#if defined(Blue__INTSTAT)
    #define Blue_INTSTAT            (* (reg8 *) Blue__INTSTAT)
    #define Blue_SNAP               (* (reg8 *) Blue__SNAP)
    
	#define Blue_0_INTTYPE_REG 		(* (reg8 *) Blue__0__INTTYPE)
#endif /* (Blue__INTSTAT) */

#endif /* CY_PSOC5A... */

#endif /*  CY_PINS_Blue_H */


/* [] END OF FILE */
