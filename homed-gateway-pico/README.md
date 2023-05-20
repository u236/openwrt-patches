### 1. Files preparation:
```
$ git clone https://github.com/u236/openwrt-patches.git
$ git clone https://github.com/openwrt/openwrt.git
$ cd openwrt
$ git checkout v22.03.5
$ cp -rT ../openwrt-patches/homed-gateway-pico/v22.03.5 .
```

### 2. Update OPKG feeds:
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
    Target Profile > HOMEd Gateway Pico
```

Configure built-in kernel module:
```
<*> Kernel Modules > Other modules > kmod-sdhci-mt7620
```

Configure built-in packakes (optional):
```
<*> LuCI > Collections > luci
<*> Utilities > Terminal > picocom
<*> Utilities > mc
    ...
    Something else
```

### 4. Build OpenWRT image:
```
$ make -j $(nproc)
```