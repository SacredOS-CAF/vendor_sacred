# Target-specific configuration

# Bring in Qualcomm helper macros
include vendor/sacred/build/core/qcom_utils.mk

define wlan-set-path-variant
$(call project-set-path-variant,wlan,TARGET_WLAN_VARIANT,hardware/qcom/$(1))
endef
define bt-vendor-set-path-variant
$(call project-set-path-variant,bt-vendor,TARGET_BT_VENDOR_VARIANT,hardware/qcom/$(1))
endef

# Set device-specific HALs into project pathmap
define set-device-specific-path
$(if $(USE_DEVICE_SPECIFIC_$(1)), \
    $(if $(DEVICE_SPECIFIC_$(1)_PATH), \
        $(eval path := $(DEVICE_SPECIFIC_$(1)_PATH)), \
        $(eval path := $(TARGET_DEVICE_DIR)/$(2))), \
    $(eval path := $(3))) \
$(call project-set-path,qcom-$(2),$(strip $(path)))
endef

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    $(call set-device-specific-path,AUDIO,audio,hardware/qcom/audio/$(QCOM_HARDWARE_VARIANT))
    $(call set-device-specific-path,DISPLAY,display,hardware/qcom/display/$(QCOM_HARDWARE_VARIANT))
    $(call set-device-specific-path,MEDIA,media,hardware/qcom/media/$(QCOM_HARDWARE_VARIANT))

    $(call set-device-specific-path,GPS,gps,hardware/qcom/gps)
    $(call set-device-specific-path,LOC_API,loc-api,vendor/qcom/opensource/location)
    $(call set-device-specific-path,DATASERVICES,dataservices,vendor/qcom/opensource/dataservices)
    $(call set-device-specific-path,POWER,power,hardware/qcom/power)
    $(call set-device-specific-path,THERMAL,thermal,hardware/qcom/thermal)

    $(call wlan-set-path-variant,wlan)
    $(call bt-vendor-set-path-variant,bt)

endif # BOARD_USES_QCOM_HARDWARE

