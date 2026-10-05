### 1. Files preparation:
```
$ git clone https://github.com/u236/openwrt-patches.git
$ git clone https://github.com/openwrt/openwrt.git
$ cd openwrt
$ git checkout v25.12.5
$ cp -rT ../openwrt-patches/homed-gateway-pico/v25.12.5 .
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
    Target Profile > HOMEd Gateway Pico
```

Configure built-in packages:
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