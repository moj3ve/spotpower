#line 1 "Tweak.xm"



#import "Tweak.h"
#include <spawn.h>
#include <signal.h>


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class FBSystemService; @class SPUITextField; 
static id (*_logos_orig$_ungrouped$SPUITextField$text)(_LOGOS_SELF_TYPE_NORMAL SPUITextField* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$SPUITextField$text(_LOGOS_SELF_TYPE_NORMAL SPUITextField* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$FBSystemService(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("FBSystemService"); } return _klass; }
#line 8 "Tweak.xm"


static id _logos_method$_ungrouped$SPUITextField$text(_LOGOS_SELF_TYPE_NORMAL SPUITextField* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	NSString *text = _logos_orig$_ungrouped$SPUITextField$text(self, _cmd);
	if([text hasPrefix:@"/"]){
		[self updateWithColor:[UIColor redColor]];
	}
	if([text isEqual:@"/sbreload"]){
		pid_t pid;
		int status;
		const char *argv[] = {"sbreload", NULL, NULL};
		posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)argv, NULL);
		waitpid(pid, &status, WEXITED);
	}
	if([text isEqual:@"/respring"]){
		[[_logos_static_class_lookup$FBSystemService() sharedInstance] exitAndRelaunch:YES];
	}
	if([text isEqual:@"/uicache"]){
		pid_t pid;
		int status;
		const char *argv[] = {"uicache", NULL, NULL};
		posix_spawn(&pid, "/usr/bin/uicache", NULL, NULL, (char* const*)argv, NULL);
		waitpid(pid, &status, WEXITED);
		[self updateWithColor:[UIColor greenColor]];
	}
	if([text isEqual:@"/reboot"]){
		[[_logos_static_class_lookup$FBSystemService() sharedInstance] shutdownAndReboot:YES];
	}
	if([text isEqual:@"/safemode"]){
		[self itsSafemodeTime];
	}
	return text;
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SPUITextField = objc_getClass("SPUITextField"); MSHookMessageEx(_logos_class$_ungrouped$SPUITextField, @selector(text), (IMP)&_logos_method$_ungrouped$SPUITextField$text, (IMP*)&_logos_orig$_ungrouped$SPUITextField$text);} }
#line 42 "Tweak.xm"
