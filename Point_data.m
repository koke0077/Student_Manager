//
//  Point_data.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 13..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Point_data.h"
#import <sqlite3.h>

@implementation Point_data

-(void) addDataIdnoStudent_idno:(int)students_idno
          BluePoint:(NSString *)bluePoint
           RedPoint:(NSString *)redPoint
           SumPoint:(NSString *)sumPoint
              Reason:(NSString *)reason{
    
    sqlite3 *database;
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
//    NSLog(@"%@", dbPath);
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
//      NSLog(@"student_idno = %d\n", students_idno);
    
    char *sql = "INSERT INTO point (Students_idno, bluepoint, redpoint, sumpoint, reason) VALUES(?,?,?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
        sqlite3_bind_int(statement, 1, students_idno);
        sqlite3_bind_text(statement, 2, [bluePoint UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [redPoint UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [sumPoint UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [reason UTF8String], -1, SQLITE_TRANSIENT);
        
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
}

-(void) updateDataStudent_idno:(int)students_idno
                     BluePoint:(NSString *)bluePoint
                      RedPoint:(NSString *)redPoint
                      SumPoint:(NSString *)sumpoint
                        Reason:(NSString *)reason{
    
    sqlite3 *database;
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    sqlite3_stmt *statement;
    
    char *sql = "UPDATE point SET bluepoint=?, redpoint=?, sumpoint=?, reason=? WHERE Students_idno=?";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"데이터 업데이트 오류");
    }else{
        
        sqlite3_bind_text(statement, 1, [bluePoint UTF8String], -1, SQLITE_TRANSIENT);
        
        sqlite3_bind_text(statement, 2, [redPoint UTF8String], -1, SQLITE_TRANSIENT);
        
        sqlite3_bind_text(statement, 3, [sumpoint UTF8String], -1, SQLITE_TRANSIENT);
        
        sqlite3_bind_text(statement, 4, [reason UTF8String], -1, SQLITE_TRANSIENT);
        
        sqlite3_bind_int(statement, 5, students_idno);
        
        if (sqlite3_step(statement) !=SQLITE_DONE) {
            NSLog(@"수정오류");
        }
        
        
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);

    
}


-(NSArray *) getPointData{
    
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
    
    char *sql = "SELECT Students_idno, bluepoint, redpoint, sumpoint, reason  FROM point";
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"Students_idno",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)],@"bluepoint",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)],@"redpoint",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)],@"sumpoint",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)],@"reason",
                                 nil];
            
            [Result addObject:dic];
            
            //            NSLog(@"%d",[Result count]);
        }
    }
    
    return Result;

    
}

-(NSArray *) getPointDataStudent_idno:(int)student_idno{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    
    sqlite3_stmt *statement;
    
    //    NSLog(@"student_idno = %d", student_idno);
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"select * from point b where b.Students_idno = %d",
                          student_idno] UTF8String];
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"Students_idno",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)],@"bluepoint",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)],@"redpoint",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)],@"sumpoint",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)],@"reason",
                                 nil];
            
//            NSLog(@"%@",dic);
            [Result addObject:dic];
            
            //
        }
    }
    
    return Result;
    
}

@end
