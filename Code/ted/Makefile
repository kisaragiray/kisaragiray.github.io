# If you want to compile for arm64e, you'll need a macOS device or a arm64e device that's able to compile for arm64e.
# Also, you'll have to remove '#import "KittyMemory/initializer_list"' from Menu.h for it being able to compile this menu.
# Once done that, uncomment the "#arm64e" by removing the "#"
THEOS_DEVICE_IP = 127.0.0.1
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ted
$(TWEAK_NAME)_LIBRARIES = MobileGestalt
ted_CCFLAGS = -std=c++11 -fno-rtti -fno-exceptions -DNDEBUG
ted_CFLAGS = -fobjc-arc #-w #-Wno-deprecated -Wno-deprecated-declarations
ted_FILES = Tweak.xm Menu.mm SwitchesTemplate.mm $(wildcard KittyMemory/*.cpp) $(wildcard SCLAlertView/*.m)

ted_LIBRARIES += substrate
# GO_EASY_ON_ME = 1

include $(THEOS_MAKE_PATH)/tweak.mk
