### 1. Files preparation:
```
$ git clone https://github.com/u236/openwrt-patches.git
$ git clone https://github.com/openwrt/openwrt.git
$ cd openwrt
$ git checkout v22.03.3
$ cp -r ../openwrt-patches/homed-gateway-nano/v22.03.3/* .
```

### 2. Update OPKG feeds:
```
$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
```

### 3. Target and packages configuration:
```
$ make menuconfig
```

Select target profile:
```
Target System > Allwinner A1x/A20/A3x/H3/H5/R40
Subtarget > Allwinner A20/A3x/H3/R40
Target Profile > FriendlyARM NanoPi NEO
```

Configure target images:
```
Target Images > Boot (SD Card) filesystem partition size (in MB) > 8
Target Images > Root filesystem partition size (in MB) > 32
```

Configure built-in packakes:
```
<*> LuCI > Collections > luci
<*> Utilities > Terminal > picocom
<*> Utilities > mc
```

### 4. Kernel configuration:
```
$ make -j $(nproc) kernel_menuconfig
```

Enable DS2482 driver:
```
<*> Device Drivers > Dallas 1-wire support
<*> Device Drivers > Dallas 1-wire support > Userspace communication over connector
<*> Device Drivers > Dallas 1-wire support > 1-wire Bus Masters > Maxim DS2482 I2C to 1-Wire bridge
```

Enable DS1307 driver:
```
<*> Device Drivers > Real Time Clock
<*> Device Drivers > Real Time Clock > Dallas Maxim DS1307/37/38/39/40/41
```

Disable PC-Style CMOS:
```
< > Device Drivers > Real Time Clock > PC-Style 'CMOS'
```

### Build OpenWRT:
```
$ make -j $(nproc)
```