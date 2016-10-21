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

/** LUFA CDC Class driver interface configuration and state information. This structure is
 *  passed to all CDC Class driver functions, so that multiple instances of the same class
 *  within a device can be differentiated from one another.
 */
/*USB_ClassInfo_CDC_Device_t VirtualSerial_CDC_Interface =
	{
		.Config =
			{
				.ControlInterfaceNumber   = INTERFACE_ID_CDC_CCI,
				.DataINEndpoint           =
					{
						.Address          = CDC_TX_EPADDR,
						.Size             = CDC_TXRX_EPSIZE,
						.Banks            = 1,
					},
				.DataOUTEndpoint =
					{
						.Address          = CDC_RX_EPADDR,
						.Size             = CDC_TXRX_EPSIZE,
						.Banks            = 1,
					},
				.NotificationEndpoint =
					{
						.Address          = CDC_NOTIFICATION_EPADDR,
						.Size             = CDC_NOTIFICATION_EPSIZE,
						.Banks            = 1,
					},
			},
	};*/

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

/** Standard file stream for the CDC interface when set up, so that the virtual CDC COM port can be
 *  used like any regular character stream in the C APIs.
 */
static FILE USBSerialStream;
static FILE UARTSerialStream;


/** Main program entry point. This routine contains the overall program flow, including initial
 *  setup of all components and the main program loop.
 */
int main(void)
{
	SetupHardware();

	GlobalInterruptEnable();

	/* Create a regular character stream for the interface so that it can be used with the stdio.h functions */
	// CDC_Device_CreateStream(&VirtualSerial_CDC_Interface, &USBSerialStream);

	// Serial_CreateStream(&UARTSerialStream);
	
	

	for (;;)
	{
		// int charIn;
		// while ((charIn = fgetc(&USBSerialStream)) != EOF)
		// {
			// fputc(charIn, &USBSerialStream);
			// if (charIn == '~')
			// {
				// EnterBootloader();
			// }
		// }
		//while ((charIn = fgetc(&UARTSerialStream)) != EOF)
		//{
		//	fputc(charIn, &USBSerialStream);
		//}

		// CDC_Device_USBTask(&VirtualSerial_CDC_Interface);
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
	// Serial_Init(9600, false);
	
	DDRB  |= 0b01000000;
	PORTB |= 0b01000000;
}

/** Event handler for the library USB Connection event. */
void EVENT_USB_Device_Connect(void) {}

/** Event handler for the library USB Disconnection event. */
void EVENT_USB_Device_Disconnect(void) {}

/** Event handler for the library USB Configuration Changed event. */
void EVENT_USB_Device_ConfigurationChanged(void)
{
	// CDC_Device_ConfigureEndpoints(&VirtualSerial_CDC_Interface);
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
	// CDC_Device_ProcessControlRequest(&VirtualSerial_CDC_Interface);
	HID_Device_ProcessControlRequest(&Mouse_HID_Interface);
	HID_Device_ProcessControlRequest(&Keyboard_HID_Interface);
}

/** CDC class driver callback function the processing of changes to the virtual
 *  control lines sent from the host..
 *
 *  \param[in] CDCInterfaceInfo  Pointer to the CDC class interface configuration structure being referenced
 */
// void EVENT_CDC_Device_ControLineStateChanged(USB_ClassInfo_CDC_Device_t *const CDCInterfaceInfo)
// {
	// /* You can get changes to the virtual CDC lines in this callback; a common
	   // use-case is to use the Data Terminal Ready (DTR) flag to enable and
	   // disable CDC communications in your application when set to avoid the
	   // application blocking while waiting for a host to become ready and read
	   // in the pending data from the USB endpoints.
	// */
// }

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
	if (HIDInterfaceInfo == &Keyboard_HID_Interface)
	{
			USB_KeyboardReport_Data_t* KeyboardReport = (USB_KeyboardReport_Data_t*)ReportData;
			*ReportSize = sizeof(USB_KeyboardReport_Data_t);
			return false;
	}
	else if (HIDInterfaceInfo == &Mouse_HID_Interface)
	{
			USB_MouseReport_Data_t* MouseReport = (USB_MouseReport_Data_t*)ReportData;
			*ReportSize = sizeof(USB_MouseReport_Data_t);
			return true;
	}
	
	return true;
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
