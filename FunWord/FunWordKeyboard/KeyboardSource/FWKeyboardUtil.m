//
//  FWKeyboardUtil.m
//  
//
//  Created by admin on 15-1-20.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "FWKeyboardUtil.h"

@implementation FWKeyboardUtil
+ (NSMutableDictionary *)dictionaryWithFile:(NSString*)filePath
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    NSString* contents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    contents		   = [contents stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    NSArray*  lines    = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSString* section  = nil;
    NSMutableDictionary* pairs = nil;
    for (NSString* line in lines)
    {
        NSString* item = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([item hasPrefix:@";"])
        {
            continue;
        }
        
        if ([item hasPrefix:@"["] && [item hasSuffix:@"]"])
        {
            section = [item substringWithRange:NSMakeRange(1, item.length - 2)];
            [section stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            pairs   = [NSMutableDictionary dictionaryWithCapacity:0];
            [dict setObject:pairs forKey:section];
            continue;
        }
        
        NSArray* pair = [item componentsSeparatedByString:@"="];
        if (2 == [pair count])
        {
            NSString* key   = [[pair objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString* value = [[pair objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [pairs setObject:value forKey:key];
        }
    }
    
    return dict;
}

+ (NSString*)mapWithKeyValue:(NSString*)keyValue{
    NSDictionary *dict = @{@"F1":@"#+=",@"F2":@"abc",@"F3":@"bt_language",@"F4":@"bt_text",
                           @"F5":@"bt_emotion",@"F6":@"bt_space",@"F7":@"bt_backspace",@"F8":@"bt_send",
                           @"F9":@"bt_shift"};
    NSString *result = [dict objectForKey:keyValue] ? [dict objectForKey:keyValue] : keyValue;
    return result;
}


@end
