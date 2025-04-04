DEVICE_VARS += UBOOT

include common.mk

define Device/Default
  PROFILES := Default
  FILESYSTEMS := squashfs ext4
  KERNEL_INSTALL := 1
  KERNEL_SUFFIX := -uImage
  KERNEL_NAME := zImage
  KERNEL := kernel-bin | uImage none
  KERNEL_LOADADDR := 0x80008000
  DTS_DIR := $(DTS_DIR)/nxp/imx
  IMAGES :=
endef

define Device/geniatech_gtw360
  DEVICE_VENDOR := Geniatech
  DEVICE_MODEL := GTW360
  DEVICE_DTS := imx6ull-gtw360
  IMAGES := dtb
  IMAGE/dtb := install-dtb
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
  KERNEL := kernel-bin
  KERNEL_SUFFIX := -zImage
  DEVICE_PACKAGES := kmod-brcmfmac kmod-gpio-button-hotplug kmod-leds-gpio kmod-pps-gpio
endef
TARGET_DEVICES += geniatech_gtw360

define Device/technexion_imx7d-pico-pi
  DEVICE_VENDOR := TechNexion
  DEVICE_MODEL := PICO-PI-IMX7D
  UBOOT := pico-pi-imx7d
  DEVICE_DTS := imx7d-pico-pi
  DEVICE_PACKAGES := kmod-sound-core kmod-sound-soc-imx kmod-sound-soc-imx-sgtl5000 \
	kmod-can kmod-can-flexcan kmod-can-raw kmod-leds-gpio \
	kmod-input-touchscreen-edt-ft5x06 kmod-usb-hid kmod-btsdio \
	kmod-brcmfmac brcmfmac-firmware-4339-sdio cypress-nvram-4339-sdio
  FILESYSTEMS := squashfs
  IMAGES := combined.bin sysupgrade.bin
  IMAGE/combined.bin := append-rootfs | pad-extra 128k | imx-sdcard-raw-uboot
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
endef
TARGET_DEVICES += technexion_imx7d-pico-pi
