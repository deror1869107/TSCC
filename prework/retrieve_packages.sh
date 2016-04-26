#!/bin/sh -v

#clean cache
rm -f /var/cache/pacman/pkg/*
rm -f packages/*
rm -f pacman/*

#retrieve packages
pacman -Syy
for package in $( pacman -Q | cut -f 1 -d' ' | tr "\n" ' ' ) ; do
    pacman -Sw --noconfirm $package
done

#copy packages
cp /var/cache/pacman/pkg/* pacman/
cp ~/*.pkg.tar.xz pacman/

cp ~/parallel*.tgz packages/ || echo "Please download icc into root's home"
