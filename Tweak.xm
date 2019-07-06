// (c) Castyte 2019
// Licence available in LICENCE file

#import "Tweak.h"
#include <spawn.h>
#include <signal.h>

%hook SPUITextField

-(id)text{
	NSString *text = %orig();
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
		[[%c(FBSystemService) sharedInstance] exitAndRelaunch:YES];
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
		[[%c(FBSystemService) sharedInstance] shutdownAndReboot:YES];
	}
	if([text isEqual:@"/safemode"]){
		[self itsSafemodeTime];
	}
	return text;
}
%end