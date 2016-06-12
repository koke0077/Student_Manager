//
//  AppDelegate.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 19..
//  Copyright (c) 2014년 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property BOOL is_Security;

@property (nonatomic, assign) NSDictionary *consulting_data;

@property int consultion_Section;

@property (nonatomic, strong) NSMutableArray *face_arr;

@property (nonatomic, strong) NSDictionary *st_dic;

@property int students_idno;

@property BOOL is_delete;

@property int student_row;

-(void)initDB;

- (NSString *)getDBPath;



//-(void)addDataWithName:(NSString *)name
//                 Birth:(NSString *)birth
//                Phone1:(NSString *)phone1
//                Phone2:(NSString *)phone2
//                Phone3:(NSString *)phone3
//                Phone4:(NSString *)phone4
//               Address:(NSString *)address
//                  Memo:(NSString *)memo
//              Img_data:(NSData *)img_data;
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
//               Img_data:(NSData *)img_data;
//
//-(void)removeDataWithNo:(int)no;
//
//-(NSArray *)getRecords;
//
//-(NSDictionary *)getRecordWithNo:(int)no;

@end
