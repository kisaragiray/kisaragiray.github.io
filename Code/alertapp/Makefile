THEOS_DEVICE_IP = 127.0.0.1
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
FINALPACKAGE = 1
#DEBUG = 1

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = PowerControllerApp
$(APPLICATION_NAME)_FILES = \
	$(wildcard *.m) \
	XXAppDelegate.mm \
	XXRootViewController.xm \
	HelpViewController.xm \
	SettingViewController.xm \
	SceneKitView.xm \
	LEDSwitch.mm \
	UIImage+Scale.m \
	UIBarButtonItem+blocks.m \
	SystemSounds.mm \
	DataSaveHelper.mm\
	SoundInfo.mm \
	SoundTableViewCell.mm \
	SnowView.mm \
	$(shell find $(THEOS)/include/addButtonManager -name '*.mm') \
	$(shell find $(THEOS)/include/addLabelManager -name '*.mm') \
	$(shell find $(THEOS)/include/addAlertManager -name '*.mm') \
	$(shell find $(THEOS)/include/LocationHandler -name '*.mm') \
	$(shell find $(THEOS)/include/CountButton -name '*.m') \
	$(shell find $(THEOS)/include/CFUserNotificationHandler -name '*.mm') \
	$(shell find $(THEOS)/include/AutoScrollLabel -name '*.mm') \
	$(shell find $(THEOS)/include/CAEmitterLayerView -name '*.mm') \
	$(shell find $(THEOS)/include/LikeButton -name '*.mm')\
	

$(APPLICATION_NAME)_FRAMEWORKS = \
	UIKit \
	CoreGraphics \
	AVFoundation \
	AudioToolbox \
	CoreFoundation \
	IOKit

#$(APPLICATION_NAME)_CODESIGN_FLAGS = -SEntitlements.xml
$(APPLICATION_NAME)_LDFLAGS = -lMobileGestalt
$(APPLICATION_NAME)_LIBRARIES = powercontroller 
$(APPLICATION_NAME)_EXTRA_FRAMEWORKS += Cephei
$(APPLICATION_NAME)_PRIVATE_FRAMEWORKS = \
	Preferences \
	MediaRemote \
	AppSupport
$(APPLICATION_NAME)_CFLAGS += \
	-I$(THEOS)/include/WHToast \
	#-Wno-error \
	#-Wno-error=unused-variable \
	#-Wno-error=unused-function \
	-fvisibility=hidden

ADDITIONAL_OBJCFLAGS = -fobjc-arc

TWEAK_NAME = alertappnoti
$(TWEAK_NAME)_FILES = alertappnoti.xm
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = MediaRemote
#$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/application.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-stage::
	$(ECHO_NOTHING)chmod 06755 $(THEOS_STAGING_DIR)/Applications/$(APPLICATION_NAME).app/$(APPLICATION_NAME) $(ECHO_END)

before-install::
	@install.exec "touch /mikiyan1978.no-postinst-notification"

after-install::
	@install.exec "rm -v /mikiyan1978.no-postinst-notification"
	@install.exec "killall \"PowerControllerApp\"" || true
	@install.exec "open com.mikiyan1978.alertapp"

TEXT = "正常にコンパイル出来ました！"
.PHONY:	show_text
show_text:
	@echo $(TEXT)

SUBPROJECTS += alertapppref
SUBPROJECTS += pkg-actions
include $(THEOS_MAKE_PATH)/aggregate.mk

#@install.exec "su -c uicache mobile"#
#@install.exec "uicache -p /Applications/PowerControllerApp.app"#
