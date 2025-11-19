---
title: "TrackPoint is Dead after Resuming?"
date: 2025-11-18T23:39:09+00:00
categories: [GEEK]
tags: [ThinkPad,51nb,X210,TrackPoint,Arch Linux,Hyprland,libinput]
---

If you are using ThinkPad 51nb's X210 with Arch Linux and Hyprland, you might have the problem that the TrackPoint is not working after resuming from sleeping.

<!-- more -->

## Why the TrackPoint doesn't work after resuming

It's the firmware problem. The TrackPoint won't properly *wake up* from sleep mode.

## Workaround

Temporally, you can use two lines of commands to restart the TrackPoint:

```bash
sudo modprobe -r psmouse
sudo modprobe psmouse resetafter=0
```

If you don't want to type those commands before closing the lid and after opening the lid, you can write a system daemon script:

```bash
sudo nano /usr/lib/systemd/system-sleep/psmouse-reset
```

Edit it:

```bash
#!/bin/sh
case $1 in
  pre)
    # Before sleep: unload psmouse to avoid corruption
    modprobe -r psmouse
    ;;
  post)
    # After resume: reload with correct options
    modprobe psmouse resetafter=0
    ;;
esac
```

Save it and make it runnable:

```bash
sudo chmod +x /usr/lib/systemd/system-sleep/psmouse-reset
```

Reboot! Everytime you resume from sleep mode, the TrackPoint will restart, it takes a few seconds but it works!
