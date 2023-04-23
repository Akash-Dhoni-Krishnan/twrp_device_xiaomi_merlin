#
# Copyright (C) 2020 The Android Open Source Project
# Copyright (C) 2020 The TWRP Open Source Project
# Copyright (C) 2020 SebaUbuntu's TWRP device tree generator
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Building with minimal manifest 
ALLOW_MISSING_DEPENDENCIES := true

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Assertation
TARGET_OTA_ASSERT_DEVICE := merlin,merlin_eea,merlinnfc,merlinx

TARGET_SCREEN_HEIGHT := 2340
TARGET_SCREEN_WIDTH := 1080

LOCAL_PATH := device/xiaomi/merlinx

# Crypto 
TW_INCLUDE_CRYPTO := true 
TW_INCLUDE_CRYPTO_FBE := true 
TW_INCLUDE_FBE_METADATA_DECRYPT := true 
TW_USE_FSCRYPT_POLICY := 1

# TWRP Configuration
TARGET_USES_MKE2FS := true
TW_NO_LEGACY_PROPS := true
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_SKIP_COMPATIBILITY_CHECK := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_FASTBOOTD := true
TW_H_OFFSET := -80
TW_Y_OFFSET := 95
TW_DEVICE_VERSION := build by ADK-KuttyPulla and Chinedu(Tree Help)
TW_DEFAULT_APP_CERTIFICATE := platform
