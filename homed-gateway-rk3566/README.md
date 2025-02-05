### 1. Files preparation:
```
$ git clone https://github.com/u236/openwrt-patches.git
$ git clone https://github.com/openwrt/openwrt.git
$ cd openwrt
$ git checkout v24.10.0
$ cp -rT ../openwrt-patches/homed-gateway-rk3566/v24.10.0 .
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
    Target Profile > HOMEd Gateway Black/Pro
```

Configure built-in kernel modules (Gateway Black):
```
<*> Kernel Modules > Wireless Drivers > kmod-brcmfmac
```

Configure built-in kernel modules (Gateway Pro):
```
<*> Kernel Modules > W1 support > kmod-w1
<*> Kernel Modules > W1 support > kmod-w1-master-ds2482
<*> Kernel Modules > W1 support > kmod-w1-slave-therm
<*> Kernel Modules > Wireless Drivers > kmod-brcmfmac
```

Configure built-in packakes:
```
<*> LuCI > Collections > luci
<*> Network > WirelessAPD > wpad
<*> Utilities > Disc > parted
<*> Utilities > Filesystem > resize2fs
<*> Utilities > Filesystem > tune2fs
<*> Utilities > Terminal > picocom
<*> Utilities > mc
    ...
    Something else
```

### 4. Build OpenWRT image:
```
$ make -j $(nproc)
```
