//
//  ViewController.m
//  Eagle
//
//  Created by markcj on 2019/11/8.
//  Copyright © 2019 Mark Chen. All rights reserved.
//

#import "ViewController.h"
#include "MCJEagleDefinitions.h"

@interface ViewController ()

// Eagle
@property (weak, nonatomic) IBOutlet UIView *viewTouch;
@property (weak, nonatomic) IBOutlet UILabel *lblE;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addGestureRecognizer];
}

- (void)dealloc {
    
}

#pragma mark - View Gesture Event
- (void)addGestureRecognizer {
    // View点击、滑动事件响应
    self.view.userInteractionEnabled = YES;
    // 点击
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidClicked:)];
    [self.viewTouch addGestureRecognizer:tapGesture];
    
    // 滑动
    UISwipeGestureRecognizer *swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidSwiped:)];
    [swipeDownGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.viewTouch addGestureRecognizer:swipeDownGesture];
    
    UISwipeGestureRecognizer *swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidSwiped:)];
    [swipeUpGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.viewTouch addGestureRecognizer:swipeUpGesture];
    
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidSwiped:)];
    [swipeLeftGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.viewTouch addGestureRecognizer:swipeLeftGesture];
    
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidSwiped:)];
    [swipeRightGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.viewTouch addGestureRecognizer:swipeRightGesture];
}

- (void)viewDidClicked:(UITapGestureRecognizer *)recognizer {
    NSLog(@"点击View");
}

- (void)viewDidSwiped:(UISwipeGestureRecognizer *)recognizer {
    NSString *str = nil;
    UIFont *oldFont = self.lblE.font;
    UIFont *newFont = oldFont;
    
    int randomKey = arc4random()%3 + 1;
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionUp:
            str = @"向上";
            // 字体变小
            oldFont = self.lblE.font;
            CGFloat newFontSize = oldFont.pointSize - MCJFONT_SIZE_STEP > MCJMIN_FONT_SIZE ? oldFont.pointSize-MCJFONT_SIZE_STEP : oldFont.pointSize;
            newFont = [oldFont fontWithSize:newFontSize];
            break;
            
        case UISwipeGestureRecognizerDirectionLeft:
            str = @"向左";
            // 换相同大小的E，方向变一下
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            str = @"向右";
            // 换相同大小的E，方向变一下
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            str = @"向下";
            // 字体变大
            oldFont = self.lblE.font;
            newFontSize = oldFont.pointSize + MCJFONT_SIZE_STEP;
            if (newFontSize > MCJMAX_FONT_SIZE) {
                newFontSize = oldFont.pointSize;
            }
            newFont = [oldFont fontWithSize:newFontSize];
            break;
            
        default:
            break;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.lblE.font = newFont;
        self.lblE.transform = CGAffineTransformMakeRotation(M_PI_2 * randomKey);
    }];
    NSLog(@"滑动方向：%@", str);
}

@end
