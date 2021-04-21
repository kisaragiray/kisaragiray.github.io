THEOS_DEVICE_IP = 127.0.0.1
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard
FINALPACKAGE=1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = respaddpref
$(TWEAK_NAME)_FILES = $(wildcard *.xm) respaddpref.xmi
ADDITIONAL_CFLAGS += -DTHEOS_LEAN_AND_MEAN

include $(THEOS_MAKE_PATH)/tweak.mk
