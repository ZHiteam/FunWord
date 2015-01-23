//
//  KeyboardViewController.m
//  FunWordKeyboard
//
//  Created by admin on 14-12-21.
//  Copyright (c) 2014年 funword. All rights reserved.
//

#import "KeyboardViewController.h"
#import "FWKeyboardLayout.h"
#import "FWKeyView.h"
#import "FWKeyboardManager.h"
#import "FWTextKeyView.h"
#import "FWEmotionKeyView.h"

#define kDefaultCell        @"DefaultCell"
#define kDefaultKeyView     @"DefaultKeyView"

@interface KeyboardViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView     *collectionView;
@property(nonatomic,strong)FWKeyboardLayout     *keyboardLayout;
@property(nonatomic,strong)FWKeyboardManager    *keyboardManager;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //solved oritation
//    [self updateFont];
//    
//    // animating somehow reduces some jerkiness
//    [UIView animateWithDuration:0.0 delay:0.0 options:0 animations:^{
//        [self layoutViewForSize:self.view.frame.size];
//    } completion:^(BOOL finished) {}];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    self.keyboardManager = [[FWKeyboardManager alloc] init];
    self.keyboardManager.inputVC = self;
    self.keyboardManager.textDocumentProxy = self.textDocumentProxy;
    [self changeKeyboard:FWKeyboardNum26];
    
    [self.collectionView registerClass:[FWKeyView class]        forCellWithReuseIdentifier:[FWKeyView reuseIdentifier]];
    [self.collectionView registerClass:[FWTextKeyView class]    forCellWithReuseIdentifier:[FWTextKeyView reuseIdentifier]];
    [self.collectionView registerClass:[FWEmotionKeyView class] forCellWithReuseIdentifier:[FWEmotionKeyView reuseIdentifier]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kDefaultCell];
    [self.collectionView reloadData];
}


#pragma mark - Getter & Setter
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0,0 , 320, 216) collectionViewLayout:self.keyboardLayout];
        _collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pattern"]];
        _collectionView.delegate      = self;
        _collectionView.dataSource    = self;
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

- (FWKeyboardLayout *)keyboardLayout{
    if (_keyboardLayout == nil) {
        _keyboardLayout = [[FWKeyboardLayout alloc] init];
    }
    return _keyboardLayout;
}

#pragma mark - Privte
- (void)changeKeyboard:(FWKeyboardType)keyboardType{
    [self.keyboardManager changedKeyboard:keyboardType];
    self.keyboardLayout.keyItems = self.keyboardManager.currentKeyboard.keyItems;
}

- (void)handleKeyInput:(NSString*)keyValue{
    BOOL result = [self.keyboardManager handlerWithKey:keyValue];
    if (result) {
        self.keyboardLayout.keyItems = self.keyboardManager.currentKeyboard.keyItems;
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.keyboardManager.currentKeyboard.keyItems count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FWKey *key = [self.keyboardManager.currentKeyboard.keyItems objectAtIndex:indexPath.row];
    if ([key.value isEqualToString:@"FF"]) {
        FWTextKeyView *keyView = [collectionView dequeueReusableCellWithReuseIdentifier:[FWTextKeyView reuseIdentifier] forIndexPath:indexPath];
        keyView.keyboard = (FWTextKeyboard*)self.keyboardManager.currentKeyboard;
        __weak typeof(self) weakSelf = self;
        keyView.handleBlock= ^(NSString* keyValue){
            [weakSelf handleKeyInput:keyValue];
        };
        return keyView;
    } else if ([key.value isEqualToString:@"FE"]) {
        FWEmotionKeyView *keyView = [collectionView dequeueReusableCellWithReuseIdentifier:[FWEmotionKeyView reuseIdentifier] forIndexPath:indexPath];
        keyView.keyboard = (FWEmotionKeyboard*)self.keyboardManager.currentKeyboard;
        __weak typeof(self) weakSelf = self;
        keyView.handleBlock= ^(NSString* keyValue){
            [weakSelf handleKeyInput:keyValue];
        };
        return keyView;
    } else {
        FWKeyView *keyView  = [collectionView dequeueReusableCellWithReuseIdentifier:[FWKeyView reuseIdentifier] forIndexPath:indexPath];
        [keyView setBackStyle:key.backStyle];
        [keyView setShowText:key.value];
        return keyView;
    }
    return nil;
}

/*
 -(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
 return CGSizeMake(30,30);
 }
 */

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[FWKeyView class]]) {
        [self handleKeyInput:[((FWKeyView*)cell) keyValue]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    //UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //cell.backgroundColor = [UIColor orangeColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    //[self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
