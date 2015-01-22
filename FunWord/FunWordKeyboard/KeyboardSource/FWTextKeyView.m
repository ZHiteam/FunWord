//
//  FWTextKeyView.m
//  
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "FWTextKeyView.h"
#import "HMSegmentedControl.h"
#import "FWTextKeyViewCell.h"

#define RGBA(r, g, b, a)   [UIColor colorWithRed : r / 255.0f green : g / 255.0f blue : b / 255.0f alpha : a]
#define RGB(r, g, b)        RGBA(r, g, b, 1.0f)
#define ObjectAtIndex(array,index) (index>=0 && index<[array count]) ? [array objectAtIndex:index] : nil

@interface FWTextKeyView ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)HMSegmentedControl *segmentedControl;
@property(nonatomic, strong)UITableView        *tableView;
@property(nonatomic, strong)NSArray            *categoryItems;
@property(nonatomic, assign)NSInteger           currentSeleted;
@property (strong, nonatomic)UIView            *seperateLine;
@end

@implementation FWTextKeyView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(234, 234, 234);
        [self addSubview:self.segmentedControl];
        [self addSubview:self.seperateLine];
        [self addSubview:self.tableView];
        [self.tableView registerNib:[UINib nibWithNibName:@"FWTextKeyViewCell" bundle:nil] forCellReuseIdentifier:@"FWTextKeyViewCell"];

    }
    return self;
}

+ (NSString *)reuseIdentifier{
    return NSStringFromClass([self class]);
}

- (void)setKeyboard:(FWTextKeyboard *)keyboard{
    if (_keyboard != keyboard && [keyboard isKindOfClass:[FWTextKeyboard class]]) {
        _keyboard  = keyboard;
        [self updateData];
    }
}

#pragma Getter & Setter

- (HMSegmentedControl *)segmentedControl{
    if (_segmentedControl == nil) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"最近"]];
        _segmentedControl.frame = CGRectMake(0, 0,self.bounds.size.width, 34);
        _segmentedControl.font = [UIFont systemFontOfSize:16.0];
        _segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _segmentedControl.backgroundColor = RGB(220, 213, 207);
        _segmentedControl.textColor = RGB(117, 79, 46);//[RGB(117, 79, 46) colorWithAlphaComponent:0.7];
        _segmentedControl.selectedTextColor = RGB(117, 79, 46);
        _segmentedControl.selectionIndicatorColor = RGB(234, 234, 234);
        _segmentedControl.selectionIndicatorBoxOpacity = 1.0;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
        _segmentedControl.selectionStyle    =  HMSegmentedControlSelectionStyleBox;
        _segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
        [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.segmentedControl.frame.size.height+1, self.bounds.size.width, self.bounds.size.height - self.segmentedControl.frame.size.height)];
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
        _seperateLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.segmentedControl.frame.size.height, self.frame.size.width, 0.5)];
        _seperateLine.backgroundColor = [UIColor colorWithRed:174/255.0 green:150/255.0 blue:126/255.0 alpha:1.0];
    }
    return _seperateLine;
}

#pragma mark - Privte
- (void)updateData{
    self.currentSeleted = 0;
    self.categoryItems  = self.keyboard.categoryItems;
    self.segmentedControl.sectionTitles = self.categoryItems;
    [self.tableView reloadData];
}


#pragma mark - Event Handler
- (void)segmentedControlChangedValue:(HMSegmentedControl*)segmentedControl{
    self.currentSeleted = segmentedControl.selectedSegmentIndex;
    [self.tableView reloadData];
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 10, 10) animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.keyboard.contentItems objectAtIndex:self.currentSeleted] count]/4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"FWTextKeyViewCell";
    
    FWTextKeyViewCell *cell = (FWTextKeyViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.handleBlock = self.handleBlock;
    NSArray *contents  = [self.keyboard.contentItems objectAtIndex:self.currentSeleted];
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
    return cell;
}

#pragma mark -  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
