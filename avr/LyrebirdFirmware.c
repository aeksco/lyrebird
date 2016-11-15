#include "LyrebirdFirmware.h"

uint32_t Boot_Key ATTR_NO_INIT;

void Bootloader_Jump_Check(void)
{
	// If the reset source was the bootloader and the key is correct, clear it and jump to the bootloader
	if ((MCUSR & (1 << WDRF)) && (Boot_Key == MAGIC_BOOT_KEY))
	{
		Boot_Key = 0;
		((void (*)(void))BOOTLOADER_START_ADDRESS)();
	}
}

void EnterBootloader()
{
	USB_Disable();
	cli();
	Delay_MS(2000);
	Boot_Key = MAGIC_BOOT_KEY;
	wdt_enable(WDTO_15MS);
	while (1);
}

/** Buffer to hold the previously generated Mouse HID report, for comparison purposes inside the HID class driver. */
static uint8_t PrevMouseHIDReportBuffer[sizeof(USB_MouseReport_Data_t)];

/** LUFA HID Class driver interface configuration and state information. This structure is
 *  passed to all HID Class driver functions, so that multiple instances of the same class
 *  within a device can be differentiated from one another.
 */
USB_ClassInfo_HID_Device_t Mouse_HID_Interface =
	{
		.Config =
			{
				.InterfaceNumber                = INTERFACE_ID_Mouse,
				.ReportINEndpoint               =
					{
						.Address                = MOUSE_EPADDR,
						.Size                   = MOUSE_EPSIZE,
						.Banks                  = 1,
					},
				.PrevReportINBuffer             = PrevMouseHIDReportBuffer,
				.PrevReportINBufferSize         = sizeof(PrevMouseHIDReportBuffer),
			},
	};

/** Buffer to hold the previously generated Keyboard HID report, for comparison purposes inside the HID class driver. */
static uint8_t PrevKeyboardHIDReportBuffer[sizeof(USB_KeyboardReport_Data_t)];

/** LUFA HID Class driver interface configuration and state information. This structure is
 *  passed to all HID Class driver functions, so that multiple instances of the same class
 *  within a device can be differentiated from one another.
 */
USB_ClassInfo_HID_Device_t Keyboard_HID_Interface =
	{
		.Config =
			{
				.InterfaceNumber                = INTERFACE_ID_Keyboard,
				.ReportINEndpoint               =
					{
						.Address                = KEYBOARD_EPADDR,
						.Size                   = KEYBOARD_EPSIZE,
						.Banks                  = 1,
					},
				.PrevReportINBuffer             = PrevKeyboardHIDReportBuffer,
				.PrevReportINBufferSize         = sizeof(PrevKeyboardHIDReportBuffer),
			},
	};
	
MouseData    mouse_data;
KeyboardData keyboard_data;
JoystickData joystick_data;

/** Returns the length of the given packet type.
 *  @param packetType The type of packet to get the length of
 */
size_t GetPacketDataLength(uint8_t packetType)
{
	switch (packetType)
	{
		case PACKET_CONTROL:
			return 0;
		case PACKET_MOUSE:
			return sizeof(KeyboardData);
		case PACKET_KEYBOARD:
			return sizeof(MouseData);
		case PACKET_JOYSTICK:
			return sizeof(JoystickData);
		default:
			return 0;
	}
}

/** Processes a received packet.
 *  @packetType The type of packet received
 *  @packetData The received packet data
 */
void ProcessPacket(uint8_t packetType, uint8_t* packetData)
{
	switch (packetType)
	{
		case PACKET_CONTROL:
			break;
		case PACKET_MOUSE:
			memcpy(&mouse_data, packetData, sizeof(MouseData));
			break;
		case PACKET_KEYBOARD:
			memcpy(&keyboard_data, packetData, sizeof(KeyboardData));
			break;
		case PACKET_JOYSTICK:
			memcpy(&joystick_data, packetData, sizeof(JoystickData));
			break;
	}
}

/** Main program entry point. This routine contains the overall program flow, including initial
 *  setup of all components and the main program loop.
 */
int main(void)
{
	uint8_t packetType = 0;
	size_t bytesReceived = 0;
	size_t packetLength = 0;
	
	uint8_t packetBuffer[16] = {0};
	SetupHardware();
	InitializeInputData();

	GlobalInterruptEnable();

	/* Create a regular character stream for the interface so that it can be used with the stdio.h functions */
	
	// Send a dummy AT command (the HM-11 will often skip the first command for some reason)
	Serial_SendString("AT");
	Delay_MS(10);
	// Set the HM-11's name to Lyrebird
	Serial_SendString("AT+NAMELyrebird");
	Delay_MS(10);
	// Reset the HM-11 so that it reflects the new name
	Serial_SendString("AT+RESET");
	Delay_MS(10);
	
	for (;;)
	{
		// Check for any data received from the paired device
		while (Serial_IsCharReceived())
		{
			// Record the packet type
			if (bytesReceived == 0)
			{
				packetType    = Serial_ReceiveByte();
				packetLength  = GetPacketDataLength(packetType);
			}
			// Fill in more packet data
			else
			{
				packetBuffer[bytesReceived] = Serial_ReceiveByte();
				bytesReceived++;
			}
			// Full packet has been received, process it
			if (bytesReceived >= packetLength)
			{
				ProcessPacket(packetType, packetBuffer);
				
				// Reset packet
				packetType    = 0;
				packetLength  = 0;
				bytesReceived = 0;
			}
		}

		// Serve USB tasks
		HID_Device_USBTask(&Mouse_HID_Interface);
		HID_Device_USBTask(&Keyboard_HID_Interface);
		USB_USBTask();
	}
}

