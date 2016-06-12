//
//  AppDelegate.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 19..
//  Copyright (c) 2014년 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"

#import <sqlite3.h>

@implementation AppDelegate
@synthesize is_Security, consulting_data, consultion_Section, face_arr, st_dic, students_idno, is_delete, student_row;


- (NSString *)getDBPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"Student_Data.sqlite"];
}

-(void)initDB{
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
    NSLog(@"%@",dbPath);
    
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Student_Data.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:nil];
		
		if (!success) NSLog(@"데이터베이스 파일 복사 실패.");
	}
}

//-(void)addDataWithName:(NSString *)name
//                 Birth:(NSString *)birth
//                Phone1:(NSString *)phone1
//                Phone2:(NSString *)phone2
//                Phone3:(NSString *)phone3
//                Phone4:(NSString *)phone4
//               Address:(NSString *)address
//                  Memo:(NSString *)memo
//              Img_data:(NSData *)img_data{
//    
//}
//
//-(void)modifyDataWithNo:(int)no
//                   Name:(NSString *)name
//                  Birth:(NSString *)birth
//                 Phone1:(NSString *)phone1
//                 Phone2:(NSString *)phone2
//                 Phone3:(NSString *)phone3
//                 Phone4:(NSString *)phone4
//                Address:(NSString *)address
//                   Memo:(NSString *)memo
//               Img_data:(NSData *)img_data{
//    
//}
//
//-(void)removeDataWithNo:(int)no{
//    
//}
//
//-(NSArray *)getRecords{
//    
//}
//
//-(NSDictionary *)getRecordWithNo:(int)no{
//    
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self initDB];
    
    is_delete = NO;

    NSUserDefaults *security = [NSUserDefaults standardUserDefaults];
    
    if ([security stringForKey:@"secure"]==nil) {
        is_Security = NO;
    }else{
        is_Security = YES;
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
