#import <CoreFoundation/CoreFoundation.h>

static BOOL AODUnlockIsCapability(CFStringRef question) {
    if (!question || CFGetTypeID(question) != CFStringGetTypeID()) return NO;

    return CFStringCompare(question, CFSTR("DeviceSupportsAlwaysOnTime"), 0) == kCFCompareEqualTo ||
           CFStringCompare(question, CFSTR("DeviceSupportsAlwaysOnDisplay"), 0) == kCFCompareEqualTo;
}

%hookf(BOOL, MGGetBoolAnswer, CFStringRef question) {
    if (AODUnlockIsCapability(question)) return YES;
    return %orig(question);
}

%hookf(CFTypeRef, MGCopyAnswer, CFStringRef question) {
    if (AODUnlockIsCapability(question)) return CFRetain(kCFBooleanTrue);
    return %orig(question);
}

%ctor {
    void *getBoolAnswer = MSFindSymbol(NULL, "_MGGetBoolAnswer");
    void *copyAnswer = MSFindSymbol(NULL, "_MGCopyAnswer");
    if (getBoolAnswer) %init(MGGetBoolAnswer = getBoolAnswer);
    if (copyAnswer) %init(MGCopyAnswer = copyAnswer);
}
