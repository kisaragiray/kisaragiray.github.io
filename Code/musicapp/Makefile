THEOS_DEVICE_IP = 127.0.0.1
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:13.0
FINALPACKAGE = 1
FOR_RELEASE = 1

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = MusicApp
$(APPLICATION_NAME)_FILES = \
	$(wildcard *.mm) \
	MusicAppController.xm \
	$(shell find $(THEOS)/include/AutoScrollLabel -name '*.mm') \

$(APPLICATION_NAME)_FRAMEWORKS = UIKit CoreGraphics
$(APPLICATION_NAME)_PRIVATE_FRAMEWORKS = MediaRemote
$(APPLICATION_NAME)_CFLAGS += \
	-Wno-error \
	#-Wno-error=unused-variable \
	#-Wno-error=unused-function \
	#-fvisibility=hidden \
	#-Wdeprecated-declarations


TWEAK_NAME = musicappSpringBoardHook
$(TWEAK_NAME)_FILES = musicappSpringBoardHook.xm
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = MediaRemote BulletinBoard
ADDITIONAL_OBJCFLAGS = -fobjc-arc

RED=\033[0;31m
CYAN=\033[0;36m
NC=\033[0m
BOLD=\033[1m
MAGENTA=\x1b[35m

TEXT = "\n\n\n${BOLD}>>> Finished Compiling!!${NC}\n${MAGENTA}${BOLD}>>> $(APPLICATION_NAME)${NC}\n${CYAN}${BOLD}>>> Copyright (C) 2019-2021 mikiyan1978${NC}\n\n\n"

.PHONY:	show_text
show_text:
	@echo $(TEXT)

include $(THEOS_MAKE_PATH)/application.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-stage::
	$(ECHO_NOTHING)chmod 06755 $(THEOS_STAGING_DIR)/Applications/$(APPLICATION_NAME).app/$(APPLICATION_NAME) $(ECHO_END)

after-install::
	@install.exec "killall \"$(APPLICATION_NAME)\"" || true
	@install.exec "open com.mikiyan1978.musicapp"
