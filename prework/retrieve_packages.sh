#!/bin/sh -ev

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
cp ~/*.tar.xz packages/
