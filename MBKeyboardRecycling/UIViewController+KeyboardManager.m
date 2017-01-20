//
//  UIViewController+KeyboardManager.m
//  MBKeyboardRecycling
//
//  Created by yindongbo on 17/1/19.
//  Copyright © 2017年 Nxin. All rights reserved.
//

#import "UIViewController+KeyboardManager.h"
#import <objc/runtime.h>

static char associatedTextFieldKey;

@implementation UIViewController (KeyboardManager)

 
- (void)mb_startKeyboardListening {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldBeginEditing:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldEndEditing:)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)setTextField:(UITextField *)textField {
    objc_setAssociatedObject(self, &associatedTextFieldKey, textField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITextField *)textField {
    return objc_getAssociatedObject(self, &associatedTextFieldKey);
}

#pragma mark - keyboardNot
//userInfo == {
//    UIKeyboardAnimationDurationUserInfoKey = "0.25";
//    UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 216}}";
//    UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 676}";
//    UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 676}";
//    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 568}, {320, 216}}";
//    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 568}, {320, 216}}";
//    UIKeyboardIsLocalUserInfoKey = 1;
//}
- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    CGFloat keyFrameHeight = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].size.height;
    
    UITextField *tempTextField = [self textField];
    if ([tempTextField.superview isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *superView = (UIScrollView *)tempTextField.superview;
        CGFloat tempTextFieldH = tempTextField.frame.origin.y + tempTextField.frame.size.height;
        CGFloat emptySpaceH = [UIScreen mainScreen].bounds.size.height - keyFrameHeight;
        [superView setContentOffset:CGPointMake(0, emptySpaceH - tempTextFieldH >0?0: tempTextFieldH - emptySpaceH + 5)];
    }
}

//userInfo == {
//    UIKeyboardAnimationCurveUserInfoKey = 7;
//    UIKeyboardAnimationDurationUserInfoKey = "0.25";
//    UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 0}}";
//    UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 568}";
//    UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 568}";
//    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 568}, {320, 0}}";
//    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 568}, {320, 0}}";
//    UIKeyboardIsLocalUserInfoKey = 1;
//}
- (void)keyboardWillHide:(NSNotification *)aNotification {
//    NSDictionary *userInfo = [aNotification userInfo];
//    NSLog(@"userInfo == %@", userInfo);
}

#pragma mark - noti
- (void)textFieldBeginEditing:(NSNotification *)aNotification {
    UITextField *editingText = (UITextField *)aNotification.object;
    [self setTextField:editingText];
}

- (void)textFieldEndEditing:(NSNotification *)aNotification {
}

- (void)textFieldDidChange:(NSNotification *)aNotification {
}
@end
