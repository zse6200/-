//
//  ActivityCell.m
//  豆瓣
//
//  Created by lanou3g on 16/6/17.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "ActivityCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

#import "DB_COLOR.h"


//左边距
#define kLeftSpace 10
//右边距
#define kRightSpace 10
//上边距
#define kTopSpace 10
//下边距
#define kBottomSpace

//标题高
#define kTitleHeight 30
//内容高
//计算文本高度

//控件间距 (水平)
#define kHSpace 10
//(垂直)
#define kVSpace 10
//感兴趣间距
#define kInterestHeight 15

//图标尺寸

#define kIconSize CGSizeMake(16,16)
//image尺寸
#define kActivityImageSize CGSizeMake(80,130)
//时间的label宽度
#define kTimeLabelWith [UIScreen mainScreen].bounds.size.width - kLeftSpace - kRightSpace - kIconSize.width - kHSpace * 2 - kActivityImageSize.width




@interface ActivityCell ()

@property (nonatomic,strong)UIImageView *activityImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *timeImageView;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *addressImageView;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UIImageView *typeImageView;
@property(nonatomic,strong)UILabel *typeLbael;
@property(nonatomic,strong)UILabel *interesterLabel;
@property(nonatomic,strong)UILabel *activityLabel;

@end
@implementation ActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllSubViews];
    }
    return self;
}
//添加控件
- (void)addAllSubViews {
    //添加一个背景视图
    UIView *backView = [UIView new];
//    backView.backgroundColor = DB_RANDOM_COLOR;
    backView.backgroundColor = [UIColor whiteColor];
    __weak typeof(ActivityCell) *cell = self;
    //将
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        //添加约束
        make.top.equalTo(cell.contentView);
        make.bottom.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView);
    }];
    
    
    
   self.titleLabel = [UILabel new];
//    _titleLabel.backgroundColor = [UIColor orangeColor];
    [backView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(kTopSpace);
        make.left.equalTo(backView).offset(kLeftSpace);
        make.right.equalTo(backView).offset(-kRightSpace);
        make.height.mas_equalTo(kTitleHeight);
        
        
    }];
    
    self.activityImage =[[UIImageView alloc] init];
//    _activityImage.backgroundColor =  [UIColor redColor];
    
    [backView addSubview:_activityImage];
    
    [_activityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(kVSpace);
        
        make.right.equalTo(backView).offset(-kRightSpace);
       make.size.mas_equalTo(kActivityImageSize);
        
        
    }];
    

    
    self.timeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_date.png"]];
//    self.timeImageView.backgroundColor = [UIColor purpleColor];
    
    [backView addSubview:_timeImageView];
    
    [_timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(kVSpace);
        make.left.equalTo(backView).offset(kLeftSpace);
        make.size.mas_equalTo(kIconSize);
    }];
    
    
   self.timeLabel = [UILabel new];
//    _timeLabel.backgroundColor = [UIColor greenColor];
    [backView addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(kVSpace);
        make.left.equalTo(_timeImageView.mas_right).offset(kHSpace);
        make.width.mas_equalTo(kTimeLabelWith);
        make.height.mas_equalTo(20);
        
    }];
    
   self.
    addressImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_spot"]];
//    _addressImageView.backgroundColor = [UIColor cyanColor];
    [backView addSubview:_addressImageView];
   
    
    [_addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeImageView.mas_bottom).offset(kVSpace);
        make.left.equalTo(backView).offset(kLeftSpace);
        make.size.mas_equalTo(kIconSize);
    }];
    
   self.addressLabel = [UILabel new];
    self.addressLabel.numberOfLines = 2;
    self.addressLabel.font = [UIFont systemFontOfSize:16.0];
//    _addressLabel.backgroundColor = [UIColor redColor];
    [backView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(kVSpace);
        make.left.equalTo(_addressImageView.mas_right).offset(kHSpace);
        make.width.mas_equalTo(kTimeLabelWith);
        //make.height.mas_equalTo(20);
        
        
        }];
    
    
    
  self.typeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_catalog"]];
//    _typeImageView.backgroundColor = [UIColor yellowColor];
    
    [backView addSubview:_typeImageView];
  
    [_typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressLabel.mas_bottom).offset(kVSpace);
        make.left.equalTo(backView).offset(kLeftSpace);
        make.size.mas_equalTo(kIconSize);
        
      }];
    
    self.typeLbael = [UILabel new];
//    _typeLbael.backgroundColor = [UIColor blueColor];
    [backView addSubview:_typeLbael];
    
    [_typeLbael mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressLabel.mas_bottom).offset(kVSpace);
        make.left.equalTo(_typeImageView.mas_right).offset(kLeftSpace);
       make.width.mas_equalTo(kTimeLabelWith);
        make.height.mas_equalTo(20);
        
    }];

        
  self.interesterLabel = [UILabel new];
//    _interesterLabel.backgroundColor = [UIColor redColor];
    [backView addSubview:_interesterLabel];
    [_interesterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_typeLbael.mas_bottom).offset(kVSpace);
        make.left.equalTo(backView).offset(kLeftSpace);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        
    }];
    self.activityLabel = [UILabel new];
//    _activityLabel.backgroundColor = [UIColor yellowColor];
    [backView addSubview:_activityLabel];
    
    [_activityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_typeLbael.mas_bottom).offset(kVSpace);
        make.right.equalTo(_activityImage.mas_left).offset(-kLeftSpace *3);
        make.width.mas_equalTo(100);
         make.height.mas_equalTo(20);
        
    }];
    
}
//
//@property (nonatomic, strong)NSString *title;
//
////感兴趣
//@property (nonatomic, strong)NSString *wisher_count;
//
////参加
//@property (nonatomic, strong)NSString *participant_count;
//
////分类名
//@property (nonatomic, strong)NSString *category_name;
//
////地址
//@property (nonatomic, strong)NSString *address;
//
////结束时间
//@property (nonatomic, strong)NSString *end_time;
//
////开始时间
//@property (nonatomic, strong)NSString *begin_time;
//
////图片地址
//@property (nonatomic, strong) NSString *image;
//




- (void)setActivity:(Activity *)activity {
    if (activity != _activity) {
        _activity = nil;
        _activity = activity;
        self.titleLabel.text = _activity.title;
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"感兴趣:200"];
        
        [AttributedStr addAttribute:NSFontAttributeName
         
                              value:[UIFont systemFontOfSize:15.0]
         
                              range:NSMakeRange(0, 7)];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor redColor]
         
                              range:NSMakeRange(4, 3)];
        self.interesterLabel.attributedText = AttributedStr;
        
        NSMutableAttributedString *AttaibutedStr1 = [[NSMutableAttributedString alloc] initWithString:@"参加:1000"];
        [AttaibutedStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(0, 7)];
       
        [AttaibutedStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, 4)];
        self.activityLabel.attributedText = AttaibutedStr1;
        
        
        NSString *typeStr = @"类型:";
        self.typeLbael.text =[typeStr stringByAppendingString:_activity.category_name];
        self.addressLabel.text = _activity.address;
        
        
        NSString *str = _activity.begin_time;
        NSString *stri = [str substringFromIndex:5];
        NSString *strin = [stri substringToIndex:11];
        NSString *str1 = _activity.end_time;
        NSString *stri1 = [str1 substringFromIndex:5];
        NSString *strin1 = [stri1 substringToIndex:11];
        self.timeLabel.text = [NSString stringWithFormat:@"%@%@%@",strin, @"--" , strin1];
        [self.activityImage sd_setImageWithURL:[NSURL URLWithString:_activity.image]];
        
    }
}



- (void)awakeFromNib {
    // Initialization code
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
