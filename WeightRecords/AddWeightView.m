//
//  AddWeightView.m
//  WeightRecords
//
//  Created by lt on 16/11/22.
//  Copyright © 2016年 lt. All rights reserved.
//

#import "AddWeightView.h"
#import "SQLManager.h"

@interface AddWeightView ()

@property (nonatomic, strong) UIButton *dismisBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UITextField *weightField;     /**< 记录体重的field */

@property (nonatomic, strong) NSString *dateStr;

@property (nonatomic, strong) NSString *weightStr;

@end

@implementation AddWeightView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.dismisBtn];
        [self addSubview:self.confirmBtn];
        [self addSubview:self.weightField];
        [self addSubview:self.datePicker];
    }
    return self;
}


- (void)show
{
    
    self.alpha = 0;

    
    [UIView animateWithDuration:.3f animations:^{
        
        self.alpha = 0.95;
    }completion:^(BOOL finished){
        
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:.3f animations:^{
        
        self.alpha = 0;
    }completion:^(BOOL finished){
        
        [self removeFromSuperview];
    }];
}

- (void)confirm
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    self.dateStr = [formatter stringFromDate:self.datePicker.date];
    
    self.weightStr = self.weightField.text;
    if ([self.weightStr isEqualToString:@""] || !self.weightStr)
    {
        self.weightStr = @"0";
    }
    
    [SQLManager addWeight:self.weightStr date:self.dateStr name:@""];
    
    [self.delegate redrawChart];
    [self dismiss];
    
    NSMutableString *father = [NSMutableString stringWithString:@"123"];
    NSMutableString *son = [father mutableCopy];
    [son appendString:@"added"];
    NSLog(@"%@",son);
}

#pragma mark - delegate

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //点击屏幕的时候就结束编辑，方便又快捷
    [self endEditing:YES];//结束编辑
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:textField.text];
    [str insertString:string atIndex:range.location];
    
    NSInteger flag = 0;
    NSInteger limited = 1;      // 小数点后面限制的位数
    BOOL hasPoint = NO;         // 判断是否已经输入了点
    
//    for (NSInteger i = 0; i < str.length; i++)
//    {
//        if ([str characterAtIndex:i] == '.')
//        {
//            // 如果已经有一个点了 就返回NO  如果没有 则继续走 把hasPoint设置为YES
//            if (hasPoint == YES)
//            {
//                return NO;
//            }
//            hasPoint = YES;
//        }
//    }
    
    for (int i = (int)(str.length - 1); i >= 0; i--)
    {
        if ([str characterAtIndex:i] == '.')
        {
            // 如果已经有一个点了 就返回NO  如果没有 则继续走 把hasPoint设置为YES
            if (hasPoint == YES)
            {
                return NO;
            }
            hasPoint = YES;
            
            if (flag > limited)
            {
                return NO;
            }
            
//            break;
        }else
        {
            flag ++;
        }
 
    }
    
    NSLog(@"YES");
    return YES;
}

#pragma mark - Lazy

- (UIButton *)dismisBtn
{
    if (!_dismisBtn)
    {
        _dismisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismisBtn.frame = CGRectMake(10, 30, 50, 30);
        [_dismisBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_dismisBtn setTitleColor:[UIColor flatRedColor] forState:UIControlStateNormal];
        [_dismisBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismisBtn;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn)
    {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 30, 50, 30);
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor flatRedColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UITextField *)weightField
{
    if (!_weightField)
    {
        UIColor *color = [UIColor flatRedColor];
        
        _weightField = [[UITextField alloc] initWithFrame:CGRectMake(10, 280, 200, 60)];
        _weightField.centerX = self.width / 2;
        _weightField.font = [UIFont systemFontOfSize:25];
        _weightField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"0" attributes:@{NSForegroundColorAttributeName: color}];
        _weightField.keyboardType = UIKeyboardTypeDecimalPad;
        _weightField.keyboardAppearance = UIKeyboardAppearanceAlert;
        _weightField.borderStyle = UITextBorderStyleRoundedRect;
//        _weightField.clearButtonMode = UITextFieldViewModeAlways;
        _weightField.textAlignment = NSTextAlignmentCenter;
        _weightField.textColor = [UIColor flatRedColor];
        
        [[_weightField valueForKey:@"textInputTraits"] setValue:[UIColor clearColor] forKey:@"insertionPointColor"];
        
        _weightField.delegate = self;
    }
    return _weightField;
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 8, 60, SCREEN_WIDTH * 3 / 4, 200)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [NSLocale currentLocale];
        _datePicker.maximumDate = [NSDate date];
    }
    return _datePicker;
}

@end
