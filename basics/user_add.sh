#!/bin/bash

echo "Adding user..."
read -p "Write new username: " USERNAME

useradd -m $USERNAME
passwd $USERNAME

usermod -aG wheel,audio,video,storage,uucp,lock $USERNAME

echo "Type 'visudo' and uncomment the line 'UNCOMMENT TO ALLO MEMBERS OF GROUP WHEEL TO EXECUTE ANY COMMAND"