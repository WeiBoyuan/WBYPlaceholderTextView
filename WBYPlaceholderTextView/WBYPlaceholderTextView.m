//
//  WBYPlaceholderTextView.m
//  WBYPlaceholderProject
//
//  Created by weiboyuan on 2016/11/25.
//  Copyright © 2016年 CAE. All rights reserved.
//

#import "WBYPlaceholderTextView.h"
@interface WBYPlaceholderTextView ()

@property (nonatomic, strong) UIColor* scanTextColor;
@property (nonatomic, strong) NSString* scanText;

-(void)beginEditing:(NSNotification*) notification;
-(void)endEditing:(NSNotification*) notification;

@end

@implementation WBYPlaceholderTextView
- (id) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    
    self.scanTextColor = [UIColor blackColor];
}

- (void) setPlaceholder:(NSString *)aPlaceholder
{
    if ([self.scanText isEqualToString:self.placeholder])
    {
        self.text = aPlaceholder;
    }
    _placeholder = aPlaceholder;
    [self endEditing:nil];
}

- (NSString *)text
{
    NSString* text = [super text];
    if ([text isEqualToString:self.placeholder]) return @"";
    return text;
}

- (void)setText:(NSString *)text {
    if ([text isEqualToString:@""] || text == nil)
    {
        super.text = self.placeholder;
    }
    else
    {
        super.text = text;
    }
    
    if ([text isEqualToString:self.placeholder])
    {
        self.textColor = [UIColor lightGrayColor];
    }
    else
    {
        self.textColor = self.scanTextColor;
    }
}

- (NSString *)scanText
{
    return [super text];
}

- (void)setTextColor:(UIColor *)textColor
{
    if ([self.scanText isEqualToString:self.placeholder])
    {
        if ([textColor isEqual:[UIColor lightGrayColor]]) [super setTextColor:textColor];
        else self.scanTextColor = textColor;
    }
    else
    {
        self.scanTextColor = textColor;
        [super setTextColor:textColor];
    }
}
- (void)beginEditing:(NSNotification*) notification
{
    if ([self.scanText isEqualToString:self.placeholder])
    {
        super.text = nil;
        self.textColor = self.scanTextColor;
    }
}

- (void)endEditing:(NSNotification*) notification
{
    if ([self.scanText isEqualToString:@""] || self.scanText == nil)
    {
        super.text = self.placeholder;
        self.textColor = [UIColor lightGrayColor];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
