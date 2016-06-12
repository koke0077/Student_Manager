//
//  Consulting_data.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 21..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Consulting_data.h"
#import <sqlite3.h>

@implementation Consulting_data

-(void) addDataIdno:(int)idno
       Student_idno:(int)student_idno
               Date:(NSString *)date
           Location:(NSString *)location
             Motive:(NSString *)motive
             Method:(NSString *)method
           Category:(NSString *)category
              Story:(NSString *)story{
    
    sqlite3 *database;
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
//    
//    NSLog(@"idno = %d\n", idno);
//    NSLog(@"student_idno = %d\n", student_idno);
//    NSLog(@"date = %@\n", date);
//    NSLog(@"location = %@\n", location);
//    NSLog(@"motive = %@\n", motive);
//    NSLog(@"method = %@\n", method);
//    NSLog(@"category = %@", category);
//    NSLog(@"story = %@\n", story);
    
    char *sql = "INSERT INTO consultingInfo (idno, Students_idno, date, location, motive, method, category, story) VALUES(?,?,?,?,?,?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
        sqlite3_bind_int(statement, 1, idno);
        sqlite3_bind_int(statement, 2, student_idno);
        sqlite3_bind_text(statement, 3, [date UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [location UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [motive UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [method UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 7, [category UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 8, [story UTF8String], -1, SQLITE_TRANSIENT);
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
}

-(NSArray *) getConsultingData{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류 Con");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    
    sqlite3_stmt *statement;
    
    char *sql = "SELECT idno, Students_idno, date, location, motive, method, category, story FROM students";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno",
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 1)],@"Students_idno",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)],@"date",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)],@"location",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)],@"motive",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)],@"method",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)],@"category",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)],@"story",
                                 nil];
            
            [Result addObject:dic];
            
//            NSLog(@"%d",[Result count]);
        }
    }
    
    return Result;
}

-(NSArray *) getConsultingDataStudent_idno:(int)student_idno{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
//    NSLog(@"%@",data_Path);
    NSMutableArray *Result = [NSMutableArray array];
    
    sqlite3_stmt *statement;
    
//    NSLog(@"student_idno = %d", student_idno);
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"select * from consultingInfo b where b.Students_idno = %d",
                          student_idno] UTF8String];
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno",
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 1)],@"Students_idno",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)],@"date",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)],@"location",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)],@"motive",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)],@"method",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)],@"category",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)],@"story",
                                 nil];
            
            [Result addObject:dic];
            
//            NSLog(@"%d",[Result count]);
        }
    }
    
    return Result;
    
}

@end
