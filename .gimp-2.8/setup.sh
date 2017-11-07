#!/usr/bin/env bash

set -e

echo 'Install icc color profiles...'
sudo apt-get install icc-profiles-free

echo 'Clone the resynthesizer repo, compile, and install...'
mkdir -p /tmp/gimplug/resynthesizer
cd /tmp/gimplug/resynthesizer
git clone https://github.com/bootchk/resynthesizer.git . || git pull
./autogen.sh
./configure
make
echo 'sudo make install resynthesizer...'
sudo make install


echo 'Download Heal selection fix script directly from gimp plugin registry...'
cd ~/.gimp-2.8/
wget -O scripts/smart-remove-fix.scm http://registry.gimp.org/files/smart-remove.scm
ls -l wget -O scripts/smart-remove-fix.scm http://registry.gimp.org/files/smart-remove.scm
echo 'Change the meta name of the fixed heal selection script to distinguish from orig...'
sed -i scripts/smart-remove-fix.scm 's?"<Image>/Filters/Enhance/Heal selection..."?"<Image>/Filters/Enhance/Heal selection (fix)..."?'

