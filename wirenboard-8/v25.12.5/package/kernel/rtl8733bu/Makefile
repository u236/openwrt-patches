include $(TOPDIR)/rules.mk

PKG_NAME:=rtl8733bu
PKG_RELEASE:=1

PKG_LICENSE:=GPL-2.0-only
PKG_LICENSE_FILES:=

PKG_SOURCE_URL:=https://github.com/wirenboard/rtl8733bu.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2025-07-24
PKG_SOURCE_VERSION:=032a367f44cc53a1f059e6479e394714acc6a927
PKG_MIRROR_HASH:=skip

PKG_BUILD_PARALLEL:=1

STAMP_CONFIGURED_DEPENDS := $(STAGING_DIR)/usr/include/mac80211-backport/backport/autoconf.h

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/rtl8733bu
  SUBMENU:=Wireless Drivers
  TITLE:=Realtek RTL8733BU USB Wi-Fi driver (Wiren Board fork)
  DEPENDS:=+kmod-cfg80211 +kmod-usb-core
  FILES:=$(PKG_BUILD_DIR)/8733bu.ko
  AUTOLOAD:=$(call AutoProbe,8733bu)
endef

NOSTDINC_FLAGS := \
	$(KERNEL_NOSTDINC_FLAGS) \
	-I$(PKG_BUILD_DIR) \
	-I$(PKG_BUILD_DIR)/include \
	-I$(STAGING_DIR)/usr/include/mac80211-backport \
	-I$(STAGING_DIR)/usr/include/mac80211-backport/uapi \
	-I$(STAGING_DIR)/usr/include/mac80211 \
	-I$(STAGING_DIR)/usr/include/mac80211/uapi \
	-include backport/backport.h \
	-DBUILD_OPENWRT

define Build/Compile
	+$(KERNEL_MAKE) $(PKG_JOBS) \
		M="$(PKG_BUILD_DIR)" \
		NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" \
		KCFLAGS="-Wno-error" \
		CONFIG_RTL8733BU=m \
		CONFIG_RTW_NAPI=n \
		CONFIG_RTW_GRO=n \
		CONFIG_RTW_LOG_LEVEL=2 \
		modules
endef

$(eval $(call KernelPackage,rtl8733bu))
