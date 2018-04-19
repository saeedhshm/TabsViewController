//
//  TabsView.h
//  iOS_Resuable_Project
//
//  Created by InterTeleco on 4/18/18.
//  Copyright © 2018 InterTeleco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabsView : UIView <UIScrollViewDelegate>
@property(strong,nonatomic) NSMutableArray *headerTitles;
@property(strong,nonatomic) NSMutableArray *viewControllers;
@property(strong, nonatomic) UIViewController *parentViewController;
@property(strong, nonatomic)IBInspectable UIColor *activeTabColor;
@property(strong, nonatomic)IBInspectable UIColor *titlesColor;
@property(strong, nonatomic)IBInspectable UIColor *bottomColor;
@property(nonatomic)IBInspectable BOOL isRTL;
//-(void)initViewControllers:(NSMutableArray *) uiviewControllers forUIViewController:(UIViewController *)parentVC;
@end
