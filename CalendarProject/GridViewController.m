//
//  GridViewController.m
//  RecipePhoto
//
//  Created by Infinitum on 14/10/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "GridViewController.h"
#import "UIColor+Expanded.h"
#import "font/UIFont+FontAwesome.h"
#import "GridVO.h"
@interface GridViewController ()

@end

@implementation GridViewController
@synthesize noofdayArray,currentday,weekdayName,month,year,monthyearLbl,monthyearBtn,currentmonth,currentyear,noentryLll,appDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    appDelegate=[[UIApplication sharedApplication] delegate];

    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(30, 0, 110, 35)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //[titleLabel setText:[NSString stringWithFormat:@"Hi %@",[homepage objectForKey:@"username"]]];
    titleLabel.text=@"Time Sheet";
    [titleLabel setTextColor: [UIColor colorWithHexString:@"#851c2b"]];
    UIFont * font1 =[UIFont fontWithName:@"OpenSans-ExtraBold" size:15.0f];
    titleLabel.font=font1;
    self.navigationItem.titleView = titleLabel;

    noofdayArray=[[NSMutableArray alloc]init];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    UILabel *lineLbl = [[UILabel alloc] init];
    [lineLbl setFrame:CGRectMake(0,screenRect.size.height*0.115, screenRect.size.width,1)];
    [lineLbl setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:lineLbl];

    UIButton * privBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.02,screenRect.size.height*0.12,screenRect.size.width*0.20,screenRect.size.height*0.05)];
    privBtn.layer.cornerRadius = 6.0f;
    privBtn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:20];
    [privBtn setTitle:@"\uf0a8" forState:UIControlStateNormal];
    privBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //[privBtn.titleLabel setFont:customFontdregs];
    privBtn.tag=1;
    [privBtn setBackgroundColor:[UIColor clearColor]];
    [privBtn setTitleColor:[UIColor colorWithHexString:@"03687f"] forState:UIControlStateNormal];
    [privBtn addTarget:self action:@selector(privousActionBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:privBtn];

    UIButton * nextBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.78,screenRect.size.height*0.12,screenRect.size.width*0.20,screenRect.size.height*0.05)];
    nextBtn.layer.cornerRadius = 6.0f;
    nextBtn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:20];
    [nextBtn setTitle:@"\uf0a9" forState:UIControlStateNormal];
    nextBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    nextBtn.tag=2;
    [nextBtn setTitleColor:[UIColor colorWithHexString:@"03687f"] forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor clearColor]];
    [nextBtn addTarget:self action:@selector(nextActionBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];

    weekdayName=[[NSArray alloc] initWithObjects:@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun", nil];
    
    int height=5;
    for (int count=0; count<[weekdayName count]; count++) {
        NSString *weekdayNameStr=[weekdayName objectAtIndex:count];
        UILabel *nameofday=[[UILabel alloc] initWithFrame:CGRectMake(height,screenRect.size.height*0.15, screenRect.size.width/8, 40)];
        //nameofday.font = [UIFont fontWithName:@"OpenSans-Bold" size:14];
        nameofday.textColor=[UIColor blackColor];
        nameofday.text=[NSString stringWithFormat:@"%@",weekdayNameStr];
        nameofday.textAlignment = NSTextAlignmentCenter;
        nameofday.lineBreakMode = NSLineBreakByWordWrapping;
        nameofday.numberOfLines = 0;
        [self.view addSubview:nameofday];
        height=height+screenRect.size.width/8+4;
        
    }

    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    currentday = [components day];
    month = [components month];
    year = [components year];
    currentmonth = [components month];
    currentyear= [components year];
    [self displayview];
}

-(IBAction)privousActionBtn{
    month=month-1;
    if (month==0) {
        month=12;
        year=year-1;
    }
    [self displayview];
}
-(IBAction)nextActionBtn{
    month=month+1;
    if (month==13) {
        month=1;
        year=year+1;
    }
    [self displayview];
}

-(void)displayview{
    noofdayArray=[[NSMutableArray alloc]init];
//    month=4;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    currentday = [components day];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSLog(@"month %ld",(unsigned long)month);
    NSLog(@"year %ld",(unsigned long)year);
  
    NSDate *date1 = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:date1];
    NSUInteger numberOfDaysInMonth = days.length;
    
    NSLog(@"days %ld",(unsigned long)numberOfDaysInMonth);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    dateFormatter.dateFormat=@"EEEE";
    NSString *dayString = [[dateFormatter stringFromDate:date1] capitalizedString];
    dateFormatter.dateFormat=@"MMMM";
    NSString *monthString = [[dateFormatter stringFromDate:date1] capitalizedString];

    NSLog(@"day: %@", dayString);
    int indexOfStart=0;
    for (int count=0; count<[weekdayName count]; count++) {
        NSString *weekdayNameStr=[weekdayName objectAtIndex:count];
        if ([dayString rangeOfString:weekdayNameStr].location != NSNotFound) {
            indexOfStart=count;
            NSLog(@"indexOfStart: %d", indexOfStart);
            break;
        }
    }
    for (int count=0; count<indexOfStart; count++) {
        GridVO *grivd=[[GridVO alloc]init];
        grivd.dayvalue=[[NSString alloc]init];
        grivd.hoursTime=[[NSString alloc]init];
        grivd.statusvalue=[[NSString alloc]init];
        [noofdayArray addObject:grivd];
    }
    for (int count=0; count<numberOfDaysInMonth; count++) {
        NSString *str=[NSString stringWithFormat:@"%d",count+1];
        GridVO *grivd=[[GridVO alloc]init];
        grivd.dayvalue=[[NSString alloc]init];
        grivd.hoursTime=[[NSString alloc]init];
        
        grivd.statusvalue=[[NSString alloc]init];
        grivd.hoursTime=@"00:00";
        grivd.dayvalue=str;
        if (count==10) {
            grivd.statusvalue=@"Approved";
        }else if (count==15) {
            grivd.statusvalue=@"Saved";
        }else{
           grivd.statusvalue=@"No Entry";
        }
        [noofdayArray addObject:grivd];
    }
    
    int rows=noofdayArray.count/7;
    if(rows*7<noofdayArray.count){
        rows=rows+1;
    }
    int mod=rows*7-noofdayArray.count;
    for(int i=0;i<mod;i++){
        GridVO *grivd=[[GridVO alloc]init];
        grivd.dayvalue=[[NSString alloc]init];
        grivd.hoursTime=[[NSString alloc]init];
        grivd.statusvalue=[[NSString alloc]init];
        [noofdayArray addObject:grivd];
    }
    [_collectionView removeFromSuperview];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0,screenRect.size.height*0.21, screenRect.size.width, screenRect.size.height*0.85) collectionViewLayout:layout];
    //_collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,screenRect.size.height*0.15, screenRect.size.width, screenRect.size.height*0.85)];
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_collectionView];

    [monthyearLbl removeFromSuperview];
    monthyearLbl = [[UILabel alloc] init];
    [monthyearLbl setFrame:CGRectMake(screenRect.size.width*0.28,screenRect.size.height*0.12,screenRect.size.width*0.45,25)];
    monthyearLbl.textAlignment = NSTextAlignmentCenter;
    monthyearLbl.text=[NSString stringWithFormat:@"%@ - %ld",monthString,(long)year];
    [monthyearLbl setTextColor: [UIColor blueColor]];
    //[self.view addSubview:monthyearLbl];
    appDelegate.monthyearSTR=[[NSString alloc]init];
    appDelegate.monthyearSTR=[NSString stringWithFormat:@"%@ - %ld",monthString,(long)year];
    UIFont *customFontdregs = [UIFont systemFontOfSize:15];

    monthyearBtn=[[UIButton alloc]initWithFrame:CGRectMake(screenRect.size.width*0.28,screenRect.size.height*0.12,screenRect.size.width*0.45,25)];
    monthyearBtn.layer.cornerRadius = 6.0f;
    [monthyearBtn setTitle:appDelegate.monthyearSTR forState:UIControlStateNormal];
    [monthyearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    monthyearBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [monthyearBtn.titleLabel setFont:customFontdregs];
    monthyearBtn.tag=2;
    [monthyearBtn setBackgroundColor:[UIColor whiteColor]];
    //[monthyearBtn addTarget:self action:@selector(setMontYearBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:monthyearBtn];
}

