### 1. Files preparation:
```
$ git clone https://github.com/openwrt/openwrt.git
$ cd openwrt
$ git checkout v25.12.5
$ cp -rT <this-repo>/homed-gateway-pico/v25.12.5 .
```
(The overlay already contains `.config`; then:)
```
$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
$ make defconfig
$ make menuconfig
```

Select target profile:
```
    Target Profile > HOMEd Gateway Pico
```

Verify the profile stuck (must say `homed_gateway-pico`, not the first profile in the list):
```
$ grep ^CONFIG_TARGET_ramips_mt76x8_DEVICE_homed .config
CONFIG_TARGET_ramips_mt76x8_DEVICE_homed_gateway-pico=y
```

Configure built-in kernel module (note: `kmod-sdhci-mt7620` from 22.03 was renamed to `kmod-mmc-mtk`):
```
<*> Kernel Modules > Other modules > kmod-mmc-mtk
```

Configure built-in packages (already in `.config`, for reference):
```
<*> LuCI > Collections > luci
<*> LuCI > Protocols > luci-ssl
<*> Network > WirelessAPD > wpad-basic-wolfssl
<*> Network > mosquitto-nossl
<*> Utilities > Terminal > picocom
<*> Utilities > mc
<*> Utilities > curl
```

### 4. Build OpenWRT image:
```
$ make -j $(nproc)
```

Result: `bin/targets/ramips/mt76x8/openwrt-ramips-mt76x8-homed_gateway-pico-squashfs-sysupgrade.bin`

### 5. Flash:
```
$ sysupgrade -n /tmp/<image>.bin
```
Use `-n` (do not keep settings): the 22.03 config is incompatible (`swconfig` -> DSA, `opkg` -> `apk`).
After reboot the device is at `192.168.200.12/24` (see `99-pico-static-lan`), hostname/SSID `HOMEd-GW-Pico`.

### 6. HOMEd services (not baked into the 32 MB image, installed from APK repo):
```
# wget -O /etc/apk/keys/homed.pem https://apk.homed.dev/apk.key
# echo "https://apk.homed.dev/$(cat /etc/apk/arch)/packages.adb" > /etc/apk/repositories.d/homed.list
# apk update && apk add mosquitto-nossl homed-zigbee homed-modbus homed-custom \
    homed-automation homed-recorder homed-web homed-cloud
```
(The key/repo are also added automatically on first boot by `98-homed-apk-repo`.)
Seed configs for ZigBee (`/dev/ttyS2`, `znp`, `soft` reset) and Modbus (`/dev/ttyS1`) are in `files/etc/homed/`.
Set `write=true` -> `false` in `homed-zigbee.conf` after the first coordinator start.
Docs: https://wiki.homed.dev/ (see `common/apk` and the official Pico example in `zigbee/configuration`).

### Notes for porters (22.03.5 -> 25.12.x):
- kernel 6.12; DTS uses `nvmem-layout`/`fixed-layout` instead of `mediatek,mtd-eeprom`, no `&esw portmap`
- `swconfig` is gone on mt76x8 (DSA via `ucidef_add_switch`); single-port Pico uses `switch0` disabled + `lan` on `eth0`
- `opkg`/`customfeeds.conf` replaced by `apk` (`apk.homed.dev`, arch `mipsel_24kc`)
