# Copyright (C) 2017 SacredOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

 include vendor/sacred/config/version.mk
 include vendor/sacred/config/art.mk

PRODUCT_BRAND ?= SACRED

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.mode=OPTIONAL \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.setupwizard.rotation_locked=true \
    ro.opa.eligible_device=true\
    persist.sys.dun.override=0 \
    ro.storage_manager.enabled=true \
    persist.sys.recovery_update=false \
    persist.sys.disable_rescue=true

# Sensitive Phone Numbers list
PRODUCT_COPY_FILES += \
    vendor/sacred/prebuilt/common/etc/sensitive_pn.xml:system/etc/sensitive_pn.xml

# World APN list
PRODUCT_COPY_FILES += \
    vendor/sacred/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    Stk \
    CellBroadcastReceiver

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/sacred/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/sacred/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/sacred/prebuilt/common/bin/50-sacred.sh:system/addon.d/50-sacred.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/sacred/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/sacred/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/sacred/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Bootanimation
$(call inherit-product, vendor/sacred/config/bootanimation.mk)

DEVICE_PACKAGE_OVERLAYS += \
    vendor/sacred/overlay/common

# Additional packages
PRODUCT_PACKAGES += \
    LiveWallpapersPicker

# TCP Connection Management
PRODUCT_PACKAGES += tcmiface
PRODUCT_BOOT_JARS += tcmiface

# Bluetooth Audio (A2DP)
PRODUCT_PACKAGES += libbthost_if

# Accents
PRODUCT_PACKAGES += \
    Amber \
    Blue \
    BlueGrey \
    Brown \
    Cyan \
    DeepOrange \
    DeepPurple \
    Green \
    Grey \
    Indigo \
    LightBlue \
    LightGreen \
    Lime \
    Orange \
    Pink \
    Purple \
    Red \
    Teal \
    Yellow

# Themes
PRODUCT_PACKAGES += \
    SystemDarkTheme \
    SettingsDarkTheme \
    SystemUIDarkTheme \
    SystemBlackTheme \
    SettingsBlackTheme \
    SystemUIBlackTheme

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/sacred/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Copy all sacred-specific init rc files
$(foreach f,$(wildcard vendor/sacred/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/sacred/prebuilt/common/media/LMspeed_508.emd:system/media/LMspeed_508.emd \
    vendor/sacred/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/sacred/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl
    
# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Charging sounds
#PRODUCT_COPY_FILES += \
#    vendor/sacred/google/effects/BatteryPlugged.ogg:system/media/audio/ui/BatteryPlugged.ogg \
#    vendor/sacred/google/effects/BatteryPlugged_48k.ogg:system/media/audio/ui/BatteryPlugged_48k.ogg

# Charger images
PRODUCT_PACKAGES += \
    charger_res_images

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG ?= false

# Include SDCLANG definitions
 include vendor/sacred/build/sdclang/sdclang.mk