-(void)setMontYearBtn{
    NSMutableArray * testArray=[[NSMutableArray alloc]init];
    NSUInteger counts=month-6;
    NSUInteger countsYe=year;
    NSLog(@"counts %ld",(unsigned long)counts);
    NSLog(@"year %ld",(unsigned long)countsYe);

    for (int count=0; count<12; count++) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        currentday = [components day];
        NSDateComponents *comps = [[NSDateComponents alloc] init]; 
        if (counts<=0) {
            countsYe=countsYe-1;
        }else if(counts>=12){
            countsYe=countsYe+1;
        }

        [comps setDay:1];
        [comps setMonth:counts+1];
        [comps setYear:countsYe];

        NSLog(@"counts %ld",(unsigned long)counts);
        NSLog(@"year %ld",(unsigned long)countsYe);
        
        NSDate *date1 = [[NSCalendar currentCalendar] dateFromComponents:comps];
        
        NSCalendar *c = [NSCalendar currentCalendar];
        NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                               inUnit:NSMonthCalendarUnit
                              forDate:date1];
        NSUInteger numberOfDaysInMonth = days.length;
        
        NSLog(@"days %ld",(unsigned long)numberOfDaysInMonth);
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyyMMdd";
        dateFormatter.dateFormat=@"EEEE";
        dateFormatter.dateFormat=@"MMMM";
        NSString *monthString = [[dateFormatter stringFromDate:date1] capitalizedString];

        NSString *monthyearSTR=[NSString stringWithFormat:@"%@ - %ld",monthString,(long)countsYe];
        [testArray addObject:monthyearSTR];
    }
