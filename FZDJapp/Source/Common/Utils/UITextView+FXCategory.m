//
//  UITextView+FXCategory.m
//  FZDJapp
//
//  Created by smj on 2019/1/15.
//  Copyright © 2019 FZDJ. All rights reserved.
//

#import "UITextView+FXCategory.h"
#import <objc/runtime.h>
static const void *fx_placeHolderKey;

@interface UITextView ()
@property (nonatomic, readonly) UILabel *fx_placeHolderLabel;
@end

@implementation UITextView (FXCategory)

+(void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(fxPlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(fxPlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(fxPlaceHolder_swizzled_setText:)));
}

#pragma mark - swizzled
- (void)fxPlaceHolder_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self fxPlaceHolder_swizzled_dealloc];
}

- (void)fxPlaceHolder_swizzling_layoutSubviews {
    if (self.fx_placeHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.fx_placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.fx_placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self fxPlaceHolder_swizzling_layoutSubviews];
}

- (void)fxPlaceHolder_swizzled_setText:(NSString *)text{
    [self fxPlaceHolder_swizzled_setText:text];
    if (self.fx_placeHolder) {
        [self updatePlaceHolder];
    }
}

#pragma mark - associated
-(NSString *)fx_placeHolder{
    return objc_getAssociatedObject(self, &fx_placeHolderKey);
}

-(void)setFx_placeHolder:(NSString *)fx_placeHolder{
    objc_setAssociatedObject(self, &fx_placeHolderKey, fx_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}

-(UIColor *)fx_placeHolderColor{
    return self.fx_placeHolderLabel.textColor;
}

-(void)setFx_placeHolderColor:(UIColor *)fx_placeHolderColor{
    self.fx_placeHolderLabel.textColor = fx_placeHolderColor;
}

-(NSString *)placeholder{
    return self.fx_placeHolder;
}

-(void)setPlaceholder:(NSString *)placeholder{
    self.fx_placeHolder = placeholder;
}

#pragma mark - update
- (void)updatePlaceHolder{
    if (self.text.length) {
        [self.fx_placeHolderLabel removeFromSuperview];
        return;
    }
    self.fx_placeHolderLabel.font = self.font?self.font:self.cacutDefaultFont;
    self.fx_placeHolderLabel.textAlignment = self.textAlignment;
    self.fx_placeHolderLabel.text = self.fx_placeHolder;
    [self insertSubview:self.fx_placeHolderLabel atIndex:0];
}

#pragma mark - lazzing
-(UILabel *)fx_placeHolderLabel{
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(fx_placeHolderLabel));
    if (!placeHolderLab) {
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(fx_placeHolderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}
- (UIFont *)cacutDefaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}
@end
