//
//  Evolution_Data.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 18..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Evolution_Data : NSObject


-(void)addEvolutionIdno:(int)s_idno evoType_Idno:(int)t_Idno Point:(int)point;

-(void)updateEvoIdno:(int)s_idno evoType_Idno:(int)t_Idno Point:(int)point;

-(NSArray *)getPointWithevoType:(NSString *)EvoType StNo:(int)no;

-(void)deleteTypeIdno:(int)typeIdno;

-(NSArray *)getPointWithevoType:(NSString *)EvoType;

@end
