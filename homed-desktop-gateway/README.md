### 1. Files preparation:
```
$ git clone https://github.com/u236/openwrt-patches.git
$ git clone https://github.com/openwrt/openwrt.git
$ cd openwrt
$ git checkout v22.03.5
$ cp -rT ../openwrt-patches/homed-desktop-gateway/v22.03.5 .
```

### 2. Update feeds:
```
$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
```

### 3. OpenWRT image configuration:
```
$ make menuconfig
```

Select target profile:
```
    Target Profile > FriendlyARM NanoPi NEO
```

Configure built-in kernel modules:
```
<*> Kernel Modules > Other modules > kmod-rtc-ds1307
<*> Kernel Modules > Wireless Drivers > kmod-mt7601u
```

Configure built-in packakes (optional):
```
<*> LuCI > Collections > luci
<*> Network > WirelessAPD > wpad
<*> Utilities > mc
    ...
    Something else
```

### 4. Build OpenWRT image:
```
$ make -j $(nproc)
```
