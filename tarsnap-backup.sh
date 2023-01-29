#!/bin/bash
tarsnap -c --cachedir ~/.local/share/tarsnap/ --keyfile ~/.keepass/tarsnap.key -f "$(uname -n)-$(date +%Y-%m-%d_%H-%M-%S)" /home/adam/.keepass /home/adam/Documents/Car /home/adam/Documents/Notes 
