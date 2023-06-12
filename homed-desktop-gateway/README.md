### 1. Files preparation:
```
$ git clone https://github.com/u236/openwrt-patches.git
$ git clone https://github.com/openwrt/openwrt.git
$ cd openwrt
$ git checkout v22.03.5
$ cp -rT ../openwrt-patches/homed-gateway-nano/v22.03.3 .
```

### 2. Update OPKG feeds:
```
$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
```

### 3. Build toolchain and kernel:
```
$ make defconfig
$ make -j $(nproc) toolchain/install
$ make -j $(nproc) target/linux/compile
```

### 4. OpenWRT image configuration:
```
$ make menuconfig
```

Select target profile:
```
    Target Profile > FriendlyARM NanoPi NEO
```

Configure target images:
```
    Target Images > Boot (SD Card) filesystem partition size (in MB) > 8
    Target Images > Root filesystem partition size (in MB) > 32
```

Configure built-in kernel modules:
```
/* add wifi driver here */
<*> Kernel Modules > Other modules > kmod-rtc-ds1307
```

Configure built-in packakes (optional):
```
/* add wifi tools here */
<*> LuCI > Collections > luci
<*> Utilities > Terminal > picocom
<*> Utilities > mc
    ...
    Something else
```

### 5. Build OpenWRT image:
```
$ make -j $(nproc)
```
