//
//  FWEmotionKeyView.m
//  
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "FWEmotionKeyView.h"
#import "FWEmotionKeyViewCell.h"
#import "UIImageView+WebCache.h"

#define RGBA(r, g, b, a)   [UIColor colorWithRed : r / 255.0f green : g / 255.0f blue : b / 255.0f alpha : a]
#define RGB(r, g, b)        RGBA(r, g, b, 1.0f)
#define ObjectAtIndex(array,index) (index>=0 && index<[array count]) ? [array objectAtIndex:index] : nil


@interface FWEmotionKeyView ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView        *tableView;
@property(nonatomic, strong)NSArray            *emotionItems;
@property(strong, nonatomic)UIView             *seperateLine;
@property(nonatomic, strong)UILabel                     *openAccessLabel;

@end

@implementation FWEmotionKeyView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(234, 234, 234);
        [self addSubview:self.tableView];
        [self addSubview:self.seperateLine];
        [self.tableView registerNib:[UINib nibWithNibName:@"FWEmotionKeyViewCell" bundle:nil] forCellReuseIdentifier:@"FWEmotionKeyViewCell"];
        if (![FWKeyboardManager isOpenAccessGranted]) {
            [self addSubview:self.openAccessLabel];
        }
    }
    return self;
}

+ (NSString *)reuseIdentifier{
    return NSStringFromClass([self class]);
}

- (void)setKeyboard:(FWEmotionKeyboard *)keyboard{
    if (_keyboard != keyboard && [keyboard isKindOfClass:[FWEmotionKeyboard class]]) {
        _keyboard  = keyboard;
        [self updateData];
    }
}

#pragma Getter & Setter
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 1)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(234, 234, 234);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _tableView;
}

- (UIView *)seperateLine{
    if (_seperateLine == nil) {
        _seperateLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        _seperateLine.backgroundColor = [UIColor colorWithRed:174/255.0 green:150/255.0 blue:126/255.0 alpha:1.0];
    }
    return _seperateLine;
}

- (UILabel *)openAccessLabel{
    if (_openAccessLabel == nil) {
        _openAccessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        _openAccessLabel.backgroundColor = [UIColor yellowColor];
        _openAccessLabel.numberOfLines = 0;
        _openAccessLabel.text = @"通过 设置>通用>键盘>呆萌输入法 中打开 完全访问 才可使用该功能";
    }
    return _openAccessLabel;
}

#pragma mark - Privte
- (void)updateData{
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [self.keyboard.emotionItems count];
    NSInteger row = count/4 + 1;
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"FWEmotionKeyViewCell";
    FWEmotionKeyViewCell *cell = (FWEmotionKeyViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.handleBlock = self.handleBlock;
    NSArray *contents  = self.keyboard.emotionItems;
    NSInteger index = indexPath.row * 4;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (ObjectAtIndex(contents,index)) {
        [array addObject:ObjectAtIndex(contents,index)];
    }
    if (ObjectAtIndex(contents,index+1)) {
        [array addObject:ObjectAtIndex(contents,index+1)];
    }
    if (ObjectAtIndex(contents,index+2)) {
        [array addObject:ObjectAtIndex(contents,index+2)];
    }
    if (ObjectAtIndex(contents,index+3)) {
        [array addObject:ObjectAtIndex(contents,index+3)];
    }
    [cell configureWithContents:array];
    NSArray *images  = self.keyboard.emotionImages;
    NSString*imageURL= ObjectAtIndex(images,index);
    if (imageURL) {
        [cell.imageView1 setImageWithURL:[NSURL URLWithString:imageURL]];
    }
    imageURL= ObjectAtIndex(images,index+1);
    if (imageURL) {
        [cell.imageView2 setImageWithURL:[NSURL URLWithString:imageURL]];
    }
    imageURL= ObjectAtIndex(images,index+2);
    if (imageURL) {
        [cell.imageView3 setImageWithURL:[NSURL URLWithString:imageURL]];
    }
    imageURL= ObjectAtIndex(images,index+3);
    if (imageURL) {
        [cell.imageView4 setImageWithURL:[NSURL URLWithString:imageURL]];
    }
    return cell;
}


#pragma mark -  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [FWEmotionKeyViewCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
