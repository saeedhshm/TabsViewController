//
//  TabsView.m
//  iOS_Resuable_Project
//
//  Created by InterTeleco on 4/18/18.
//  Copyright © 2018 InterTeleco. All rights reserved.
//

#import "TabsView.h"

@implementation TabsView
{
    UIView *floatingBar;
    UIScrollView *scrollView;
    UIView *buttonsView ;
    NSMutableArray *buttons;
    CGFloat titlesCount;
    
    
}

-(void)awakeFromNib{
    [self setBackgroundColor:[UIColor redColor]];
    buttons = [[NSMutableArray alloc] init];
    //    [self.headerTitles addObject:@"third tab"];
//        self.isRTL = YES;
    [super awakeFromNib];
}
-(void)layoutSubviews{
    if (self.isRTL) {
        NSArray *titlesArray = [[self.headerTitles reverseObjectEnumerator] allObjects];
        NSArray *reversedVCs = [[self.viewControllers reverseObjectEnumerator] allObjects];
        self.viewControllers = [NSMutableArray arrayWithArray:reversedVCs];
        self.headerTitles = [NSMutableArray arrayWithArray:titlesArray];
    }
    titlesCount = (CGFloat)self.headerTitles.count;
    [self addHeaderButtons];
}

-(void)addHeaderButtons{
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, self.bounds.size.width, self.bounds.size.height-70)];
    
    CGFloat width = scrollView.bounds.size.width;
    
    CGFloat xPos = 0;
    if (self.isRTL) {
        xPos = width - (width/titlesCount);
    }
    
    floatingBar = [[UIView alloc] initWithFrame:CGRectMake(xPos, 68, self.bounds.size.width/titlesCount, 2)];
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, 69, self.bounds.size.width, 1)];
    [bottomBar setBackgroundColor:self.bottomColor];
    [floatingBar setBackgroundColor:self.activeTabColor];
    buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 70)];
    
    [buttonsView setBackgroundColor:[UIColor whiteColor]];
    //    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    int i = 0;
    
    
    for (NSString *str in self.headerTitles) {
        NSLog(@"----->>>> %f",(titlesCount-i-1));
        CGFloat currentI = i;
        if (self.isRTL) {
            currentI = (titlesCount-i-1);
        }
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.bounds.size.width/titlesCount)*currentI , 0, self.bounds.size.width/titlesCount, 70)];
        
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        button.titleLabel.numberOfLines = 2; // if you want unlimited number of lines put 0
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [button setTitle:str forState:UIControlStateNormal];
        UIColor *ttlColor = i == 0 ? self.activeTabColor : self.titlesColor;
        if (self.isRTL) {
            ttlColor = currentI == (titlesCount-1) ? self.activeTabColor : self.titlesColor;
        }
        [button setTitleColor:ttlColor forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self action:@selector(addActionToButton:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:button];
        [buttonsView addSubview:button];
        i++;
    }
    
    

    scrollView.delegate = self;
    [scrollView setBackgroundColor:[UIColor grayColor]];
    [scrollView setScrollEnabled:YES];
    [scrollView setPagingEnabled:true];
    [scrollView setBounces:false];
    [scrollView setShowsVerticalScrollIndicator:false];
    [scrollView setShowsHorizontalScrollIndicator:false];
    [scrollView setContentSize:CGSizeMake(self.bounds.size.width*titlesCount, self.bounds.size.height-70)];
    
    [self initViewControllers];
    
    
    [self addSubview:buttonsView];
    [buttonsView addSubview:bottomBar];
    [buttonsView addSubview:floatingBar];
    [self addSubview:scrollView];
}

-(void)initViewControllers{
    int i = 0;
    
    for (UIViewController *vc in self.viewControllers) {
        
        [self.parentViewController addChildViewController:vc];
        [scrollView addSubview:vc.view];
        [vc didMoveToParentViewController:self.parentViewController];
        vc.view.frame = CGRectMake(self.bounds.size.width*i, 0, self.bounds.size.width, self.bounds.size.height-70);
        i++;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat xPoint = (scrollView.contentOffset.x/titlesCount);
    
    if(self.isRTL){
        xPoint = fabs((self.bounds.size.width - (self.bounds.size.width/titlesCount))-(scrollView.contentOffset.x/titlesCount));
    }
    
//    int page = titlesCount-(scrollView.contentOffset.x / scrollView.bounds.size.width)-1;
    
    int page = (scrollView.contentOffset.x / scrollView.bounds.size.width);
    
//    if (self.isRTL) {
//        page = titlesCount-(scrollView.contentOffset.x / scrollView.bounds.size.width)-1;
//    }
    
    NSLog(@"xpos is- --- %i", page );
    for (UIButton *btn in buttons) {
        UIColor *activeColor = page == btn.tag ? self.activeTabColor : self.titlesColor;
        [btn setTitleColor:activeColor forState:UIControlStateNormal];
    }
    floatingBar.frame = CGRectMake(xPoint, 68, self.bounds.size.width/titlesCount, 2);
    
    
}

-(void)addActionToButton:(UIButton *)sender{
    
    NSLog(@"----->>>> %@",sender.currentTitle);
    NSLog(@"----->>>> %i",sender.tag);
//    for (UIButton *btn in buttons) {
//        UIColor *activeColor = sender.tag == btn.tag ? self.activeTabColor : self.titlesColor;
//        [btn setTitleColor:activeColor forState:UIControlStateNormal];
//    }
    
    CGFloat width = self.bounds.size.width;
    [UIView animateWithDuration:0.3 animations:^ {
        scrollView.contentOffset = CGPointMake(width*sender.tag, 0);
    }];
    
    
}
@end
