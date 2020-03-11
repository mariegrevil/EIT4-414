/*******************************************************************************
* File Name: InputA.h  
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

#if !defined(CY_PINS_InputA_H) /* Pins InputA_H */
#define CY_PINS_InputA_H

#include "cytypes.h"
#include "cyfitter.h"
#include "cypins.h"
#include "InputA_aliases.h"

/* APIs are not generated for P15[7:6] */
#if !(CY_PSOC5A &&\
	 InputA__PORT == 15 && ((InputA__MASK & 0xC0) != 0))


/***************************************
*        Function Prototypes             
***************************************/    

/**
* \addtogroup group_general
* @{
*/
void    InputA_Write(uint8 value);
void    InputA_SetDriveMode(uint8 mode);
uint8   InputA_ReadDataReg(void);
uint8   InputA_Read(void);
void    InputA_SetInterruptMode(uint16 position, uint16 mode);
uint8   InputA_ClearInterrupt(void);
/** @} general */

/***************************************
*           API Constants        
***************************************/
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup driveMode Drive mode constants
     * \brief Constants to be passed as "mode" parameter in the InputA_SetDriveMode() function.
     *  @{
     */
        #define InputA_DM_ALG_HIZ         PIN_DM_ALG_HIZ
        #define InputA_DM_DIG_HIZ         PIN_DM_DIG_HIZ
        #define InputA_DM_RES_UP          PIN_DM_RES_UP
        #define InputA_DM_RES_DWN         PIN_DM_RES_DWN
        #define InputA_DM_OD_LO           PIN_DM_OD_LO
        #define InputA_DM_OD_HI           PIN_DM_OD_HI
        #define InputA_DM_STRONG          PIN_DM_STRONG
        #define InputA_DM_RES_UPDWN       PIN_DM_RES_UPDWN
    /** @} driveMode */
/** @} group_constants */
    
/* Digital Port Constants */
#define InputA_MASK               InputA__MASK
#define InputA_SHIFT              InputA__SHIFT
#define InputA_WIDTH              1u

/* Interrupt constants */
#if defined(InputA__INTSTAT)
/**
* \addtogroup group_constants
* @{
*/
    /** \addtogroup intrMode Interrupt constants
     * \brief Constants to be passed as "mode" parameter in InputA_SetInterruptMode() function.
     *  @{
     */
        #define InputA_INTR_NONE      (uint16)(0x0000u)
        #define InputA_INTR_RISING    (uint16)(0x0001u)
        #define InputA_INTR_FALLING   (uint16)(0x0002u)
        #define InputA_INTR_BOTH      (uint16)(0x0003u) 
    /** @} intrMode */
/** @} group_constants */

    #define InputA_INTR_MASK      (0x01u) 
#endif /* (InputA__INTSTAT) */


/***************************************
*             Registers        
***************************************/

/* Main Port Registers */
/* Pin State */
#define InputA_PS                     (* (reg8 *) InputA__PS)
/* Data Register */
#define InputA_DR                     (* (reg8 *) InputA__DR)
/* Port Number */
#define InputA_PRT_NUM                (* (reg8 *) InputA__PRT) 
/* Connect to Analog Globals */                                                  
#define InputA_AG                     (* (reg8 *) InputA__AG)                       
/* Analog MUX bux enable */
#define InputA_AMUX                   (* (reg8 *) InputA__AMUX) 
/* Bidirectional Enable */                                                        
#define InputA_BIE                    (* (reg8 *) InputA__BIE)
/* Bit-mask for Aliased Register Access */
#define InputA_BIT_MASK               (* (reg8 *) InputA__BIT_MASK)
/* Bypass Enable */
#define InputA_BYP                    (* (reg8 *) InputA__BYP)
/* Port wide control signals */                                                   
#define InputA_CTL                    (* (reg8 *) InputA__CTL)
/* Drive Modes */
#define InputA_DM0                    (* (reg8 *) InputA__DM0) 
#define InputA_DM1                    (* (reg8 *) InputA__DM1)
#define InputA_DM2                    (* (reg8 *) InputA__DM2) 
/* Input Buffer Disable Override */
#define InputA_INP_DIS                (* (reg8 *) InputA__INP_DIS)
/* LCD Common or Segment Drive */
#define InputA_LCD_COM_SEG            (* (reg8 *) InputA__LCD_COM_SEG)
/* Enable Segment LCD */
#define InputA_LCD_EN                 (* (reg8 *) InputA__LCD_EN)
/* Slew Rate Control */
#define InputA_SLW                    (* (reg8 *) InputA__SLW)

/* DSI Port Registers */
/* Global DSI Select Register */
#define InputA_PRTDSI__CAPS_SEL       (* (reg8 *) InputA__PRTDSI__CAPS_SEL) 
/* Double Sync Enable */
#define InputA_PRTDSI__DBL_SYNC_IN    (* (reg8 *) InputA__PRTDSI__DBL_SYNC_IN) 
/* Output Enable Select Drive Strength */
#define InputA_PRTDSI__OE_SEL0        (* (reg8 *) InputA__PRTDSI__OE_SEL0) 
#define InputA_PRTDSI__OE_SEL1        (* (reg8 *) InputA__PRTDSI__OE_SEL1) 
/* Port Pin Output Select Registers */
#define InputA_PRTDSI__OUT_SEL0       (* (reg8 *) InputA__PRTDSI__OUT_SEL0) 
#define InputA_PRTDSI__OUT_SEL1       (* (reg8 *) InputA__PRTDSI__OUT_SEL1) 
/* Sync Output Enable Registers */
#define InputA_PRTDSI__SYNC_OUT       (* (reg8 *) InputA__PRTDSI__SYNC_OUT) 

/* SIO registers */
#if defined(InputA__SIO_CFG)
    #define InputA_SIO_HYST_EN        (* (reg8 *) InputA__SIO_HYST_EN)
    #define InputA_SIO_REG_HIFREQ     (* (reg8 *) InputA__SIO_REG_HIFREQ)
    #define InputA_SIO_CFG            (* (reg8 *) InputA__SIO_CFG)
    #define InputA_SIO_DIFF           (* (reg8 *) InputA__SIO_DIFF)
#endif /* (InputA__SIO_CFG) */

/* Interrupt Registers */
#if defined(InputA__INTSTAT)
    #define InputA_INTSTAT            (* (reg8 *) InputA__INTSTAT)
    #define InputA_SNAP               (* (reg8 *) InputA__SNAP)
    
	#define InputA_0_INTTYPE_REG 		(* (reg8 *) InputA__0__INTTYPE)
#endif /* (InputA__INTSTAT) */

#endif /* CY_PSOC5A... */

#endif /*  CY_PINS_InputA_H */


/* [] END OF FILE */
