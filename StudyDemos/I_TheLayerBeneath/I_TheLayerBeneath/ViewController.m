//
//  ViewController.m
//  I_TheLayerBeneath
//
//  Created by yanyue on 2017/8/7.
//  Copyright © 2017年 yanyue. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()<CALayerDelegate>

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) UIImageView *hourHand;
@property (nonatomic, weak) UIImageView *minuteHand;
@property (nonatomic, weak) UIImageView *secondHand;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1_The Layer Tree
//    [self theLayerTree];
    
    //2_The Backing Image_2.1
//    [self settingaCGImageastheLayercontents];
    
    //2_The Backing Image_2.2
//    [self usingContentsScaleToCorrectTheImageDisplayScale];
    
    //2_The Backing Image_2.3
//    [self splittingUpASpriteSheetUsingContentsRect];
    
    //2_The Backing Image_2.4
//    [self settingUpStretchableViewsUsingContentsCenter];
    
    //2_The Backing Image_2.5
//    [self implementingTheCALayerDelegate];
    
    //3_Layer Geometry_3.1&3.2
    [self clock];
}

#pragma mark
#pragma mark 1_The Layer Tree
- (void)theLayerTree
{
    //create sublayer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:blueLayer];
}

#pragma mark
#pragma mark 2_The Backing Image
- (void)settingaCGImageastheLayercontents
{
    UIImage *image = [UIImage imageNamed:@"doraemon.png"];
    
    //add it directly to our view's layer
    self.layerView.layer.contents = (__bridge id)image.CGImage;
}

- (void)usingContentsScaleToCorrectTheImageDisplayScale
{
    UIImage *image = [UIImage imageNamed:@"doraemon.png"];
    
    //add it directly to our view's layer
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    self.layerView.contentMode = UIViewContentModeScaleAspectFit;//2.1根据图片原始比例拉伸
    
    //    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;//2.2同“2.1”
    
    //    self.layerView.layer.contentsGravity = kCAGravityCenter;//2.3不会拉伸图片,超出部分也会正常显示，同UIView
    //    //set the contentsScale to match image
    //    self.layerView.layer.contentsScale = image.scale;
    //    self.layerView.layer.masksToBounds = YES;//2.3设置这句超出部分会被裁掉
    
    //    self.layerView.layer.contentsGravity = kCAGravityCenter;//2.4根据屏幕将1x，2x，3x图片缩放
    //    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
}

- (void)splittingUpASpriteSheetUsingContentsRect
{   //这部分实现原理和基本代码是一样的。但因为图集找的不一样，再加上不想总是通过连线方式添加UIView(因为一个工程里有很多demo情况下，连线会互相影响，比如demo theLayerTree中的layerView此方法不需要就需要隐去)，也觉得一个一个调用不方便复用，最后做了一些修改。
    self.layerView.hidden = YES;
    
    UIImage *image = [UIImage imageNamed:@"animals.png"];
    for (int i = 0; i<9; i++)
    {
        int x = i%3;
        int y = i/3;
        CGRect animalRect = CGRectMake([UIScreen mainScreen].bounds.size.width/3*x, [UIScreen mainScreen].bounds.size.height/3*y, 100, 100);
        CGRect animalContentRect = CGRectMake((float)x/3, (float)y/3, (float)1/3, (float)1/3);

        UIView *animalView = [[UIView alloc] initWithFrame:animalRect];
        animalView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:animalView];
        [self addSpriteImage:image withContentRect:animalContentRect toLayer:animalView.layer];
    }
}



- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer //set image
{
    layer.contents = (__bridge id)image.CGImage;
    
    //scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    
    //set contentsRect
    layer.contentsRect = rect;
}

- (void)settingUpStretchableViewsUsingContentsCenter
{
    self.layerView.hidden = YES;
    
    UIImage *image = [UIImage imageNamed:@"contentsCenter.png"];
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 170, 340)];
    [self.view addSubview:button1];
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 370, 340, 170)];
    [self.view addSubview:button2];
    //原图
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(200, 20, 170, 170)];
    [self.view addSubview:button3];
    
    //set button 1
    [self addStretchableImage:image withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:button1.layer];
    
    //set button 2
    [self addStretchableImage:image withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:button2.layer];
    
    //set button 3
    [self addStretchableImage:image withContentCenter:CGRectMake(0.25, 0.25, 0.5, 0.5) toLayer:button3.layer];
}

- (void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer
{
    //set image
    layer.contents = (__bridge id)image.CGImage;
    
    //set contentsCenter
    layer.contentsCenter = rect;
}

- (void)implementingTheCALayerDelegate
{
    //create sublayer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //set controller as layer delegate
    blueLayer.delegate = self;
    
    //ensure that layer backing image uses correct scale
    blueLayer.contentsScale = [UIScreen mainScreen].scale; //add layer to our view
    [self.layerView.layer addSublayer:blueLayer];
    
    //force layer to redraw
    [blueLayer display];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

#pragma mark
#pragma mark 3_Layer Geometry
- (void)clock
{
    UIImageView *clockImageview = [self createImageview:CGRectMake([UIScreen mainScreen].bounds.size.width/2-120, [UIScreen mainScreen].bounds.size.height/2-120, 240, 240) imageName:@"clock" superView:self.view];
    self.hourHand = [self createImageview:CGRectMake(105, 75, 31, 90) imageName:@"hour" superView:clockImageview];
    self.minuteHand = [self createImageview:CGRectMake(109, 70, 22, 100) imageName:@"minute" superView:clockImageview];
    self.secondHand = [self createImageview:CGRectMake(109, 70, 23, 100) imageName:@"second" superView:clockImageview];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    
    // 3.2_clockWithAdjustedAnchorPointValues
//    frame.origin.x = position.x - anchorPoint.x * bounds.size.width
//    frame.origin.y = position.y - anchorPoint.y * bounds.size.height
    self.secondHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.minuteHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    self.hourHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    
    //set initial hand positions
    [self tick];
}

- (void)tick
{
    self.layerView.hidden = YES;
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    //calculate hour hand angle //calculate minute hand angle
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    //rotate hands
    self.hourHand.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.minuteHand.transform = CGAffineTransformMakeRotation(minsAngle);
    self.secondHand.transform = CGAffineTransformMakeRotation(secsAngle);
}

- (UIImageView*)createImageview:(CGRect)rect imageName:(nonnull NSString*)imageName superView:(UIView*)superView
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:rect];
    imageview.image = [UIImage imageNamed:imageName];
    [superView addSubview:imageview];
    return imageview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