//    for (int count=0; count<6; count++) {
//        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
//        currentday = [components day];
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setDay:1];
//        [comps setMonth:month+count];
//        NSUInteger counts=month+count;
//        NSUInteger noof;
//        if (counts>12){
//            noof=year+1;
//            [comps setYear:noof];
//        }
//        else{
//            noof=year;
//        [comps setYear:noof];
//        }
//            NSLog(@"month %ld",(unsigned long)month);
//        NSLog(@"year %ld",(unsigned long)year);
//        
//        NSDate *date1 = [[NSCalendar currentCalendar] dateFromComponents:comps];
//        
//        NSCalendar *c = [NSCalendar currentCalendar];
//        NSRange days = [c rangeOfUnit:NSDayCalendarUnit
//                               inUnit:NSMonthCalendarUnit
//                              forDate:date1];
//        NSUInteger numberOfDaysInMonth = days.length;
//        
//        NSLog(@"days %ld",(unsigned long)numberOfDaysInMonth);
//        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.dateFormat = @"yyyyMMdd";
//        dateFormatter.dateFormat=@"EEEE";
//        dateFormatter.dateFormat=@"MMMM";
//        NSString *monthString = [[dateFormatter stringFromDate:date1] capitalizedString];
//        
//        NSString *monthyearSTR=[NSString stringWithFormat:@"%@ - %ld",monthString,(long)noof];
//        [testArray addObject:monthyearSTR];
//    }


}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [noofdayArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.layer.borderWidth=2.0f;
    cell.layer.borderColor=[UIColor blueColor].CGColor;
    GridVO *grivd=[[GridVO alloc]init];
    grivd=[noofdayArray objectAtIndex:indexPath.row];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFrame:CGRectMake(5,0,25,20)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text=[NSString stringWithFormat:@"%@",grivd.dayvalue];
    [titleLabel setTextColor: [UIColor blackColor]];
    [cell.contentView addSubview:titleLabel];
    [cell.contentView bringSubviewToFront:titleLabel];

    if (![titleLabel.text isEqualToString:@""]) {
    UILabel *timeofhours = [[UILabel alloc] init];
    [timeofhours setFrame:CGRectMake(0,30,45,20)];
    timeofhours.textAlignment = NSTextAlignmentCenter;
    UIFont * font1 =[UIFont systemFontOfSize:10.0f];
    timeofhours.font=font1;
    timeofhours.text=[NSString stringWithFormat:@"%@",grivd.hoursTime];
    [timeofhours setTextColor: [UIColor colorWithHexString:@"4aa8f0"]];
    [cell.contentView addSubview:timeofhours];
    [cell.contentView bringSubviewToFront:timeofhours];
        
    noentryLll = [[UILabel alloc] init];
    [noentryLll setFrame:CGRectMake(0,50,45,20)];
    noentryLll.textAlignment = NSTextAlignmentCenter;
    UIFont * font2 =[UIFont systemFontOfSize:9.0f];
    noentryLll.font=font2;
    noentryLll.tag=indexPath.row;
        if ([grivd.statusvalue isEqualToString:@"Approved"]) {
            noentryLll.text=[NSString stringWithFormat:@"%@",grivd.statusvalue];
            [noentryLll setTextColor: [UIColor colorWithHexString:@"419241"]];
        }else if ([grivd.statusvalue isEqualToString:@"Saved"]) {
            noentryLll.text=[NSString stringWithFormat:@"%@",grivd.statusvalue];
            [noentryLll setTextColor: [UIColor colorWithHexString:@"414192"]];
        }
        else {
            noentryLll.text=[NSString stringWithFormat:@"%@",grivd.statusvalue];
            [noentryLll setTextColor: [UIColor colorWithHexString:@"924141"]];
        }
    [cell.contentView addSubview:noentryLll];
    [cell.contentView bringSubviewToFront:noentryLll];

    }
    NSUInteger day=[titleLabel.text integerValue];
    if (day==currentday && month==currentmonth && year==currentyear) {
        cell.backgroundColor=[UIColor greenColor];
    }else{
        cell.backgroundColor=[UIColor whiteColor];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return CGSizeMake(screenRect.size.width/8+3, screenRect.size.height/8);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridVO *grivd=[[GridVO alloc]init];
    grivd=[noofdayArray objectAtIndex:indexPath.row];

    NSLog(@"current date selected %@",grivd.dayvalue);
    if ([grivd.statusvalue isEqualToString:@"Approved"]) {
        
    }else{
//    GridviewDetalisViewController *grodview=[[GridviewDetalisViewController alloc] initWithNibName:@"GridviewDetalisViewController" bundle:nil];
//        grodview.titleStr=[[NSString alloc]init];
//        grodview.titleStr=grivd.dayvalue;
//    [self.navigationController pushViewController:grodview animated:YES];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,5,0,5); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
