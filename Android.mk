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
LOCAL_SRC_FILES := \
    twrp.cpp \
    fixContexts.cpp \
    twrpTar.cpp \
    exclude.cpp \
    find_file.cpp \
    infomanager.cpp \
    data.cpp \
    partition.cpp \
    partitionmanager.cpp \
    progresstracking.cpp \
    twinstall.cpp \
    twrp-functions.cpp \
    twrpDigestDriver.cpp \
    openrecoveryscript.cpp \
    tarWrite.c \
    twrpAdbBuFifo.cpp

ifeq ($(TW_INCLUDE_JB_CRYPTO), true)
    TW_INCLUDE_CRYPTO := true
endif
ifeq ($(TW_INCLUDE_L_CRYPTO), true)
    TW_INCLUDE_CRYPTO := true
endif
ifeq ($(TW_INCLUDE_CRYPTO), true)
    LOCAL_CFLAGS += -DTW_INCLUDE_CRYPTO -DUSE_FSCRYPT -Wno-macro-redefined
    LOCAL_SHARED_LIBRARIES += libcryptfsfde
    LOCAL_SHARED_LIBRARIES += libgpt_twrp libstatssocket.recovery
    LOCAL_C_INCLUDES += external/boringssl/src/include bootable/recovery/crypto
    LOCAL_C_INCLUDES += $(commands_TWRP_local_path)/crypto/fscrypt
    TW_INCLUDE_CRYPTO_FBE := true
    LOCAL_CFLAGS += -DTW_INCLUDE_FBE
    LOCAL_SHARED_LIBRARIES += libtwrpfscrypt android.frameworks.stats@1.0 android.hardware.authsecret@1.0 \
        android.hardware.oemlock@1.0
    LOCAL_CFLAGS += -DTW_INCLUDE_FBE_METADATA_DECRYPT
    ifneq ($(TW_CRYPTO_USE_SYSTEM_VOLD),)
    ifneq ($(TW_CRYPTO_USE_SYSTEM_VOLD),false)
		TW_INCLUDE_LIBRESETPROP := true
        LOCAL_CFLAGS += -DTW_CRYPTO_USE_SYSTEM_VOLD
        LOCAL_STATIC_LIBRARIES += libvolddecrypt
    endif
    endif
endif
ifneq ($(TW_INCLUDE_CRYPTO),)
TWRP_REQUIRED_MODULES += \
    vold_prepare_subdirs \
    task_recovery_profiles.json \
    fscryptpolicyget
    ifneq ($(TW_INCLUDE_CRYPTO_FBE),)
    TWRP_REQUIRED_MODULES += \
        plat_service_contexts \
        servicemanager \
        servicemanager.rc
    endif
endif
ifneq ($(TW_OZIP_DECRYPT_KEY),)
    TWRP_REQUIRED_MODULES += ozip_decrypt
    include $(commands_TWRP_local_path)/ozip_decrypt/Android.mk
endif
ifeq ($(TW_INCLUDE_CRYPTO), true)
    include $(commands_TWRP_local_path)/crypto/fde/Android.mk
    include $(commands_TWRP_local_path)/crypto/scrypt/Android.mk
    ifeq ($(TW_INCLUDE_CRYPTO_FBE), true)
        include $(commands_TWRP_local_path)/crypto/fscrypt/Android.mk
    endif
    ifneq ($(TW_CRYPTO_USE_SYSTEM_VOLD),)
    ifneq ($(TW_CRYPTO_USE_SYSTEM_VOLD),false)
        include $(commands_TWRP_local_path)/crypto/vold_decrypt/Android.mk
    endif
    endif
    include $(commands_TWRP_local_path)/gpt/Android.mk
endif
