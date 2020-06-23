/*******************************************************************************
* File Name: InputB.h  
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

#if !defined(CY_PINS_InputB_H) /* Pins InputB_H */
#define CY_PINS_InputB_H

#include "cytypes.h"
#include "cyfitter.h"
#include "cypins.h"
#include "InputB_aliases.h"

/* APIs are not generated for P15[7:6] */
#if !(CY_PSOC5A &&\
	 InputB__PORT == 15 && ((InputB__MASK & 0xC0) != 0))


/***************************************
*        Function Prototypes             
***************************************/    

/**
* \addtogroup group_general
* @{
*/
void    InputB_Write(uint8 value);
void    InputB_SetDriveMode(uint8 mode);
uint8   InputB_ReadDataReg(void);
uint8   InputB_Read(void);
void    InputB_SetInterruptMode(uint16 position, uint16 mode);
uint8   InputB_ClearInterrupt(void);
/** @} general */

/***************************************
*           API Constants        
***************************************/
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup driveMode Drive mode constants
     * \brief Constants to be passed as "mode" parameter in the InputB_SetDriveMode() function.
     *  @{
     */
        #define InputB_DM_ALG_HIZ         PIN_DM_ALG_HIZ
        #define InputB_DM_DIG_HIZ         PIN_DM_DIG_HIZ
        #define InputB_DM_RES_UP          PIN_DM_RES_UP
        #define InputB_DM_RES_DWN         PIN_DM_RES_DWN
        #define InputB_DM_OD_LO           PIN_DM_OD_LO
        #define InputB_DM_OD_HI           PIN_DM_OD_HI
        #define InputB_DM_STRONG          PIN_DM_STRONG
        #define InputB_DM_RES_UPDWN       PIN_DM_RES_UPDWN
    /** @} driveMode */
/** @} group_constants */
    
/* Digital Port Constants */
#define InputB_MASK               InputB__MASK
#define InputB_SHIFT              InputB__SHIFT
#define InputB_WIDTH              1u

/* Interrupt constants */
#if defined(InputB__INTSTAT)
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup intrMode Interrupt constants
     * \brief Constants to be passed as "mode" parameter in InputB_SetInterruptMode() function.
     *  @{
     */
        #define InputB_INTR_NONE      (uint16)(0x0000u)
        #define InputB_INTR_RISING    (uint16)(0x0001u)
        #define InputB_INTR_FALLING   (uint16)(0x0002u)
        #define InputB_INTR_BOTH      (uint16)(0x0003u) 
    /** @} intrMode */
/** @} group_constants */

    #define InputB_INTR_MASK      (0x01u) 
#endif /* (InputB__INTSTAT) */


/***************************************
*             Registers        
***************************************/

/* Main Port Registers */
/* Pin State */
#define InputB_PS                     (* (reg8 *) InputB__PS)
/* Data Register */
#define InputB_DR                     (* (reg8 *) InputB__DR)
/* Port Number */
#define InputB_PRT_NUM                (* (reg8 *) InputB__PRT) 
/* Connect to Analog Globals */                                                  
#define InputB_AG                     (* (reg8 *) InputB__AG)                       
/* Analog MUX bux enable */
#define InputB_AMUX                   (* (reg8 *) InputB__AMUX) 
/* Bidirectional Enable */                                                        
#define InputB_BIE                    (* (reg8 *) InputB__BIE)
/* Bit-mask for Aliased Register Access */
#define InputB_BIT_MASK               (* (reg8 *) InputB__BIT_MASK)
/* Bypass Enable */
#define InputB_BYP                    (* (reg8 *) InputB__BYP)
/* Port wide control signals */                                                   
#define InputB_CTL                    (* (reg8 *) InputB__CTL)
/* Drive Modes */
#define InputB_DM0                    (* (reg8 *) InputB__DM0) 
#define InputB_DM1                    (* (reg8 *) InputB__DM1)
#define InputB_DM2                    (* (reg8 *) InputB__DM2) 
/* Input Buffer Disable Override */
#define InputB_INP_DIS                (* (reg8 *) InputB__INP_DIS)
/* LCD Common or Segment Drive */
#define InputB_LCD_COM_SEG            (* (reg8 *) InputB__LCD_COM_SEG)
/* Enable Segment LCD */
#define InputB_LCD_EN                 (* (reg8 *) InputB__LCD_EN)
/* Slew Rate Control */
#define InputB_SLW                    (* (reg8 *) InputB__SLW)

/* DSI Port Registers */
/* Global DSI Select Register */
#define InputB_PRTDSI__CAPS_SEL       (* (reg8 *) InputB__PRTDSI__CAPS_SEL) 
/* Double Sync Enable */
#define InputB_PRTDSI__DBL_SYNC_IN    (* (reg8 *) InputB__PRTDSI__DBL_SYNC_IN) 
/* Output Enable Select Drive Strength */
#define InputB_PRTDSI__OE_SEL0        (* (reg8 *) InputB__PRTDSI__OE_SEL0) 
#define InputB_PRTDSI__OE_SEL1        (* (reg8 *) InputB__PRTDSI__OE_SEL1) 
/* Port Pin Output Select Registers */
#define InputB_PRTDSI__OUT_SEL0       (* (reg8 *) InputB__PRTDSI__OUT_SEL0) 
#define InputB_PRTDSI__OUT_SEL1       (* (reg8 *) InputB__PRTDSI__OUT_SEL1) 
/* Sync Output Enable Registers */
#define InputB_PRTDSI__SYNC_OUT       (* (reg8 *) InputB__PRTDSI__SYNC_OUT) 

/* SIO registers */
#if defined(InputB__SIO_CFG)
    #define InputB_SIO_HYST_EN        (* (reg8 *) InputB__SIO_HYST_EN)
    #define InputB_SIO_REG_HIFREQ     (* (reg8 *) InputB__SIO_REG_HIFREQ)
    #define InputB_SIO_CFG            (* (reg8 *) InputB__SIO_CFG)
    #define InputB_SIO_DIFF           (* (reg8 *) InputB__SIO_DIFF)
#endif /* (InputB__SIO_CFG) */

/* Interrupt Registers */
#if defined(InputB__INTSTAT)
    #define InputB_INTSTAT            (* (reg8 *) InputB__INTSTAT)
    #define InputB_SNAP               (* (reg8 *) InputB__SNAP)
    
	#define InputB_0_INTTYPE_REG 		(* (reg8 *) InputB__0__INTTYPE)
#endif /* (InputB__INTSTAT) */

#endif /* CY_PSOC5A... */

#endif /*  CY_PINS_InputB_H */


/* [] END OF FILE */
