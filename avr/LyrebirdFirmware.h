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
		void InitializeInputData(void);

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
		
		size_t GetPacketDataLength(uint8_t packetType);
		void ProcessPacket(uint8_t packetType, uint8_t* packet);
		

	/* Structs */
	
	/////////////
	// GENERAL //
	/////////////
	
	#define PACKET_MOUSE    1
	#define PACKET_KEYBOARD 2
	#define PACKET_JOYSTICK 3
	#define PACKET_CONTROL  255
	
	///////////
	// MOUSE //
	///////////
	
	#define MB_LEFT   0
	#define MB_RIGHT  1
	#define MB_MIDDLE 2
	
	/**
	* The data for a Mouse packet.
	*/
	typedef struct {
		int16_t dx;
		int16_t dy;
		uint8_t buttons;
	} MouseData;
	
	
	//////////////
	// KEYBOARD //
	//////////////
	
	/**
	* The data for a Keyboard packet.
	*/
	typedef struct {
		uint8_t keys[MAX_KEYS_PRESSED];
	} KeyboardData;
	
	
	//////////////
	// JOYSTICK //
	//////////////
	
	#define JOYB_A      0
	#define JOYB_B      1
	#define JOYB_X      2
	#define JOYB_Y      3
	#define JOYB_L1     4
	#define JOYB_R1     5
	#define JOYB_L2     6
	#define JOYB_R2     7
	#define JOYB_START  8
	#define JOYB_SELECT 9
	
	/**
	* The data for a Joystick packet.
	*/
	typedef struct {
		int8_t   lx;
		int8_t   ly;
		int8_t   rx;
		int8_t   ry;
		uint16_t buttons;
	} JoystickData;
	
	

#endif

