//
//  FGSearchBar.h
//  FreeGuide
//
//  Created by LeeJunHui on 15/6/4.
//  Copyright (c) 2015年 © 2015 JH Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FGSearchBar;
@protocol FGSearchBarDelegate<NSObject>
- (void)FGSearchBarDidBeginSearch;
@end

@interface FGSearchBar : UIView
@property (weak, nonatomic) id<FGSearchBarDelegate> delegate;
- (void)FGSearchBarShouldBeginSearch;
- (void)FGSearchBarShouldEndSearch;
@end
