THEOS_DEVICE_IP = 127.0.0.1
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard
FINALPACKAGE=1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = respaddpref
$(TWEAK_NAME)_FILES = \
	$(wildcard *.xm) \
	respaddpref.xmi \
	$(shell find $(THEOS)/include/JGProgressHUD -name '*.m')
ADDITIONAL_OBJCFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
