---
title: "TrackPoint is Dead after Resuming?"
date: 2025-11-18T23:39:09+00:00
categories: [GEEK]
tags: [ThinkPad,51nb,X210,TrackPoint,Arch Linux,Hyprland,libinput]
---

If you are using ThinkPad 51nb's X210 with Arch Linux and Hyprland, you might have the problem that the TrackPoint is not working after resuming from sleeping.

<!-- more -->

## Why the TrackPoint doesn't work after resuming

After some research, default power settings will turn off the TrackPoint, and that will cause its odd behaviour.

## Disable power save mode

To disable power save for the TrackPoint, you can use libinput and its settings:

```bash
sudo pacman -S libinput # Install libinput
sudo libinput list-devices # Find the device name of the TrackPoint
sudo vim /etc/X11/xorg.conf.d/40-libinput.conf # Use VIM to edit the configuration
```

```conf
Section "InputClass"
    Identifier "Trackpad"
    MatchProduct "SynPS/2 Synaptics TouchPad"
    MatchDevicePath "/dev/input/event12"  # Ensure correct device path
    Option "Tapping" "on"
    Option "DisableWhileTyping" "off"
    Option "AccelSpeed" "0.0"
    Option "NaturalScrolling" "true"
    Option "IdleTimeout" "0"  # Disable power-saving idle timeout
    Option "Tap-to-click" "on"  # Enable tap-to-click if needed
EndSection

Section "InputClass"
    Identifier "TrackPoint"
    MatchProduct "TPPS/2 IBM TrackPoint"
    MatchDevicePath "/dev/input/event13"  # Ensure correct device path
    Option "Disable" "off"  # Ensure TrackPoint is enabled
    Option "AccelSpeed" "0.0"  # Disable any acceleration if desired
    Option "Tapping" "off"  # Disable tapping if you prefer
    Option "IdleTimeout" "0"  # Disable idle timeout to prevent power save mode
EndSection
```

The most important option is `"IdleTimeout"`. Setting it to `0` will prevent power save mode.
