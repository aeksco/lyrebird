
# USB HID Keyboard
# http://www.usb.org/developers/hidpage/Hut1_12v2.pdf

# Defines a map of characters to the packets
# that must be sent to the device as keystrokes
# This is a work-in-progress and our approach may change
# as the app continues to evolve.
charMap = {

  # Lowercase
  'a':      [0, 4]
  'b':      [0, 5]
  'c':      [0, 6]
  'd':      [0, 7]
  'e':      [0, 8]
  'f':      [0, 9]
  'g':      [0,10]
  'h':      [0,11]
  'i':      [0,12]
  'j':      [0,13]
  'k':      [0,14]
  'l':      [0,15]
  'm':      [0,16]
  'n':      [0,17]
  'o':      [0,18]
  'p':      [0,19]
  'q':      [0,20]
  'r':      [0,21]
  's':      [0,22]
  't':      [0,23]
  'u':      [0,24]
  'v':      [0,25]
  'w':      [0,26]
  'x':      [0,27]
  'y':      [0,28]
  'z':      [0,29]

  # Uppercase
  'A':      [2, 4]
  'B':      [2, 5]
  'C':      [2, 6]
  'D':      [2, 7]
  'E':      [2, 8]
  'F':      [2, 9]
  'G':      [2,10]
  'H':      [2,11]
  'I':      [2,12]
  'J':      [2,13]
  'K':      [2,14]
  'L':      [2,15]
  'M':      [2,16]
  'N':      [2,17]
  'O':      [2,18]
  'P':      [2,19]
  'Q':      [2,20]
  'R':      [2,21]
  'S':      [2,22]
  'T':      [2,23]
  'U':      [2,24]
  'V':      [2,25]
  'W':      [2,26]
  'X':      [2,27]
  'Y':      [2,28]
  'Z':      [2,29]

  # Numeric
  '1':      [0,30]
  '2':      [0,31]
  '3':      [0,32]
  '4':      [0,33]
  '5':      [0,34]
  '6':      [0,35]
  '7':      [0,36]
  '8':      [0,37]
  '9':      [0,38]
  '0':      [0,39]

  # Numeric + Shift
  '!':      [2,30]
  '@':      [2,31]
  '#':      [2,32]
  '$':      [2,33]
  '%':      [2,34]
  '^':      [2,35]
  '&':      [2,36]
  '*':      [2,37]
  '(':      [2,38]
  ')':      [2,39]

  # Else
  '.':      [0,99]
  'num':    [0,131]
  ' ':      [0,44]  # Space
  right:    [0,79]  # Right
  left:     [0,80]  # Left
  down:     [0,81]  # Down
  up:       [0,82]  # Up
  back:     [0,42]  # Backspace
  '/':      [0,84]
  '*':      [0,85]
  '-':      [0,86]
  '+':      [0,87]
  'enter':  [0,88]

}

# # # # #

module.exports = charMap

# Keyboard modifieres
# HID_KEYBOARD_MODIFIER_LEFTCTRL    = 0
# HID_KEYBOARD_MODIFIER_LEFTSHIFT   = 1
# HID_KEYBOARD_MODIFIER_LEFTALT     = 2
# HID_KEYBOARD_MODIFIER_LEFTGUI     = 3
# HID_KEYBOARD_MODIFIER_RIGHTCTRL   = 4
# HID_KEYBOARD_MODIFIER_RIGHTSHIFT  = 5
# HID_KEYBOARD_MODIFIER_RIGHTALT    = 6
# HID_KEYBOARD_MODIFIER_RIGHTGUI    = 7
