### 1. Files preparation:
```
$ git clone https://github.com/u236/openwrt-patches.git
$ git clone https://github.com/openwrt/openwrt.git
$ cd openwrt
$ git checkout v22.03.5
$ cp -rT ../openwrt-patches/perenio-peacg01/v22.03.5 .
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
    Target Profile > Perenio PEACG01
```

Configure built-in kernel modules:
```
<*> Kernel Modules > USB support > kmod-usb-serial-pl2303
<*> Kernel Modules > USB support > kmod-usb2
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
