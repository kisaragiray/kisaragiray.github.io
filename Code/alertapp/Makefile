THEOS_DEVICE_IP = 127.0.0.1
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard
FINALPACKAGE=1

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = PowerControllerApp
$(APPLICATION_NAME)_FILES = \
	$(wildcard *.m) \
	XXAppDelegate.mm \
	XXRootViewController.xm \
	HelpViewController.mm \
	SettingViewController.xm \
	LEDSwitch.mm\
	$(shell find $(THEOS)/include/addButtonManager -name '*.mm') \
	$(shell find $(THEOS)/include/addLabelManager -name '*.mm') \
	$(shell find $(THEOS)/include/addAlertManager -name '*.mm') \
	$(shell find $(THEOS)/include/LocationHandler -name '*.mm')

$(APPLICATION_NAME)_FRAMEWORKS = UIKit CoreGraphics AVFoundation
$(APPLICATION_NAME)_LDFLAGS = -lMobileGestalt
$(APPLICATION_NAME)_LIBRARIES = powercontroller
$(APPLICATION_NAME)_EXTRA_FRAMEWORKS += Cephei
ADDITIONAL_CFLAGS += -DTHEOS_LEAN_AND_MEAN
ADDITIONAL_OBJCFLAGS = -fobjc-arc

TWEAK_NAME = alertappnoti
$(TWEAK_NAME)_FILES = alertappnoti.xm
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/application.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-stage::
	$(ECHO_NOTHING)chmod 06755 $(THEOS_STAGING_DIR)/Applications/$(APPLICATION_NAME).app/$(APPLICATION_NAME) $(ECHO_END)

SUBPROJECTS += alertapppref
include $(THEOS_MAKE_PATH)/aggregate.mk
