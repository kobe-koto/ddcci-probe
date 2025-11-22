#!/bin/bash
for card in /sys/class/drm/*; do
    ddc_path="$card/ddc"
    if [ -e "$ddc_path" ]; then
        i2c_dev=$(basename $(readlink -f "$ddc_path"))
        i2c_sys_path="/sys/bus/i2c/devices/$i2c_dev"

        # check monitor connection status
        status_file="$card/status"
        if [ -f "$status_file" ] && grep -q "^connected" "$status_file"; then
            # monitor is connected
            if [ ! -d "$i2c_sys_path/0-0037" ] && [ ! -d "$i2c_sys_path/${i2c_dev#i2c-}-0037" ]; then
                echo "Monitor connected on $i2c_dev. Attaching ddcci..."
                # echo ddcci 0x37 > "$i2c_sys_path/new_device" 2>/dev/null
            fi
        else
            # monitor is disconnected
            # check if ddcci device exists
            if [ -d "$i2c_sys_path/0-0037" ] || [ -d "$i2c_sys_path/${i2c_dev#i2c-}-0037" ]; then
                echo "Monitor disconnected on $i2c_dev. Detaching ddcci..."
                # echo 0x37 > "$i2c_sys_path/delete_device" 2>/dev/null
            fi
        fi
    fi
done
