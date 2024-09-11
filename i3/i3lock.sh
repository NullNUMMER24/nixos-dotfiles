 # take screenshot

import -window root /tmp/screenshot.png

# blur it

magick /tmp/screenshot.png -blur 0x7 /tmp/screenshotblur.png

rm /tmp/screenshot.png

# lock the screen

i3lock -efkt -i /tmp/screenshotblur.png 
