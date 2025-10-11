#!/bin/bash

echo "Adding user..."
echo "Type user name:"
read USERNAME

useradd -m $USERNAME
passwd $USERNAME

usermod -aG wheel,audio,video,storage $USERNAME

echo "Type 'visudo' and uncomment the line 'UNCOMMENT TO ALLO MEMBERS OF GROUP WHEEL TO EXECUTE ANY COMMAND"
