//
//  FWKeyboardManager.m
//  
//
//  Created by admin on 15-1-20.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "FWKeyboardManager.h"
#import "FWKeyboardUtil.h"
#import "NSDictionary+FWKeyboard.h"
#import "FWKeyboardUtil.h"

//http://blog.csdn.net/xuhuan_wh/article/details/8506754
@implementation FWKey
- (instancetype)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        if (dict && [dict isKindOfClass:[NSDictionary class]]) {
            self.backStyle = [[dict objectForKey:@"BACK_STYLE"] integerValue];
            self.foreStyle = [[dict objectForKey:@"FORE_STYLE"] integerValue];
            self.viewRect  = [dict rectForKey:@"VIEW_RECT"];
            NSString* value= [dict objectForKey:@"CENTER"];
            //value = [FWKeyboardUtil mapWithKeyValue:value] ? [FWKeyboardUtil mapWithKeyValue:value] :value;
            self.value     = value;
        }
    }
    return self;
}

@end

@implementation FWKeyboard
-(instancetype)initWithKeyboardPath:(NSString*)path{
    self = [super init];
    if (self) {
        if ([path length] >0) {
            NSMutableArray *keyItems = [NSMutableArray arrayWithCapacity:0];
            NSDictionary *dict = [FWKeyboardUtil dictionaryWithFile:path];
            for (NSString *key  in dict.allKeys) {
                if ([key hasPrefix:@"KEY"]) {
                    FWKey *keyItem = [[FWKey alloc] initWithDictionary:[dict objectForKey:key]];
                    [keyItems addObject:keyItem];
                }
            }
            self.keyItems = [keyItems copy];
            NSLog(@">>>%@",dict);
        }
    }
    return self;
}

@end

@implementation FWTextKeyboard
-(instancetype)initWithKeyboardPath:(NSString*)path{
    self = [super initWithKeyboardPath:path];
    if (self) {
        self.categoryItems = @[@"最近",@"开心",@"卖萌",@"吃惊",@"最近",@"开心",@"卖萌", @"吃惊"];
        self.contentItems  = @[
                               @[@"1^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)"],
                               @[@"2^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)"],
                               @[@"3^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)"],
                               @[@"4^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)"],
                               @[@"5^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)"],
                               @[@"6^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)"],
                               @[@"7^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)"],
                               @[@"8^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)",@"^_^",@"=_=",@"=_^",@"($_$)"]];
    }
    return self;
}

- (void)loadTextWithCategory:(NSString*)category pageNumber:(NSInteger)pageNumber {
    //NSDictionary* dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",self.type] forKey:@"loadType"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ad.meimotuan.com/api/font/getKeyBoardWordList"]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@">>>%@ %@",response,data);
    }];
    
//    [HttpClient requestDataWithPath:@"/api/font/getKeyBoardWordList" paramers:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
}

@end

@implementation FWEmotionKeyboard
-(instancetype)initWithKeyboardPath:(NSString*)path{
    self = [super initWithKeyboardPath:path];
    if (self) {
        self.emotionItems = @[@"表情1",@"表情2",@"表情3",@"表情4",@"表情5",@"表情6",@"表情7",@"表情8",@"表情1",@"表情2",@"表情3",@"表情4",@"表情5",@"表情6",@"表情7",@"表情8",@"表情1",@"表情2",@"表情3",@"表情4",@"表情5",@"表情6",@"表情7",@"表情8"];
    }
    return self;
}

- (void)loadEmotionWithCompletionBlock:(FWCompletionBlock)completionBlock{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ad.meimotuan.com/api/font/getKeyBoardIconList"]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@">>>%@ %@",response,data);
    }];
    
//    [HttpClient requestDataWithPath:@"/api/font/getKeyBoardIconList" paramers:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
}

@end

@interface FWKeyboardManager()
@property(nonatomic, strong)NSArray      *keyboardNames;
@property(nonatomic, strong)NSDictionary *keyboards;
@end

@implementation FWKeyboardManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        self.keyboardNames = @[@"py_26.ini",@"num_26.ini",@"text.ini",@"emotion.ini"];
        for (NSString *name in self.keyboardNames) {
            NSString *path = [self fullPathWithKeyboard:name];
            FWKeyboard *keybaord = nil;
            if ([name isEqualToString:@"text.ini"]) {
                keybaord = [[FWTextKeyboard alloc] initWithKeyboardPath:path];
            } else if ([name isEqualToString:@"emotion.ini"]) {
                keybaord = [[FWEmotionKeyboard alloc] initWithKeyboardPath:path];
            } else {
                keybaord = [[FWKeyboard alloc] initWithKeyboardPath:path];
            }
            [dict setObject:keybaord forKey:name];
            if (!self.currentKeyboard) {
                self.currentKeyboard = keybaord;
            }
        }
        self.keyboards = [dict copy];
    }
    return self;
}


- (void)changedKeyboard:(FWKeyboardType)keyboardType{
    NSString *name = [self.keyboardNames objectAtIndex:keyboardType];
    self.currentKeyboard = [self.keyboards objectForKey:name];
}

- (BOOL)handlerWithKey:(NSString*)keyValue{
    if ([keyValue hasPrefix:@"123"]) {
        [self changedKeyboard:FWKeyboardNum26];
        return YES;
    }
    else if ([keyValue hasPrefix:@"F1"]) {//@"#+="
        
    }else if ([keyValue hasPrefix:@"F2"]) {
        [self changedKeyboard:FWKeyboardAbc26];
        return YES;
    }else if ([keyValue hasPrefix:@"F3"]) {
        [self changedToNextInput];
    }else if ([keyValue hasPrefix:@"F4"]) {
        [self changedKeyboard:FWKeyboardText];
        return YES;
    }else if ([keyValue hasPrefix:@"F5"]) {
        [self changedKeyboard:FWKeyboardEmotion];
        return YES;
    }else if ([keyValue hasPrefix:@"F6"]) {
        [self handlerInput:@" "];
    }else if ([keyValue hasPrefix:@"F7"]) {
        //[self.textDocumentProxy deleteBackward];
    }else if ([keyValue hasPrefix:@"F8"]) {//send
        [self handlerInput:@"\n"];
    }else if ([keyValue hasPrefix:@"F9"]) {//shift
        
    }else if ([keyValue hasPrefix:@"F10"]) {
        
    }else if ([keyValue hasPrefix:@"F11"]) {
        
    } else {
        [self handlerInput:keyValue];
    }
    
    return NO;
}

- (BOOL)isDeleteBackKey:(NSString*)keyValue{
    if ([keyValue isEqualToString:@"F7"]) {
        return YES;
    }
    return NO;
}

//http://stackoverflow.com/questions/25472388/how-to-check-the-allow-full-access-is-enabled-in-ios-8
-(BOOL)isOpenAccessGranted{
    NSError *err = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *containerPath = [[fm containerURLForSecurityApplicationGroupIdentifier:@"group.funword"] path];
    [fm contentsOfDirectoryAtPath:containerPath error:&err];
    
    if(err != nil){
        NSLog(@"Full Access: Off");
        return NO;
    }
    
    NSLog(@"Full Access On");
    return YES;
}

#pragma mark - Privte
- (NSString*)fullPathWithKeyboard:(NSString*)keyboardName{
    NSString *path = [[NSBundle mainBundle] pathForResource:keyboardName ofType:nil];
    return path;
}
- (void)changedToNextInput{
    [self.inputVC advanceToNextInputMode];
}

- (void)handlerInput:(NSString*)input{
    if ([input length] >0) {
        [self.textDocumentProxy insertText:input];
    }
}

@end
