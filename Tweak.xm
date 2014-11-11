/*
 *
 * This tweak allows the dock to hold up to 5 icons.
 * iPhone only
 *
 */

#include "ISIconSupport.h"

#ifndef kCFCoreFoundationVersionNumber_iOS_7_0
#define kCFCoreFoundationVersionNumber_iOS_7_0 847.20
#endif

%group FiveIconDock7
%hook SBDockIconListView
-(CGPoint)originForIconAtIndex:(unsigned)index {
	if ([[self icons] count] == 5) {
		switch (index) {
			case 0:
				return CGPointMake(4, 14);
			case 1:
				return CGPointMake(67, 14);
			case 2:
				return CGPointMake(130, 14);
			case 3:
				return CGPointMake(193, 14);
			case 4:
				return CGPointMake(256, 14);
			default:
				break;
		}
	}

	return %orig;
}

+(unsigned)iconColumnsForInterfaceOrientation:(int)interfaceOrientation {
	if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
		return 5;
	} else {
		return %orig;
	}
}

-(unsigned)iconsInRowForSpacingCalculation {
	return [[self icons] count];
}
%end
%end

%ctor {
	if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0) {
		if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
			%init(FiveIconDock7);

			dlopen("/Library/MobileSubstrate/DynamicLibraries/IconSupport.dylib", RTLD_NOW);
			[[%c(ISIconSupport) sharedInstance] addExtension:@"com.ryst.fiveicondock7"];
		}
	}
}

