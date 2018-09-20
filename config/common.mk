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

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/sacred/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/sacred/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/sacred/prebuilt/common/bin/50-sacred.sh:system/addon.d/50-sacred.sh

# Bootanimation
$(call inherit-product, vendor/sacred/config/bootanimation.mk)

# Clean cache
PRODUCT_COPY_FILES += \
    vendor/sacred/prebuilt/common/bin/clean_cache.sh:system/bin/clean_cache.sh

DEVICE_PACKAGE_OVERLAYS += \
    vendor/sacred/overlay/common
#    vendor/sacred/overlay/dictionaries

# Custom SacredOS packages
PRODUCT_PACKAGES += \
    LatinIME \
    Launcher3 \
    LiveWallpapers \
    LiveWallpapersPicker \
    Stk

# Turbo
PRODUCT_PACKAGES += \
    Turbo \
    turbo.xml

# Textclassifiers
PRODUCT_PACKAGES += \
    textclassifier.langid.model \
    textclassifier.smartselection.bundle1 \
    textclassifier.smartselection.ar.model \
    textclassifier.smartselection.it.model \
    textclassifier.smartselection.nl.model \
    textclassifier.smartselection.pl.model \
    textclassifier.smartselection.pt.model \
    textclassifier.smartselection.ru.model \
    textclassifier.smartselection.tr.model \
    textclassifier.smartselection.zh.model \
    textclassifier.smartselection.zh-Hant.model

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

# Extra tools
#PRODUCT_PACKAGES += \
#    e2fsck \
#    mke2fs \
#    tune2fs \
#    mount.exfat \
#    fsck.exfat \
#    mkfs.exfat \
#    mkfs.f2fs \
#    fsck.f2fs \
#    fibmap.f2fs \
#    mkfs.ntfs \
#    fsck.ntfs \
#    mount.ntfs \
#    7z \
#    bzip2 \
#    curl \
#    lib7z \
#    powertop \
#    pigz \
#    tinymix \
#    unrar \
#    unzip \
#    zip

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/sacred/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/sacred/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner

# LatinIME gesture typing
ifeq ($(TARGET_ARCH),arm64)
PRODUCT_COPY_FILES += \
    vendor/sacred/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/sacred/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/sacred/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/sacred/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
endif

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

# Fix Dialer
#PRODUCT_COPY_FILES +=  \
#    vendor/sacred/prebuilt/common/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

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

# DU Utils Library
#PRODUCT_PACKAGES += \
#    org.dirtyunicorns.utils

#PRODUCT_BOOT_JARS += \
#    org.dirtyunicorns.utils

# Needed by some RILs and for some gApps packages
PRODUCT_PACKAGES += \
    librsjni \
    libprotobuf-cpp-full

# Charger images
PRODUCT_PACKAGES += \
    charger_res_images

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG ?= false

# Include SDCLANG definitions if it is requested and available
ifeq ($(HOST_OS),linux)
    ifneq ($(wildcard vendor/qcom/sdclang-4.0/),)
        include vendor/sacred/sdclang/sdclang.mk
    endif
endif
