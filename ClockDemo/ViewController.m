//
//  ViewController.m
//  ClockDemo
//
//  Created by caramel on 5/26/15.
//  Copyright (c) 2015 caramel. All rights reserved.
//

#import "ViewController.h"

#define CAImageW        self.imageView.bounds.size.width
#define CAImageH        self.imageView.bounds.size.height

#define angle2radian(x)     ((x) / 180 * M_PI)

#define CAPerSecAngle   6
#define CAPerMinAngle   6
#define CAPerHouAngle   30
#define CAPerMinHouAngle    0.5

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) CALayer *secondsLayer;
@property (weak, nonatomic) CALayer *minuteLayer;
@property (weak, nonatomic) CALayer *hourLayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加秒针
    [self addSeconds];
    
    // 添加分针
    [self addMinute];
    
    // 添加时针
    [self addHour];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    [self update];
}

#pragma mark - 添加时分秒layer

- (void)addSeconds
{
    CALayer *secLayer = [CALayer layer];
    secLayer.bounds = CGRectMake(0, 0, 1, CAImageW * 0.5 - 25);
    secLayer.anchorPoint = CGPointMake(0.5, 1);
    secLayer.position = CGPointMake(CAImageW * 0.5, CAImageH * 0.5);
    secLayer.backgroundColor = [UIColor redColor].CGColor;
    secLayer.cornerRadius = 1;
    self.secondsLayer = secLayer;
    [self.imageView.layer addSublayer:secLayer];
}

- (void)addMinute
{
    CALayer *minuteLayer = [CALayer layer];
    minuteLayer.bounds = CGRectMake(0, 0, 3, CAImageW * 0.5 - 40);
    minuteLayer.anchorPoint = CGPointMake(0.5, 1);
    minuteLayer.position = CGPointMake(CAImageW * 0.5, CAImageH * 0.5);
    minuteLayer.backgroundColor = [UIColor greenColor].CGColor;
    minuteLayer.cornerRadius = 2;
    self.minuteLayer = minuteLayer;
    [self.imageView.layer addSublayer:minuteLayer];
}

- (void)addHour
{
    CALayer *hourLayer = [CALayer layer];
    hourLayer.bounds = CGRectMake(0, 0, 5, CAImageW * 0.5 - 60);
    hourLayer.anchorPoint = CGPointMake(0.5, 1);
    hourLayer.position = CGPointMake(CAImageW * 0.5, CAImageH * 0.5);
    hourLayer.backgroundColor = [UIColor blackColor].CGColor;
    hourLayer.cornerRadius = 3;
    self.hourLayer = hourLayer;
    [self.imageView.layer addSublayer:hourLayer];
}

#pragma mark - 每秒更新各layer的旋转角度

- (void)update
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    CGFloat secAngle = components.second * CAPerSecAngle;
    
    CGFloat minAngle = components.minute * CAPerMinAngle;
    
    CGFloat houAngle = components.hour * CAPerHouAngle;
    
    houAngle += components.minute * CAPerMinHouAngle;
    
    self.secondsLayer.transform = CATransform3DMakeRotation(angle2radian(secAngle), 0, 0, 1);
    
    self.minuteLayer.transform = CATransform3DMakeRotation(angle2radian(minAngle), 0, 0, 1);
    
    self.hourLayer.transform = CATransform3DMakeRotation(angle2radian(houAngle), 0, 0, 1);
}

@end
