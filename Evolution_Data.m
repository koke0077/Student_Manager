//
//  Evolution_Data.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 18..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Evolution_Data.h"

#import <sqlite3.h>



@implementation Evolution_Data

-(void)addEvolutionIdno:(int)s_idno evoType_Idno:(int)t_Idno Point:(int)point{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
//    NSLog(@"%@", dbPath);
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    int period = [[userdefaults objectForKey:@"period"] intValue];
    
    char *sql = "INSERT INTO evolution (Students_idno, EvolutionType_Period_idno, EvolutionType_idno, point) VALUES(?,?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
        sqlite3_bind_int(statement, 1, s_idno);
        sqlite3_bind_int(statement, 2, period);
        sqlite3_bind_int(statement, 3, t_Idno);
        sqlite3_bind_int(statement, 4, point);
        
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);

    
}

-(void)updateEvoIdno:(int)s_idno evoType_Idno:(int)t_Idno Point:(int)point{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
    NSLog(@"%@", dbPath);
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
//    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
//    int period = [[userdefaults objectForKey:@"period"] intValue];
    
    sqlite3_stmt *statement;
    
    char *sql = "update evolution set point=? where Students_idno=? and  EvolutionType_idno =?";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"데이터 업데이트 오류");
    }else{
        
        sqlite3_bind_int(statement, 1, point);
        
        sqlite3_bind_int(statement, 2, s_idno);
        
        sqlite3_bind_int(statement, 3, t_Idno);
        
        if (sqlite3_step(statement) !=SQLITE_DONE) {
            NSLog(@"수정오류");
        }
        
        
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(NSArray *)getPointWithevoType:(NSString *)EvoType StNo:(int)no{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    
//    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
//    int period = [[userdefaults objectForKey:@"period"] intValue];
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:@"select evolution.point from students, subject, evolutionType, evolution where students.no = evolution.Students_idno and evolutionType.Period_idno=evolution.EvolutionType_Period_idno and evolutionType.idno=evolution.EvolutionType_idno and subject.idno = evolutionType.Subject_idno and evolutionType.typeName = '%@' and evolution.Students_idno = %d",EvoType, no] UTF8String];
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno", nil];
            
            [Result addObject:dic];
        }
    }
    
    return Result;

    
}

-(NSArray *)getPointWithevoType:(NSString *)EvoType{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    
//    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
//    int period = [[userdefaults objectForKey:@"period"] intValue];
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:@"select evolution.point from students, subject, evolutionType, evolution where students.no = evolution.Students_idno and evolutionType.Period_idno=evolution.EvolutionType_Period_idno and evolutionType.idno=evolution.EvolutionType_idno and subject.idno = evolutionType.Subject_idno and evolutionType.typeName = '%@'",EvoType] UTF8String];
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
//            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno", nil];
            [Result addObject:[NSNumber numberWithInt:sqlite3_column_int(statement, 0)]];
            

        }
    }
    
    return Result;
}


-(void)deleteTypeIdno:(int)typeIdno{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
//    NSLog(@"%@", dbPath);
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    char *sql2 = (char *)[[NSString stringWithFormat:
                           @"delete from evolutionType where evolution.EvolutionType_idno = %d",typeIdno]
                          UTF8String];
    
    
    if (sqlite3_prepare_v2(database, sql2, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"삭제에러");
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 삭제에러");
        }
    }
    
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}


@end
