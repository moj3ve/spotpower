@interface SPUITextField
-(void)updateWithColor:(id)arg1;
-(void)itsSafemodeTime;
@end

@interface FBSystemService : NSObject
+(id)sharedInstance;
-(void)exitAndRelaunch:(BOOL)arg1;
-(void)shutdownAndReboot:(BOOL)arg1;
-(void)shutdownWithOptions:(unsigned long long)arg1;
@end