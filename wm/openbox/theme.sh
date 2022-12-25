#!/bin/bash

git clone https://github.com/ArchieTani/openbox-theme-collections ~/.themes
git clone https://github.com/ArchieTani/tint2-theme-collections ~/.config/tint2 --depth 1
mkdir -p ~/.config/openbox
cp autostart ~/.config/openbox/
