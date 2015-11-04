LOCAL_PATH := $(call my-dir)

PRIVATE_LOCAL_CFLAGS := -O2 -g -W -Wall	\
			-DSO_RXQ_OVFL=40	\
			-DPF_CAN=29		\
			-DAF_CAN=PF_CAN 

#
# can_log_raw
#

include $(CLEAR_VARS)

LOCAL_SRC_FILES := can_log_raw.c
LOCAL_MODULE := can_log_raw
LOCAL_MODULE_TAGS := optional
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)

include $(BUILD_EXECUTABLE)

# build cmd
# ndk-build V=1 NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk NDK_APPLICATION_MK=./Application.mk