/** Configures the board hardware and chip peripherals for the demo's functionality. */
void SetupHardware(void)
{
	/* Disable watchdog if enabled by bootloader/fuses */
	MCUSR &= ~(1 << WDRF);
	wdt_disable();

	/* Disable clock division */
	clock_prescale_set(clock_div_1);

	/* Hardware Initialization */
	USB_Init();
	Serial_Init(9600, false);
}

/** Initializes the input data being sent to the USB host. */
void InitializeInputData(void)
{
	// Initialize mouse data
	mouse_data.dx = 0;
	mouse_data.dy = 0;
	mouse_data.buttons = 0x00;
	
	// Initialize keyboard data
	memset(keyboard_data.keys, 0, sizeof(uint8_t) * MAX_KEYS_PRESSED);
	
	// Initialize joystick data
	joystick_data.lx = 0;
	joystick_data.ly = 0;
	joystick_data.rx = 0;
	joystick_data.ry = 0;
	joystick_data.buttons = 0x0000;
}

/** Event handler for the library USB Connection event. */
void EVENT_USB_Device_Connect(void) {}

/** Event handler for the library USB Disconnection event. */
void EVENT_USB_Device_Disconnect(void) {}

/** Event handler for the library USB Configuration Changed event. */
void EVENT_USB_Device_ConfigurationChanged(void)
{
	HID_Device_ConfigureEndpoints(&Mouse_HID_Interface);
	HID_Device_ConfigureEndpoints(&Keyboard_HID_Interface);

	USB_Device_EnableSOFEvents();
}

/** Event handler for the USB device Start Of Frame event. */
void EVENT_USB_Device_StartOfFrame(void)
{
	HID_Device_MillisecondElapsed(&Mouse_HID_Interface);
	HID_Device_MillisecondElapsed(&Keyboard_HID_Interface);
}

/** Event handler for the library USB Control Request reception event. */
void EVENT_USB_Device_ControlRequest(void)
{
	HID_Device_ProcessControlRequest(&Mouse_HID_Interface);
	HID_Device_ProcessControlRequest(&Keyboard_HID_Interface);
}

int APressed = 0;

/** HID class driver callback function for the creation of HID reports to the host.
 *
 *  \param[in]     HIDInterfaceInfo  Pointer to the HID class interface configuration structure being referenced
 *  \param[in,out] ReportID    Report ID requested by the host if non-zero, otherwise callback should set to the generated report ID
 *  \param[in]     ReportType  Type of the report to create, either HID_REPORT_ITEM_In or HID_REPORT_ITEM_Feature
 *  \param[out]    ReportData  Pointer to a buffer where the created report should be stored
 *  \param[out]    ReportSize  Number of bytes written in the report (or zero if no report is to be sent)
 *
 *  \return Boolean \c true to force the sending of the report, \c false to let the library determine if it needs to be sent
 */
bool CALLBACK_HID_Device_CreateHIDReport(USB_ClassInfo_HID_Device_t* const HIDInterfaceInfo,
                                         uint8_t* const ReportID,
                                         const uint8_t ReportType,
                                         void* ReportData,
                                         uint16_t* const ReportSize)
{
	uint8_t i;
	if (HIDInterfaceInfo == &Keyboard_HID_Interface)
	{
			USB_KeyboardReport_Data_t* KeyboardReport = (USB_KeyboardReport_Data_t*)ReportData;
			
			for (i = 0; i < MAX_KEYS_PRESSED; i++)
			{
				KeyboardReport -> KeyCode[i] = keyboard_data.keys[i];
			}
			
			*ReportSize = sizeof(USB_KeyboardReport_Data_t);
			return false;
	}
	else if (HIDInterfaceInfo == &Mouse_HID_Interface)
	{
			USB_MouseReport_Data_t* MouseReport = (USB_MouseReport_Data_t*)ReportData;
			MouseReport -> X = mouse_data.dx;
			MouseReport -> Y = mouse_data.dy;
			MouseReport -> Button = mouse_data.buttons;
			
			// Reset mouse data after mouse movement has been sent
			mouse_data.dx = 0;
			mouse_data.dy = 0;
			
			*ReportSize = sizeof(USB_MouseReport_Data_t);
			// Force LUFA to send packet, as dx and dy not changing means the mouse should continue to move
			return true;
	}
	
	return false;
}

/** HID class driver callback function for the processing of HID reports from the host.
 *
 *  \param[in] HIDInterfaceInfo  Pointer to the HID class interface configuration structure being referenced
 *  \param[in] ReportID    Report ID of the received report from the host
 *  \param[in] ReportType  The type of report that the host has sent, either HID_REPORT_ITEM_Out or HID_REPORT_ITEM_Feature
 *  \param[in] ReportData  Pointer to a buffer where the received report has been stored
 *  \param[in] ReportSize  Size in bytes of the received HID report
 */
void CALLBACK_HID_Device_ProcessHIDReport(USB_ClassInfo_HID_Device_t* const HIDInterfaceInfo,
                                          const uint8_t ReportID,
                                          const uint8_t ReportType,
                                          const void* ReportData,
                                          const uint16_t ReportSize)
{}
