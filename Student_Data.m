//
//  Student_Data.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 20..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Student_Data.h"
#import <sqlite3.h>
#import "AppDelegate.h"

@implementation Student_Data


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
              Img_data:(NSData *)img_data{
    
    sqlite3 *database;
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    
    
    char *sql = "INSERT INTO students (name, birth, phone1, name2, phone2, name3, phone3, tel, address, memo, img_data) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [birth UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [phone1 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [name2 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [phone2 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [name3 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 7, [phone3 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 8, [tel UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 9, [address UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 10, [memo UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_blob(statement, 11, [img_data bytes], (int)[img_data length], SQLITE_TRANSIENT);
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

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
               S_Idno:(int)no{
    
    sqlite3 *database;
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    
    char *sql = "update students set name=?, birth =?, phone1=?, name2=?, phone2=?, name3=?, phone3=?, tel=?, address=?, memo=?, img_data=? where no=?";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"데이터 업데이트 오류");
    }else{
        
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [birth UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [phone1 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [name2 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [phone2 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [name3 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 7, [phone3 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 8, [tel UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 9, [address UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 10, [memo UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_blob(statement, 11, [img_data bytes], (int)[img_data length], SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 12, no);
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"업데이트 저장에러");
        }
        
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(void)row_idUpdateNo:(int)no{
    
    NSLog(@"(int) no =%d",no);
    
    sqlite3 *database;
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"UPDATE students set no=no-1 WHERE no>%d",
                          no]UTF8String];
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"데이터 업데이트 오류");
    }else{
        
        if (sqlite3_step(statement) !=SQLITE_DONE) {
            NSLog(@"수정오류");
        }
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
}

-(void)removeDataWithStudents_Idno:(int)students_Idno indexPath:(int)path_row{
    
    sqlite3 *database;
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    char *sql = "DELETE FROM students WHERE no=?";
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, students_Idno);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@" 학생 데이터 삭제 오류");
        }
    }
    
    char *sql2 = "DELETE FROM consultingInfo WHERE Students_idno=?";
    if (sqlite3_prepare_v2(database, sql2 , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, path_row);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"상담 데이터 삭제 오류");
        }
    }
    
    char *sql3 = "DELETE FROM point WHERE Students_idno=?";
    if (sqlite3_prepare_v2(database, sql3 , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, path_row);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"평점 상담 데이터 삭제 오류");
        }
    }
    
    char *sql4 = "DELETE FROM evolution WHERE Students_idno=?";
    if (sqlite3_prepare_v2(database, sql4 , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, path_row);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"평점 상담 데이터 삭제 오류");
        }
    }
    
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(NSArray *)getRecords{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류 SD");
        return nil;
    }
    
    NSMutableArray *Result = [[NSMutableArray alloc]initWithCapacity:15];
    
    [Result removeAllObjects];
    
    sqlite3_stmt *statement;
    
//    char *sql = "SELECT name, birth, phone1, name2, phone2, name3, phone3, tel, address, memo, img_data FROM students";
    
    char *sql = "SELECT no, name, birth, phone1, name2, phone2, name3, phone3, tel, address, memo, img_data FROM students";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"no",
                                 
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)],@"name",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)],@"birth",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)],@"phone1",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)],@"name2",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)],@"phone2",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)],@"name3",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)],@"phone3",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)],@"tel",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)],@"address",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)],@"memo",
                                 [NSData dataWithBytes:sqlite3_column_blob(statement, 11) length:sqlite3_column_bytes(statement, 11)],@"img_data",
                                 nil];
            
//            NSLog(@"dic.name = %@", [dic objectForKey:@"name"]);
            
            [Result addObject:dic];
            
//            NSLog(@"%d",[Result count]);
            
//            NSLog(@"dic.name = %@", [dic objectForKey:@"birth"]);
            
//            NSLog(@"name는? = %@ ",dic);
        }
    }
    
    return Result;

}


-(NSArray *)getFaceImgs{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray *Result = [[NSMutableArray alloc]initWithCapacity:15];
    
    [Result removeAllObjects];
    
    sqlite3_stmt *statement;
    
    //    char *sql = "SELECT name, birth, phone1, name2, phone2, name3, phone3, tel, address, memo, img_data FROM students";
    
    char *sql = "SELECT img_data FROM students";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"no",
                                 
                                 [NSData dataWithBytes:sqlite3_column_blob(statement, 1) length:sqlite3_column_bytes(statement, 1)],@"img_data",
                                 nil];
            

            
            [Result addObject:dic];
            
       
        }
    }
    
    return Result;
}

-(NSArray *)getName{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray *Result = [[NSMutableArray alloc]initWithCapacity:15];
    
    [Result removeAllObjects];
    
    sqlite3_stmt *statement;
    
    //    char *sql = "SELECT name, birth, phone1, name2, phone2, name3, phone3, tel, address, memo, img_data FROM students";
    
    char *sql = "SELECT name FROM students";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            [Result addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
        }
    }
    
    return Result;
    
}

-(NSArray *)getNum{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray *Result = [[NSMutableArray alloc]initWithCapacity:15];
    
    [Result removeAllObjects];
    
    sqlite3_stmt *statement;
    
    //    char *sql = "SELECT name, birth, phone1, name2, phone2, name3, phone3, tel, address, memo, img_data FROM students";
    
    char *sql = "SELECT no FROM students";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            [Result addObject:[NSNumber numberWithInt:sqlite3_column_int(statement, 0)]];
        }
    }
    
    return Result;
}

@end
