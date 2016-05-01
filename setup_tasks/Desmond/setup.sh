#!/bin/bash

echo "##### Begin setup of Desmond #####"
tar xvf ../../prework/packages/Desmond_Maestro_2016.1.tar -C ~
echo "##### Installation folder: /opt/schrodinger2016-1 #####"
echo "##### Scratch foler: /tmp #####"
~/Desmond_Maestro_2016.1/INSTALL
echo "export SCHRODINGER=/opt/schrodinger2016-1" >> ~/.bash_profile
echo "##### Please call source ~/.bash_profile #####"
cp ~/Desmond_Maestro_2016.1/license.lic /opt/schrodinger/licenses

