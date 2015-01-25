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


@interface FWTextKeyboard()
@property(nonatomic, copy)FWCompletionBlock completionBlock;
@end

@implementation FWTextKeyboard
-(instancetype)initWithKeyboardPath:(NSString*)path{
    self = [super initWithKeyboardPath:path];
    if (self) {
#if 0
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
#endif
    }
    return self;
}

- (void)loadTextWithCompletionBlock:(FWCompletionBlock)completionBlock{
    if ([FWKeyboardManager isOpenAccessGranted]) {
        self.completionBlock = completionBlock;
        __weak typeof(self) weakSelf = self;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ad.meimotuan.com/api/font/getKeyBoardWordList"]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                BOOL result = NO;
                NSError *error = nil;
                id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (error == nil) {
                    [weakSelf parseData:responseObject];
                    result = YES;
                }

                if (weakSelf.completionBlock) {
                    weakSelf.completionBlock(result);
                }
                NSLog(@">>>%@ %@",response,data);
        }];
    }
}

- (void)addRecentText:(NSString*)text{
    if ([text  length] >0) {
        NSMutableArray *result = [self.contentItems mutableCopy];
        NSMutableArray *mutArray = [self.contentItems objectAtIndex:0];
        [mutArray addObject:text];
        [result replaceObjectAtIndex:0 withObject:mutArray];
        self.contentItems = [result copy];
    }
}


#pragma mark - Privte 
- (void)parseData:(NSDictionary*)dict{
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSMutableArray *category  = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *cateItems = [NSMutableArray arrayWithCapacity:0];

        NSArray *array  = [dict objectForKey:@"KeyBoardWordList"];
        for (NSDictionary *item in array) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                NSString *name = [item objectForKey:@"name"];
                if (name) {
                    [category addObject:name];
                }
                NSMutableArray *childTitlesArray = [NSMutableArray arrayWithCapacity:0];
                NSArray *childTitles = [item objectForKey:@"childTitles"];
                if ([childTitles isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *childDict in childTitles) {
                        NSString *title = [childDict objectForKey:@"title"];
                        if (title) {
                            [childTitlesArray addObject:title];
                        }
                    }
                }
                [cateItems addObject:[childTitlesArray copy]];
            }
        }
        self.categoryItems = [category  copy];
        self.contentItems  = [cateItems copy];
    }
}

@end

@interface FWEmotionKeyboard ()
@property(nonatomic, copy)FWCompletionBlock completionBlock;

@end

@implementation FWEmotionKeyboard
-(instancetype)initWithKeyboardPath:(NSString*)path{
    self = [super initWithKeyboardPath:path];
    if (self) {
#if 0
        self.emotionItems = @[@"表情1",@"表情2",@"表情3",@"表情4",@"表情5",@"表情6",@"表情7",@"表情8",@"表情1",@"表情2",@"表情3",@"表情4",@"表情5",@"表情6",@"表情7",@"表情8",@"表情1",@"表情2",@"表情3",@"表情4",@"表情5",@"表情6",@"表情7",@"表情8"];
#endif
    }
    return self;
}

- (void)loadEmotionWithCompletionBlock:(FWCompletionBlock)completionBlock{
    if ([FWKeyboardManager isOpenAccessGranted]) {
        self.completionBlock = completionBlock;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ad.meimotuan.com/api/font/getKeyBoardIconList"]];
        __weak typeof(self) weakSelf = self;
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            BOOL result = NO;
            NSError *error = nil;
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error == nil) {
                [weakSelf parseData:responseObject];
                result = YES;
            }
            
            if (weakSelf.completionBlock) {
                weakSelf.completionBlock(result);
            }
            NSLog(@">>>%@ %@",response,data);
        }];
    }
}
- (void)parseData:(NSDictionary*)dict{
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSMutableArray *items  = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *ids    = [NSMutableArray arrayWithCapacity:0];

        NSArray *array  = [dict objectForKey:@"KeyBoardIconList"];
        for (NSDictionary *item in array) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                NSString *imageURL = [item objectForKey:@"content"];
                if (imageURL) {
                    [items addObject:imageURL];
                }
                NSString *idNum = [item objectForKey:@"id"];
                if (idNum) {
                    [ids addObject:[NSString stringWithFormat:@"表情%@",idNum]];
                }
            }
        }
        
        self.emotionImages = [items copy];
        self.emotionItems  = [ids   copy];
    }
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
                FWTextKeyboard *key = [[FWTextKeyboard alloc] initWithKeyboardPath:path];
                [key loadTextWithCompletionBlock:^(BOOL isSuccess) {
                    
                }];
                keybaord = key;
            } else if ([name isEqualToString:@"emotion.ini"]) {
                FWEmotionKeyboard *key = [[FWEmotionKeyboard alloc] initWithKeyboardPath:path];
                [key loadEmotionWithCompletionBlock:^(BOOL isSuccess) {
                    
                }];
                keybaord = key;
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
    //recent input
    if (self.currentType == FWKeyboardText) {
        [((FWTextKeyboard*)self.currentKeyboard) addRecentText:input];
    }
}

@end
