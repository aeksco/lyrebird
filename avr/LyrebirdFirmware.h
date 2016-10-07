#ifndef __LYREBIRDFIRMWARE_H__
#define __LYREBIRDFIRMWARE_H__

	/* Includes: */
		#include <avr/io.h>
		#include <avr/wdt.h>
		#include <avr/power.h>
		#include <avr/interrupt.h>
		#include <string.h>
		#include <stdio.h>

		#include "Descriptors.h"

		#include <LUFA/Drivers/USB/USB.h>
		#include <LUFA/Platform/Platform.h>
		#include <LUFA/Drivers/Peripheral/Serial.h>

	/* Function Prototypes: */
		void SetupHardware(void);

		void EVENT_USB_Device_Connect(void);
		void EVENT_USB_Device_Disconnect(void);
		void EVENT_USB_Device_ConfigurationChanged(void);
		void EVENT_USB_Device_ControlRequest(void);
		
		#define MAGIC_BOOT_KEY            0xDC42ACCA
		#define FLASH_SIZE_BYTES          0x4000
		#define BOOTLOADER_SEC_SIZE_BYTES 0x800 
		#define BOOTLOADER_START_ADDRESS  (FLASH_SIZE_BYTES - BOOTLOADER_SEC_SIZE_BYTES)
		void Bootloader_Jump_Check(void) ATTR_INIT_SECTION(3);
		void EnterBootloader(void);

#endif

