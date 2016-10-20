//
//  GridViewController.h
//  RecipePhoto
//
//  Created by Infinitum on 14/10/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface GridViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}
@property(nonatomic,retain) NSMutableArray *noofdayArray;
@property(nonatomic,readwrite)NSInteger currentday,month,year,currentmonth,currentyear;
@property(nonatomic,retain)NSArray *weekdayName;
@property(nonatomic,retain) UILabel *monthyearLbl,*noentryLll;
@property(nonatomic,retain) UIButton * monthyearBtn;
@property(nonatomic,retain) AppDelegate *appDelegate;

@end
