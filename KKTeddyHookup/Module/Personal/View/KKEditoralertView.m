//
//  XTEditoralertView.m
//  KKTeddyHookup
//
//  Created by WangJungang on 2018/10/22.
//  Copyright © 2018 KK. All rights reserved.
//

#import "KKEditoralertView.h"

@interface KKEditoralertView()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *submitBtn;
@end

@implementation KKEditoralertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        [self.editorText becomeFirstResponder];
        [self addSubview:self.alertView];
        [self addSubview:self.titleLab];
        [self addSubview:self.editorText];
        [self addSubview:self.line];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.submitBtn];
        [self setuplayout];
        [self showAnimation];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(124*KHEIGHT);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(20);
        make.height.mas_offset(200);
    }];
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.alertView).with.offset(20);
        make.top.equalTo(weakSelf.alertView).with.offset(27);
        make.centerX.equalTo(weakSelf);
    }];
    [weakSelf.editorText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf.titleLab);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(15);
        make.height.mas_offset(30);
    }];
    [weakSelf.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf.titleLab);
        make.top.equalTo(weakSelf.editorText.mas_bottom).with.offset(20);
        make.height.mas_offset(1);
    }];
    [weakSelf.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line.mas_bottom).with.offset(50);
        make.right.equalTo(weakSelf.line);
        make.height.mas_offset(20);
        make.width.mas_offset(68);
    }];
    [weakSelf.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line.mas_bottom).with.offset(50);
        make.right.equalTo(weakSelf.submitBtn.mas_left).with.offset(25);
        make.height.mas_offset(20);
        make.width.mas_offset(68);
    }];
}

-(UIView *)alertView
{
    if(!_alertView)
    {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius=3.0;
        _alertView.layer.masksToBounds=YES;
    }
    return _alertView;
}

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = [UIColor colorWithHexString:@"000000"];

    }
    return _titleLab;
}

-(UITextField *)editorText
{
    if(!_editorText)
    {
        _editorText = [[UITextField alloc] init];
        [_editorText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _editorText.delegate = self;
        _editorText.font = [UIFont systemFontOfSize:13];
    }
    return _editorText;
}
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.text.length > 30) {
        
        textField.text = [textField.text substringToIndex:30];
        
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //只能输入30字的第一步
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (toBeString.length > 30){
        
        return NO;
        
    }
    
    return YES;
    
}
-(UIView *)line
{
    if(!_line)
    {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"E6E6E6"];
    }
    return _line;
}

-(UIButton *)cancelBtn
{
    if(!_cancelBtn)
    {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn addTarget:self action:@selector(canclebtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"Cancel" forState:normal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn setTitleColor:MainColor forState:normal];
        _cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    }
    return _cancelBtn;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn addTarget:self action:@selector(submitbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitle:@"OK" forState:normal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_submitBtn setTitleColor:MainColor forState:normal];
        _submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _submitBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    }
    return _submitBtn;
}

-(void)canclebtnClick
{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)submitbtnClick
{
    if (self.replyClick) {
        self.replyClick(self.editorText.text);
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)withrepylClick:(replyBlock)block
{
    _replyClick = block;
    
}

#pragma mark - 实现方法

-(void)showAnimation{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.0f];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
       // self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

@end
