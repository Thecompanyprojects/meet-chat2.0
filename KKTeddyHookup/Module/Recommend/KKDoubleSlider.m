//
//  DoubleSlider.m
//  KKTeddyHookup
//
//  Created by YangShuai on 2018/10/25.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKDoubleSlider.h"


static const CGFloat sliderOffY = 5.0f;

@interface KKDoubleSlider ()
@property (nonatomic,assign)CGFloat CurrentMinNum;
@property (nonatomic,assign)CGFloat CurrentMaxNum;
@property (nonatomic,assign)CGFloat totalcol;
@end

@implementation KKDoubleSlider

{
    
    UIView *_minSliderLine;
    UIView *_maxSliderLine;
    UIView *_mainSliderLine;

    CGFloat _constOffY;
    
    CGFloat _tatol;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        if (frame.size.height < 80.0f) {
            self.xy_height = 80.0f;
        }
        [self createMainView];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    if (self.frame.size.height < 80.0f) {
        self.xy_height = 80.0f;
    }
    [self createMainView];
}
- (void)createMainView
{
//    _minLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.xy_width/2.0f, 40)];
//    _maxLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.xy_width/2.0f, 10 ,self.xy_width/2.0f , 40)];
//    _minLabel.textAlignment = NSTextAlignmentLeft;
//    _maxLabel.textAlignment = NSTextAlignmentRight;
//    _minLabel.adjustsFontSizeToFitWidth = YES;
//    _maxLabel.adjustsFontSizeToFitWidth = YES;
//    [self addSubview:_minLabel];
//    [self addSubview:_maxLabel];
    
    self.minNum = 0.0;
    self.maxNum = 0.0;
    self.unit = @"";

    _mainSliderLine = [[UIView alloc]initWithFrame:CGRectMake(10,15, self.xy_width-20, 3)];
    _mainSliderLine.backgroundColor = [UIColor darkGrayColor];
    _mainSliderLine.layer.cornerRadius = _mainSliderLine.xy_height/2.0;
    [self addSubview:_mainSliderLine];
    
    _minSliderLine = [[UIView alloc]initWithFrame:CGRectMake(10,_mainSliderLine.xy_y, 0, _mainSliderLine.xy_height)];
    _minSliderLine.backgroundColor = [UIColor redColor];
    _minSliderLine.layer.cornerRadius = _minSliderLine.xy_height/2.0;
    [self addSubview:_minSliderLine];
    
    _maxSliderLine = [[UIView alloc]initWithFrame:CGRectMake(self.xy_width-10, _mainSliderLine.xy_y, 0, _mainSliderLine.xy_height)];
    _maxSliderLine.layer.cornerRadius = _maxSliderLine.xy_height/2.0;
    _maxSliderLine.backgroundColor = [UIColor redColor];
    [self addSubview:_maxSliderLine];
    
    UIButton *minSliderButton = [[UIButton alloc]initWithFrame:CGRectMake(0,sliderOffY, 20, 20)];
    minSliderButton.backgroundColor = [UIColor whiteColor];
    minSliderButton.showsTouchWhenHighlighted = YES;
    minSliderButton.layer.cornerRadius = minSliderButton.xy_width/2.0f;
    minSliderButton.layer.masksToBounds = YES;
    minSliderButton.layer.borderColor = MainColor.CGColor;
    minSliderButton.layer.borderWidth = 1.0;
    [minSliderButton setHitTestEdgeInsets:UIEdgeInsetsMake(-20, -20, -20, -20)];
    UIPanGestureRecognizer *minSliderButtonPanGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMinSliderButton:)];
    [minSliderButton addGestureRecognizer:minSliderButtonPanGestureRecognizer];
    [self addSubview:minSliderButton];
    _minSlider = minSliderButton;
    
    
    UIButton *maxSliderButton = [[UIButton alloc]initWithFrame:CGRectMake(self.xy_width-20, sliderOffY, 20, 20)];
    maxSliderButton.backgroundColor = [UIColor whiteColor];
    maxSliderButton.showsTouchWhenHighlighted = YES;
    maxSliderButton.layer.cornerRadius = minSliderButton.xy_width/2.0f;
    maxSliderButton.layer.masksToBounds = YES;
    maxSliderButton.layer.borderColor = MainColor.CGColor;
    maxSliderButton.layer.borderWidth = 1.0;
    [maxSliderButton setHitTestEdgeInsets:UIEdgeInsetsMake(-20, -20, -20, -20)];
    UIPanGestureRecognizer *maxSliderButtonPanGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMaxSliderButton:)];
    [maxSliderButton addGestureRecognizer:maxSliderButtonPanGestureRecognizer];
    [self addSubview:maxSliderButton];
    _maxSlider = maxSliderButton;
    _constOffY = _minSlider.xy_centerY;
    
    
}

