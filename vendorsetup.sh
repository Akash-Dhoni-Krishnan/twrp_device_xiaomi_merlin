# 
export TARGET_ARCH="arm64"
export FOX_BUILD_TYPE="Untested" # Modify in the future
export FOX_BUGGED_AOSP_ARB_WORKAROUND="1546300800" # Tue Jan 1 2019 00:00:00 GMT
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export TW_DEFAULT_LANGUAGE="en"
export OF_TARGET_DEVICES="merlin,merlinnfc"
export LC_ALL="C"
#
export FOX_USE_BASH_SHELL=1
export FOX_USE_NANO_EDITOR=1    
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_XZ_UTILS=1
#
export OF_RUN_POST_FORMAT_PROCESS=1
export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
export OF_SKIP_DECRYPTED_ADOPTED_STORAGE=1
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
export OF_USE_MAGISKBOOT=1
export OF_CLOCK_POS=0

# CCACHE
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache

# dm-verity/forced-encryption
export OF_KEEP_DM_VERITY=1
export OF_DONT_PATCH_ENCRYPTED_DEVICE=1

# - LEDs doesn't work - mtk_flashlight_brightness_set: invalid value 2047 or enabled 0
export OF_FLASHLIGHT_ENABLE=0 
export OF_USE_GREEN_LED=0

# Fix zip install issues on >R11 
export FOX_RECOVERY_BOOT_PARTITION="/dev/block/platform/bootdevice/by-name/boot"
export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/platform/bootdevice/by-name/recovery"
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
   	
# MIUI & Custom ROMs
export OF_PATCH_AVB20=1
export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1

# R11 Settings
export FOX_R11=1	
export OF_USE_TWRP_SAR_DETECT=1

# Screen
export OF_SCREEN_H=2340
export OF_STATUS_H=90
export OF_STATUS_INDENT_LEFT=50
export OF_STATUS_INDENT_RIGHT=50
#
