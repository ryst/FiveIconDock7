export ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = FiveIconDock7
FiveIconDock7_FILES = Tweak.xm
FiveIconDock7_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
