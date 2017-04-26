#!/bin/bash
echo Install Starting …
rm -rf ~/.bash ~/.bash_profile
git clone https://github.com/lpj0017/bash.git --depth=1 ~/.bash
ln -s ~/.bash/.bash_profile ~/.bash_profile
echo Done.
