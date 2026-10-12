### 1. Files preparation:
```
$ git clone https://github.com/u236/openwrt-patches.git
$ git clone https://github.com/openwrt/openwrt.git
$ cd openwrt
$ git checkout v25.12.5
$ cp -rT ../openwrt-patches/wirenboard-8/v25.12.5 .
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
    Target Profile > Wiren Board 8.5
```

Configure built-in kernel modules:
```
<*> Kernel Modules > USB Support > kmod-usb-net-rndis
<*> Kernel Modules > USB Support > kmod-usb-serial-option
<*> Kernel Modules > W1 support > kmod-w1
<*> Kernel Modules > W1 support > kmod-w1-master-gpio
<*> Kernel Modules > W1 support > kmod-w1-slave-therm
<*> Kernel Modules > Wireless Drivers > kmod-rtl8733bu
```

Configure built-in packages:
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
