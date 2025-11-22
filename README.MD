# ddcci-probe

This script detects monitor connection status and attach/detach ddcci accordingly.

works with https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux.

## Background

You may seen this: `ddcci: WARNING: Auto-probing of displays is not available on kernel 6.8 and later` in your dmesg.

Ever since linux kernel 6.8, ddcci can't probe monitors automatically, so this script should make your life a little bit easier.

## Usage

get kernel 6.8+ and ddcci-driver-linux installed, place `ddcci-probe.sh` somewhere (e.g. `/usr/bin/ddcci_probe.sh`, note that `/usr/local/bin` is more recommend if you are doing this manually), make it executable. Call `i2c-dev` and `ddcci_backlight` to work before use this script.

run `ddcci-probe.sh` as root, it will detect the connection status of monitors. connected -> attach to ddcci, disconnected -> detach from ddcci.

You may want to use it with a udev rule to make it automatic, for example, check out the `99-ddcci-hotplug.rules` file in this repository, place it in `/etc/udev/rules.d/`, and it *should* works automatically when you plug/unplug monitors. **Note: i didnt test it extensively, so proceeding with caution.**

## AUR Package

```
    paru -S ddcci-probe-git
    # reload the udev rules if needed 
    sudo udevadm control --reload
    # run the script because the udev rule wont trigger until next drm change event
    sudo ddcci-probe.sh
```


