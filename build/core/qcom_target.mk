# Target-specific configuration

# Bring in Qualcomm helper macros
include vendor/sacred/build/core/qcom_utils.mk

# Set device-specific HALs into project pathmap
define set-device-specific-path
$(if $(USE_DEVICE_SPECIFIC_$(1)), \
    $(if $(DEVICE_SPECIFIC_$(1)_PATH), \
        $(eval path := $(DEVICE_SPECIFIC_$(1)_PATH)), \
        $(eval path := $(TARGET_DEVICE_DIR)/$(2))), \
    $(eval path := $(3))) \
$(call project-set-path,qcom-$(2),$(strip $(path)))
endef

$(call set-device-specific-path,AUDIO,audio,hardware/qcom/audio/$(QCOM_HARDWARE_VARIANT))
$(call set-device-specific-path,DISPLAY,display,hardware/qcom/display/$(QCOM_HARDWARE_VARIANT))
$(call set-device-specific-path,MEDIA,media,hardware/qcom/media/$(QCOM_HARDWARE_VARIANT))