- (void)panMinSliderButton:(UIPanGestureRecognizer *)pgr
{
    CGPoint point = [pgr translationInView:self];
    static CGPoint center;
    if (pgr.state == UIGestureRecognizerStateBegan) {
        center = pgr.view.center;
    }
    pgr.view.center = CGPointMake(center.x + point.x, center.y + point.y);
    pgr.view.xy_centerY = _constOffY;
    
   
    if (pgr.view.right > _maxSlider.xy_x) {
        pgr.view.right = _maxSlider.xy_x;
    }else{
        if (pgr.view.xy_centerX < 10) {
            pgr.view.xy_centerX = 10;
        }
        if (pgr.view.xy_centerX > self.xy_width-10) {
            pgr.view.xy_centerX = self.xy_width-10;
        }
    }
    
    
    if (pgr.state == UIGestureRecognizerStateEnded) {
        
        
        double col = (pgr.view.right-20)/_totalcol;
        double  xs = col - floor(col);
        int min = floor(col);
        
        if (xs<=0.5) {
            pgr.view.xy_right = _totalcol*min+20;
        }else{
            
            pgr.view.xy_right = _totalcol*(min+1)+20;
        }
        
        if (pgr.view.right > _maxSlider.xy_x) {
            pgr.view.right = _maxSlider.xy_x;
        }else{
            if (pgr.view.xy_centerX < 10) {
                pgr.view.xy_centerX = 10;
            }
            if (pgr.view.xy_centerX > self.xy_width-10) {
                pgr.view.xy_centerX = self.xy_width-10;
            }
        }
        
        
    }
    

    
    _minSliderLine.frame = CGRectMake(_minSliderLine.xy_x, _minSliderLine.xy_y,  pgr.view.xy_centerX-_minSliderLine.xy_x, _minSliderLine.xy_height);
    [self valueMinChange:pgr.view.right];
}

- (void)panMaxSliderButton:(UIPanGestureRecognizer *)pgr
{
    CGPoint point = [pgr translationInView:self];
    static CGPoint center;
    if (pgr.state == UIGestureRecognizerStateBegan) {
        center = pgr.view.center;
    }
    pgr.view.center = CGPointMake(center.x + point.x, center.y + point.y);
    pgr.view.xy_centerY = _constOffY;
    
   
    if (pgr.view.xy_x < _minSlider.right) {
        pgr.view.xy_x = _minSlider.right;
    }else{
        if (pgr.view.xy_centerX < 10) {
            pgr.view.xy_centerX = 10;
        }
        if (pgr.view.xy_centerX > self.xy_width-10) {
            pgr.view.xy_centerX = self.xy_width-10;
        }
    }
    
    if (pgr.state == UIGestureRecognizerStateEnded) {
        
        double col = (pgr.view.xy_x-20)/_totalcol;
        double  xs = col - floor(col);
        int min = floor(col);
        
        if (xs>=0.5) {
            pgr.view.xy_x = _totalcol*(min+1)+20;
        }else{
            
            pgr.view.xy_x = _totalcol*min+20;
        }
        
        if (pgr.view.xy_x < _minSlider.right) {
            pgr.view.xy_x = _minSlider.right;
        }else{
            if (pgr.view.xy_centerX < 10) {
                pgr.view.xy_centerX = 10;
            }
            if (pgr.view.xy_centerX > self.xy_width-10) {
                pgr.view.xy_centerX = self.xy_width-10;
            }
        }
        
    }
   

    _maxSliderLine.frame = CGRectMake(pgr.view.xy_centerX, _maxSliderLine.xy_y, self.xy_width-pgr.view.xy_centerX-10, _maxSliderLine.xy_height);
    [self valueMaxChange:pgr.view.xy_x];
}

- (void)valueMinChange:(CGFloat)num
{
    _minLabel.text = [NSString stringWithFormat:@"%.3f%@",_minNum + (_tatol * (num-20.0)),_unit];
    _currentMinValue = _minNum + (_tatol * (num-20.0));
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderValueChange:)]) {
        [self.delegate sliderValueChange:self];
    }
}

- (void)valueMaxChange:(CGFloat)num
{
    _maxLabel.text = [NSString stringWithFormat:@"%.3f%@",_minNum +(_tatol * (num-20.0)),_unit];
    _currentMaxValue = _minNum +(_tatol * (num-20.0));
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderValueChange:)]) {
        [self.delegate sliderValueChange:self];
    }
}
-(void)setMinNum:(CGFloat)minNum
{
    _minNum = minNum;
    _tatol = (_maxNum - _minNum)/(self.xy_width - 40.0f);
    _totalcol = (self.xy_width - 40.0f)/(_maxNum - _minNum);
    if (_tatol < 0) {
        _tatol = -_tatol;
    }
    _minLabel.text = [NSString stringWithFormat:@"%.3f%@",minNum,_unit];
    _currentMinValue = minNum;
}

-(void)setMaxNum:(CGFloat)maxNum
{
    _maxNum = maxNum;
    _tatol = (_maxNum - _minNum)/(self.xy_width - 40.0f);
    _totalcol = (self.xy_width - 40.0f)/(_maxNum - _minNum);

    if (_tatol < 0) {
        _tatol = -_tatol;
    }
    _maxLabel.text = [NSString stringWithFormat:@"%.3f%@",maxNum,_unit];
    _currentMaxValue = maxNum;
}



-(void)setMinTintColor:(UIColor *)minTintColor
{
    _minTintColor = minTintColor;
    _minSliderLine.backgroundColor = minTintColor;
}

-(void)setMaxTintColor:(UIColor *)maxTintColor
{
    _maxTintColor = maxTintColor;
    _maxSliderLine.backgroundColor = maxTintColor;
}

-(void)setMainTintColor:(UIColor *)mainTintColor
{
    _mainTintColor = mainTintColor;
    _mainSliderLine.backgroundColor = mainTintColor;
}

-(void)setUnit:(NSString *)unit
{
    _unit = unit;
}

@end
