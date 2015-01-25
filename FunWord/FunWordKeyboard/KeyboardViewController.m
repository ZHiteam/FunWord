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
#import "FWHintView.h"
#import "UIView+FETouchBlocks.h"

#define kDefaultCell        @"DefaultCell"
#define kDefaultKeyView     @"DefaultKeyView"

@interface KeyboardViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView     *collectionView;
@property(nonatomic,strong)FWKeyboardLayout     *keyboardLayout;
@property(nonatomic,strong)FWKeyboardManager    *keyboardManager;
@property(nonatomic,strong)UIView               *landBackView;
@property(nonatomic,strong)NSTimer              *timer;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    // Add custom view sizing constraints here
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
    self.landBackView.frame   = self.view.bounds;
    if([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height){
        //Keyboard is in Portrait
        self.landBackView.hidden = YES;
        self.collectionView.hidden = NO;
    }
    else{
        //Keyboard is in Landscape
        self.landBackView.hidden = NO;
        self.collectionView.hidden = YES;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.landBackView];
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

- (UIView *)landBackView{
    if (_landBackView == nil) {
        _landBackView = [[UIView alloc] initWithFrame:self.view.bounds];
        _landBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pattern"]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @" 横屏模式暂未支持，敬请期待后续更新。";
        [_landBackView addSubview:label];
    }
    return _landBackView;
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

- (void)handleDeleteBackward{
    [self.textDocumentProxy deleteBackward];
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
        
        __weak typeof(self)       weakSelf = self;
        __weak typeof(keyView) weakKeyView = keyView;
        [keyView touchBeganBlock:^(NSSet *touches, UIEvent *event) {
            if ([weakSelf.keyboardManager  isDeleteBackKey:weakKeyView.keyValue]) {
                [weakSelf handleDeleteBackward];
                weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(handleDeleteBackward) userInfo:nil repeats:YES];
            }
            //CGPoint pt = CGPointMake(CGRectGetMidX(weakKeyView.frame), CGRectGetMidY(weakKeyView.frame));
            //[FWHintView showInView:[weakSelf.view window] style:FWHintViewType1 point:pt text:keyView.keyValue];
        }];
        [keyView touchCancelledBlock:^(NSSet *touches, UIEvent *event) {
            //[FWHintView dismiss];
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
        }];
        [keyView touchEndedBlock:^(NSSet *touches, UIEvent *event) {
            //[FWHintView dismiss];
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
        }];
        return keyView;
    }
    return nil;
}


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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self handleKeyInput:[((FWKeyView*)cell) keyValue]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[FWKeyView class]]) {
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
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
