//
//  WordCell.m
//  FunWord
//
//  Created by elvis on 15/1/20.
//  Copyright (c) 2015年 funword. All rights reserved.
//

#import "WordCell.h"

#define TEXT_HEIGHT 36

@interface WordCell()
@property (nonatomic,strong) UILabel*   text;
@property (nonatomic,strong) UIImageView*   imageBGView;
@property (nonatomic,strong) UIButton*      favorite;
@property (nonatomic,retain) WordModel* model;
@end

@implementation WordCell

-(instancetype)initWithWidth:(CGFloat)width reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self){
        self.width = width;
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.text];
        [self.contentView addSubview:self.imageBGView];
        [self.contentView addSubview:self.favorite];

        [self.contentView bringSubviewToFront:self.text];
    }
    
    return self;
}

-(void)relaodWidthModel:(WordModel*)model{
    self.model = model;
    self.text.text = model.richWord;
    self.favorite.selected = [model.favorite boolValue];
}

-(UILabel *)text{
    
    if (!_text) {
        _text = [[UILabel alloc]initWithFrame:CGRectMake(20, ([WordCell cellHeight]-TEXT_HEIGHT)/2, self.width-20-20-40-20, TEXT_HEIGHT)];
//        _text.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"text_bg"]];
        _text.backgroundColor = [UIColor clearColor];
        _text.textColor = FERGB(0x75, 0x49, 0x15, 1);
        _text.textAlignment = NSTextAlignmentCenter;
    }
    
    return _text;
}

-(UIButton *)favorite{
    
    if (!_favorite) {
        _favorite = [[UIButton alloc]initWithFrame:CGRectMake(self.text.right+20, self.text.top, TEXT_HEIGHT, TEXT_HEIGHT)];
        [_favorite setImage:[UIImage imageNamed:@"bt_love_off"] forState:UIControlStateNormal];
        [_favorite setImage:[UIImage imageNamed:@"bt_love_on"] forState:UIControlStateHighlighted];
        [_favorite setImage:[UIImage imageNamed:@"bt_love_on"] forState:UIControlStateSelected];
        [_favorite addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _favorite;
}

-(UIImageView *)imageBGView{
    
    if (!_imageBGView) {
        _imageBGView = [[UIImageView alloc]initWithFrame:self.text.frame];
        _imageBGView.image = [UIImage imageNamed:@"text_bg"];
    }
    
    return _imageBGView;
}

-(void)favoriteAction{
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithCapacity:2];
    [dic setObject:@"" forKey:@"userId"];
    if (self.model.wordId) {
        [dic setObject:self.model.wordId forKey:@"wordId"];
    }
    if (self.favorite.selected) {
        [dic setObject:@"1" forKey:@"opt"];
    }
    else{
        [dic setObject:@"0" forKey:@"opt"];
    }
    
    [HttpClient requestDataWithPath:@"/api/font/sendFavoriteFont" paramers:dic success:^(id responseObject) {
        self.favorite.selected = !self.favorite.selected;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

+(CGFloat)cellHeight{
    return 56;
}
@end
