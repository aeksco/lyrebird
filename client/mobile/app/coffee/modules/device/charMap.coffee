# TODO - rethink this approach
# http://www.usb.org/developers/hidpage/Hut1_12v2.pdf
charMap = {
  a:        4
  b:        5
  c:        6
  d:        7
  e:        8
  f:        9
  g:        10
  h:        11
  i:        12
  j:        13
  k:        14
  l:        15
  m:        16
  n:        17
  o:        18
  p:        19
  q:        20
  r:        21
  s:        22
  t:        23
  u:        24
  v:        25
  w:        26
  x:        27
  y:        28
  z:        29
  ' ':      44  # Space
  right:    79  # Right
  left:     80  # Left
  down:     81  # Down
  up:       82  # Up
  back:     42  # Backspace
  '/':      84
  '*':      85
  '-':      86
  '+':      87
  'enter':  88
  '1':      89
  '2':      90
  '3':      91
  '4':      92
  '5':      93
  '6':      94
  '7':      95
  '8':      96
  '9':      97
  '0':      98
  '.':      99
  'num':    131
}

# # # # #

module.exports = charMap
