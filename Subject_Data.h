//
//  Subject_Data.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 16..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Subject_Data : UIViewController

-(void) deleteSubjectIdno:(int)idno;

-(void) addSubjectWithIDno:(int)idno Subject_Name:(NSString *)subject_name;

-(void) deleteWithSubject:(NSString *)subject;

-(void) addSubjectTypeIdno:(int)idno Subject_idno:(int)subject_idno TypeName:(NSString *)typeName;

-(void) deleteSubjectType:(NSString *)subjectType Idno:(int)idno;

-(int) getSubjectTypeIdnoWithSubjectName:(NSString *)subjectname;

-(NSArray *)getSubjectName;

-(NSArray *) getSubjectTypeName:(NSString *)name;

@end
