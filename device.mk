#
# Copyright (C) 2021-2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

## Bluetooth
PRODUCT_PACKAGES += \
    H96maxx3BluetoothOverlay \
    libbt-vendor

$(call soong_config_set,brcm_libbt,bdroid_buildcfg_include_dir,$(LOCAL_PATH)/bluetooth/include)
$(call soong_config_set,brcm_libbt,custom_bt_config,//$(LOCAL_PATH):vnd_h96maxx3.txt)

# Patch files of the stock firmware (vendor/etc/bluetooth), one per Ampak
# module; libbt-vendor picks the one named after the controller.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/bluetooth/bt_vendor_h96maxx3.conf:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth/bt_vendor_h96maxx3.conf \
    $(call find-copy-subdir-files,*.hcd,$(LOCAL_PATH)/proprietary/vendor/firmware/brcm,$(TARGET_COPY_OUT_VENDOR)/firmware/brcm)

## Factory
PRODUCT_HOST_PACKAGES += \
    aml_image_packer

## Graphics (Mali)
PRODUCT_PACKAGES += \
    libGLES_mali \
    vendor_lib_hw_vulkan_amlogic_so

## Init-Files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init-files/init.amlogic.wifi_buildin.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.amlogic.wifi_buildin.rc

## Wi-Fi
# Ampak firmware set of the stock H96 Max X3 firmware (wifi/buildin). The box
# ships with different modules; dhd picks fw_<chip>, nvram_<module> and
# config_<chip> from /vendor/lib/firmware/wifi by the chip it finds.
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/vendor/firmware/wifi,$(TARGET_COPY_OUT_VENDOR)/lib/firmware/wifi)

## Keylayout (IR)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/Vendor_0001_Product_0001.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Vendor_0001_Product_0001.kl


## TEE
TARGET_HAS_TEE := false

## Soong Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/broadcom/libbt

## Inherit from the common tree product makefile
$(call inherit-product, device/amlogic/g12-common/g12.mk)
