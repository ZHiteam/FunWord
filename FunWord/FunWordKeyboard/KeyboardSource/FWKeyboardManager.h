//
//  FWKeyboardManager.h
//  
//
//  Created by admin on 15-1-20.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, FWBackStyle) {
    FWBackStyle1=1,
    FWBackStyle2,
    FWBackStyle3,
};

typedef NS_OPTIONS(NSUInteger, FWKeyboardType) {
    FWKeyboardAbc26,
    FWKeyboardNum26,
    FWKeyboardText,
    FWKeyboardEmotion
};

@interface FWKey : NSObject
@property(nonatomic, assign)FWBackStyle backStyle;
@property(nonatomic, assign)NSInteger   foreStyle;
@property(nonatomic, assign)CGRect      viewRect;
@property(nonatomic, strong)NSString*   value;

- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end

@interface FWKeyboard : NSObject
@property(nonatomic, strong)NSArray *keyItems;
-(instancetype)initWithKeyboardPath:(NSString*)path;
@end


@interface FWTextKeyboard : FWKeyboard
@property(nonatomic, strong)NSArray *categoryItems; //@[@"开心",@"最近"]
@property(nonatomic, strong)NSArray *contentItems;  //@[@[@"^_^",@"^_^",@"^_^"],@[@"^_^",@"^_^",@"^_^"]]
@end

@interface FWEmotionKeyboard : FWKeyboard
@property(nonatomic, strong)NSArray *emotionItems;
@end


@interface FWKeyboardManager : NSObject
@property(nonatomic, assign)FWKeyboardType currentType;
@property(nonatomic, strong)FWKeyboard     *currentKeyboard;
- (void)changedKeyboard:(FWKeyboardType)keyboardType;

@property(nonatomic, weak) NSObject <UITextDocumentProxy> *textDocumentProxy;
@property(nonatomic, weak) UIInputViewController          *inputVC;
/////////////////////////////////////////////////////////////////////////
- (BOOL)handlerWithKey:(NSString*)keyValue;
@end
