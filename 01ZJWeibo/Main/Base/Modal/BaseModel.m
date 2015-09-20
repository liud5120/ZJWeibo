//
//  BaseModel.m
//  01ZJWeibo
//
//  Created by zhoujie on 15/8/23.
//  Copyright (c) 2015年 zhoujie. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (SEL)getSetterSelWithAttibuteName:(NSString*)attributeName{
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
    NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
    return NSSelectorFromString(setterSelStr);


}

-(id)initWithDataDic:(NSDictionary *)dataDic{
    self = [super init];
    if (self) {
        [self setAttributes:dataDic];
    }
    return  self;
}


- (NSDictionary*)attributeMapDictionary{
    return  nil;
    
}

//设置属性
- (void)setAttributes:(NSDictionary*)dataDic{
    
    NSDictionary *attrMapDic = [self attributeMapDictionary];
    //如果没有映射字典，则直接用字段名 作为 属性名
    if (attrMapDic == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[dataDic count]];
        for (NSString *key in dataDic) {
            [dic setValue:key forKey:key];
            attrMapDic = dic;
        }
    }
    
    //@"name" @"time"
    NSArray *attrbuteNameArray = [attrMapDic allKeys];
    for (NSString *attributeName in attrbuteNameArray) {
        //通过属性名获得set方法
        SEL sel = [self getSetterSelWithAttibuteName:attributeName];
        //setName setTime
        if ([self respondsToSelector:sel]) {
            //得到数据字典中的字段关键值
            NSString *dataDicKey = [attrMapDic objectForKey:attributeName];
            //得到数据字典中的值
            id attributeValue = [dataDic objectForKey:dataDicKey];
            //调用set方法 为属性赋值
            [self performSelector:sel withObject:attributeValue];
        }
        
    }
    
    
}
@end
