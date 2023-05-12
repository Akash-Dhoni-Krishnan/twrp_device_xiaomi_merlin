# Copyright (C) 2007 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE), merlinx)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
ifeq ($(TW_INCLUDE_CRYPTO), true)
    # include $(commands_TWRP_local_path)/crypto/fde/Android.mk
    include $(commands_TWRP_local_path)/crypto/scrypt/Android.mk
    ifneq ($(TW_CRYPTO_USE_SYSTEM_VOLD),)
    ifneq ($(TW_CRYPTO_USE_SYSTEM_VOLD),false)
        include $(commands_TWRP_local_path)/crypto/vold_decrypt/Android.mk
    endif
    endif
    include $(commands_TWRP_local_path)/gpt/Android.mk
endif
ifeq ($(TW_INCLUDE_NTFS_3G),true)
    TWRP_REQUIRED_MODULES += \
        mount.ntfs \
        fsck.ntfs \
        mkfs.ntfs
endif
ifeq ($(TARGET_USERIMAGES_USE_F2FS), true)
    TWRP_REQUIRED_MODULES += sload_f2fs \
        libfs_mgr \
        fs_mgr \
        liblz4 \
        libinit
endif
ifeq ($(BOARD_HAS_NO_REAL_SDCARD),)
    TWRP_REQUIRED_MODULES += sgdisk
endif
ifneq ($(TW_INCLUDE_CRYPTO),)
TWRP_REQUIRED_MODULES += \
    vold_prepare_subdirs \
    task_recovery_profiles.json \
    fscryptpolicyget.recovery \
    keystore_auth \
    keystore2 \
    android.system.keystore2-service.xml \
    keystore2.rc \
    plat_keystore2_key_contexts

    ifneq ($(TW_INCLUDE_CRYPTO_FBE),)
    TWRP_REQUIRED_MODULES += \
        plat_service_contexts \
        servicemanager \
        servicemanager.rc
    endif
endif
ifeq ($(TW_INCLUDE_CRYPTO), true)
    LOCAL_CFLAGS += -DTW_INCLUDE_CRYPTO -DUSE_FSCRYPT -Wno-macro-redefined
    LOCAL_SHARED_LIBRARIES += libgpt_twrp
    LOCAL_C_INCLUDES += external/boringssl/src/include bootable/recovery/crypto
    TW_INCLUDE_CRYPTO_FBE := true
    LOCAL_CFLAGS += -DTW_INCLUDE_FBE
    LOCAL_SHARED_LIBRARIES += android.frameworks.stats@1.0 android.hardware.authsecret@1.0 \
	android.security.authorization-ndk_platform \
        android.hardware.oemlock@1.0 libf2fs_sparseblock libbinder libbinder_ndk \
        libandroidicu.recovery \
        android.hardware.gatekeeper@1.0 \
        android.hardware.weaver@1.0 \
        android.frameworks.stats@1.0 \
        android.security.maintenance-ndk_platform \
        android.system.keystore2-V1-ndk_platform \
        libkeyutils \
        liblog \
        libsqlite.recovery \
        libkeystoreinfo.recovery \
        libgatekeeper_aidl

    LOCAL_STATIC_LIBRARIES += libkeymint_support

    LOCAL_CFLAGS += -DTW_INCLUDE_FBE_METADATA_DECRYPT
    ifneq ($(TW_CRYPTO_USE_SYSTEM_VOLD),)
    ifneq ($(TW_CRYPTO_USE_SYSTEM_VOLD),false)
		TW_INCLUDE_LIBRESETPROP := true
        LOCAL_CFLAGS += -DTW_CRYPTO_USE_SYSTEM_VOLD
        LOCAL_STATIC_LIBRARIES += libvolddecrypt
    endif
    endif

    ifeq ($(TARGET_HW_DISK_ENCRYPTION),true)
        ifeq ($(TARGET_CRYPTFS_HW_PATH),)
            LOCAL_C_INCLUDES += device/qcom/common/cryptfs_hw
        else
            LOCAL_C_INCLUDES += $(TARGET_CRYPTFS_HW_PATH)
        endif
        LOCAL_SHARED_LIBRARIES += libcryptfs_hw
    endif
endif
WITH_CRYPTO_UTILS := \
    $(if $(wildcard system/core/libcrypto_utils/android_pubkey.c),true)
ifneq ($(RECOVERY_SDCARD_ON_DATA),)
	LOCAL_CFLAGS += -DRECOVERY_SDCARD_ON_DATA
endif
endif
