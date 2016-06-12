//
//  Student_Data.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 20..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student_Data : NSObject

-(void)addDataWithName:(NSString *)name
                 Birth:(NSString *)birth
                Phone1:(NSString *)phone1
                 Name2:(NSString *)name2
                Phone2:(NSString *)phone2
                 Name3:(NSString *)name3
                Phone3:(NSString *)phone3
                   Tel:(NSString *)tel
               Address:(NSString *)address
                  Memo:(NSString *)memo
              Img_data:(NSData *)img_data;

-(void)removeDataWithStudents_Idno:(int)students_Idno indexPath:(int)path_row;

-(void)upDateWithName:(NSString *)name
                 Birth:(NSString *)birth
                Phone1:(NSString *)phone1
                 Name2:(NSString *)name2
                Phone2:(NSString *)phone2
                 Name3:(NSString *)name3
                Phone3:(NSString *)phone3
                   Tel:(NSString *)tel
               Address:(NSString *)address
                  Memo:(NSString *)memo
             Img_data:(NSData *)img_data
               S_Idno:(int)no;

-(void)row_idUpdateNo:(int)no;

-(NSArray *)getRecords;

-(NSArray *)getFaceImgs;

-(NSArray *)getNum;

-(NSArray *)getName;

@end
