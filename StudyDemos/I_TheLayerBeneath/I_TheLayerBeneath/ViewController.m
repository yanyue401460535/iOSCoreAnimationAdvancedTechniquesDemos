//
//  ViewController.m
//  I_TheLayerBeneath
//
//  Created by yanyue on 2017/8/7.
//  Copyright © 2017年 yanyue. All rights reserved.
//

#define RADIANS_TO_DEGREES(x) ((x)/M_PI*180.0)
#define DEGREES_TO_RADIANS(x) ((x)/180.0*M_PI)

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>

//#define LIGHT_DIRECTION 0, 1, -0.5
#define LIGHT_DIRECTION 0.5, 0.5, 0.5

#define AMBIENT_LIGHT 0.5

@interface ViewController ()<CALayerDelegate>

//1&2
@property (weak, nonatomic) IBOutlet UIView *layerView;

//3
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) UIImageView *hourHand;
@property (nonatomic, weak) UIImageView *minuteHand;
@property (nonatomic, weak) UIImageView *secondHand;

@property (nonatomic, weak) UIView *greenView;
@property (nonatomic, weak) UIView *redView;
@property (nonatomic, weak) CALayer *blueLayer;

//4
@property (nonatomic, weak)  UIView *layerView1;
@property (nonatomic, weak)  UIView *layerView2;
@property (nonatomic, weak)  UIView *shadowView;

@property (nonatomic, weak)  UIImageView *imageView;

@property (nonatomic, weak)  UIView *containerView;

//5
@property (nonatomic, weak)  UIView *outerView;
@property (nonatomic, weak)  UIView *innerView;
@property (nonatomic, strong)NSMutableArray *faces;
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
    
    //3_Layer Geometry_3.1&3.2_clockWithAdjustedAnchorPointValues
//    [self drawClock];
    
    //3_Layer Geometry_3.3
//    [self adjustingZPositionToChangeTheDisplayOrder];
//    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(adjustingZPosition) userInfo:nil repeats:NO];
    
    //3_Layer Geometry_3.4(主要知识点在touchesBegan方法)
//    [self theLayerTree];
    
    //4_Visual Effects_4.1&4.2_ApplyingABorder
//    [self applyingCornerRadiusAndMasksToBounds];
    
    //4_Visual Effects_4.3
//    [self usingAnAdditionalViewToSolveShadowClippingProblems];
    
    //4_Visual Effects_4.4
//    [self creatingSimpleShadowPaths];
    
    //4_Visual Effects_4.5
//    [self applyingALayerMask];
    
    //4_Visual Effects_4.6
//    [self displayingAnLCDStyleClock];
    
    //4_Visual Effects_4.7
//    [self usingShouldRasterizeToFixTheGroupedBlendingProblem];
    
    //5_Transforms_5.1
//    [self settingaCGImageastheLayercontents];
//    [self rotatingALayerBy45DegreesUsingAffineTransform];
    
    //5_Transforms_5.2
//    [self settingaCGImageastheLayercontents];
//    [self creatingACompoundTransformUsingSeveralFunctions];
    
    //5_Transforms_5.3
//    [self settingaCGImageastheLayercontents];
//    [self implementingAShearTransform];

    //5_Transforms_5.4
//    [self settingaCGImageastheLayercontents];
//    [self rotatingALayerAroundTheYAxis];
    
    //5_Transforms_5.5
//    [self settingaCGImageastheLayercontents];
//    [self applyingPerspectiveToTheTransform];
    
    //5_Transforms_5.6
//    [self applyingASublayerTransform];
    
    //5_Transforms_5.7
//    [self addOuterAndInnerView];
//    [self oppositeRotationTransformsAroundZAxis];
    
    //5_Transforms_5.8
//    [self addOuterAndInnerView];
//    [self oppositeRotationTransformsAroundYAxis];

    //5_Transforms_5.9&5.10
    [self addFacesArray];
    [self creatingACube];

    
}

#pragma mark
#pragma mark 1_The Layer Tree
#pragma mark
- (void)theLayerTree
{
    self.layerView.hidden = NO;
    //create sublayer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:blueLayer];
    self.blueLayer = blueLayer;
}

#pragma mark
#pragma mark 2_The Backing Image
#pragma mark
#pragma mark 2.1
- (void)settingaCGImageastheLayercontents
{
    self.layerView.hidden = NO;
    
    UIImage *image = [UIImage imageNamed:@"doraemon.png"];
    
    //add it directly to our view's layer
    self.layerView.layer.contents = (__bridge id)image.CGImage;
}

#pragma mark 2.2
- (void)usingContentsScaleToCorrectTheImageDisplayScale
{
    self.layerView.hidden = NO;
    
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

#pragma mark 2.3
- (void)splittingUpASpriteSheetUsingContentsRect
{   //这部分实现原理和基本代码是一样的。但因为图集找的不一样，再加上不想总是通过连线方式添加UIView(因为一个工程里有很多demo情况下，连线会互相影响，比如demo theLayerTree中的layerView就需要根据需求显示或隐去)，也觉得一个一个调用不方便复用，最后做了一些修改。
    
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

#pragma mark 2.4
- (void)settingUpStretchableViewsUsingContentsCenter
{
    
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

#pragma mark 2.5
- (void)implementingTheCALayerDelegate
{
    self.layerView.hidden = NO;
    
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
#pragma mark
#pragma mark 3.1&3.2_clockWithAdjustedAnchorPointValues
- (void)drawClock
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

#pragma mark 3.3
- (void)adjustingZPositionToChangeTheDisplayOrder
{
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];
    self.greenView = greenView;
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(120, 120, 200, 200)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    self.redView = redView;
}

- (void)adjustingZPosition
{
    self.greenView.layer.zPosition = 1.0f;
}

#pragma mark 3.4
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get touch position relative to main view
//    CGPoint point = [[touches anyObject] locationInView:self.view];
//    //convert point to the white layer's coordinates
//    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
//    //get layer using containsPoint:
//    if ([self.layerView.layer containsPoint:point]) {
//        //convert point to blueLayer’s coordinates
//        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
//        if ([self.blueLayer containsPoint:point]) {
//            [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
//                                        message:nil
//                                       delegate:nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:nil] show];
//        } else {
//            [[[UIAlertView alloc] initWithTitle:@"Inside White Layer"
//                                        message:nil
//                                       delegate:nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:nil] show];
//        }
//    }
    
        //3.3_adjustingZPositionToChangeTheDisplayOrder
//        point = [self.greenView.layer convertPoint:point fromLayer:self.view.layer];
//        if ([self.greenView.layer containsPoint:point]) {
//            [[[UIAlertView alloc] initWithTitle:@"Inside Green Layer"
//                                        message:nil
//                                       delegate:nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:nil] show];
//        }
//    
//        point = [self.redView.layer convertPoint:point fromLayer:self.view.layer];
//        if ([self.redView.layer containsPoint:point])
//        {
//            
//            [[[UIAlertView alloc] initWithTitle:@"Inside Red Layer"
//                                        message:nil
//                                       delegate:nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:nil] show];
//        }
}

#pragma mark
#pragma mark 4_Visual Effects
#pragma mark
#pragma mark 4.1&4.2_ApplyingABorder
- (void)applyingCornerRadiusAndMasksToBounds
{
    self.layerView1 = [self createView:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 50, 200, 200) bgColor:[UIColor whiteColor] superView:self.view];
    self.layerView2 = [self createView:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 300, 200, 200)bgColor:[UIColor whiteColor] superView:self.view];
    [self createView:CGRectMake(-50, -50, 100, 100) bgColor:[UIColor redColor] superView:self.layerView1];
    [self createView:CGRectMake(-50, -50, 100, 100) bgColor:[UIColor redColor] superView:self.layerView2];
    
    
    //set the corner radius on our layers
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView2.layer.cornerRadius = 20.0f;
    
    //enable clipping on the second layer
    self.layerView2.layer.masksToBounds = YES;
    
    //4.2_ApplyingABorder
    //add a border to our layers
    self.layerView1.layer.borderWidth = 5.0f;
    self.layerView2.layer.borderWidth = 5.0f;
    
    //注意边框并不会考虑寄宿图或子图层的形状，如果图层的子图层超过了边界，或者是寄宿图在透明区域有一个透明蒙板，边框仍然会沿着图层的边界绘制出来（示例代码如下）
//    self.layerView1.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"doraemon"].CGImage);
//    self.layerView1.layer.contentsGravity = kCAGravityCenter;
}

#pragma mark 4.3
- (void)usingAnAdditionalViewToSolveShadowClippingProblems
{
    self.layerView1 = [self createView:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 50, 200, 200) bgColor:[UIColor whiteColor] superView:self.view];
    //这样的layerView2在设置masksToBounds为YES后会失去阴影，需借助shadowView绘制阴影
    //    self.layerView2 = [self createView:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 300, 200, 200)bgColor:[UIColor whiteColor] superView:self.view];
    self.shadowView = [self createView:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 300, 200, 200)bgColor:[UIColor clearColor] superView:self.view];
    self.layerView2 = [self createView:CGRectMake(0, 0, 200, 200)bgColor:[UIColor whiteColor] superView:self.shadowView];
    
    [self createView:CGRectMake(-50, -50, 100, 100) bgColor:[UIColor redColor] superView:self.layerView1];
    [self createView:CGRectMake(-50, -50, 100, 100) bgColor:[UIColor redColor] superView:self.layerView2];
    
    //set the corner radius on our layers
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView2.layer.cornerRadius = 20.0f;
    
    //add a border to our layers
    self.layerView1.layer.borderWidth = 5.0f;
    self.layerView2.layer.borderWidth = 5.0f;
    
    //add a shadow to layerView1
    self.layerView1.layer.shadowOpacity = 0.5f;
    self.layerView1.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layerView1.layer.shadowRadius = 5.0f;
    
    //add a shadow to layerView2，但这样的layerView2在设置masksToBounds为YES后会失去阴影，需借助shadowView绘制阴影
//    self.layerView2.layer.shadowOpacity = 0.5f;
//    self.layerView2.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
//    self.layerView2.layer.shadowRadius = 5.0f;
    
    //add same shadow to shadowView (not layerView2)
    self.shadowView.layer.shadowOpacity = 0.5f;
    self.shadowView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.shadowView.layer.shadowRadius = 5.0f;
    
    //enable clipping on the second layer
    self.layerView2.layer.masksToBounds = YES;
}

#pragma mark 4.4
- (void)creatingSimpleShadowPaths
{
    self.layerView1 = [self createView:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 50, 200, 200) bgColor:[UIColor clearColor] superView:self.view];
    self.layerView2 = [self createView:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 300, 200, 200)bgColor:[UIColor clearColor] superView:self.view];
    //enable layer shadows
    self.layerView1.layer.shadowOpacity = 0.5f;
    self.layerView2.layer.shadowOpacity = 0.5f;
    
    //下面两个方法实现效果一样，但注意：contentsCenter是图片加载位置，contentsRect是图集的部分，取值范围[0,1]
    [self addStretchableImage:[UIImage imageNamed:@"doraemon"] withContentCenter:CGRectMake(0, 0, 200, 200) toLayer:self.layerView1.layer];
    [self addSpriteImage:[UIImage imageNamed:@"doraemon"] withContentRect:CGRectMake(0, 0, 1, 1) toLayer:self.layerView2.layer];

    
    //create a square shadow
    CGMutablePathRef squarePath = CGPathCreateMutable();
    CGPathAddRect(squarePath, NULL, self.layerView1.bounds);
    self.layerView1.layer.shadowPath = squarePath; CGPathRelease(squarePath);
    
    //create a circular shadow
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, self.layerView2.bounds);
    self.layerView2.layer.shadowPath = circlePath; CGPathRelease(circlePath);
}

#pragma mark 4.5
- (void)applyingALayerMask
{
    self.imageView = [self createImageview:CGRectMake(50, 50, 200, 200) imageName:@"contentsCenter" superView:self.view];

    //create mask layer
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.imageView.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"doraemon.png"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    //apply mask to image layer￼
    self.imageView.layer.mask = maskLayer;
}

#pragma mark 4.6
- (void)displayingAnLCDStyleClock
{
    //没有写作者的例子，因为想着直接一个屏幕直观对比两种方法的区别
    //以下是LCD数字对比
    
//    [self createImageview:CGRectMake(50, 50, 1200, 168) imageName:@"numbers" superView:self.view];
//
//    self.imageView = [self createImageview:CGRectMake(50, 250, 1200, 168) imageName:@"numbers" superView:self.view];
//    self.imageView.layer.magnificationFilter = kCAFilterNearest;
//
    
//    [self createImageview:CGRectMake(50, 50, 2100, 250) imageName:@"numbers_big" superView:self.view];
//
//    self.imageView = [self createImageview:CGRectMake(50, 350, 2100, 250) imageName:@"numbers_big" superView:self.view];
//    self.imageView.layer.magnificationFilter = kCAFilterNearest;
    //结论：对于没有斜线的小图来说，最近过滤算法要好很多
    
    
    [self createImageview:CGRectMake(20, 50, 160, 160) imageName:@"snowmanHead" superView:self.view];
    
    self.imageView = [self createImageview:CGRectMake(200, 50, 160, 160) imageName:@"snowmanHead" superView:self.view];
    self.imageView.layer.magnificationFilter = kCAFilterNearest;
    
    //结论：对于大图来说，双线性滤波和三线性滤波表现得更出色
}

#pragma mark 4.7
- (void)usingShouldRasterizeToFixTheGroupedBlendingProblem
{
    self.containerView = [self createView:[UIScreen mainScreen].bounds bgColor:[UIColor grayColor] superView:self.view];
    //create opaque button
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 150);
    [self.containerView addSubview:button1];
    
    //create translucent button
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 250);
    button2.alpha = 0.5;
    [self.containerView addSubview:button2];
    
    //enable rasterization for the translucent button
    button2.layer.shouldRasterize = YES;
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;

}
- (UIButton *)customButton
{
    //create button
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    return button;
}

#pragma mark
#pragma mark 5_Transforms
#pragma mark
#pragma mark 5.1
- (void)rotatingALayerBy45DegreesUsingAffineTransform
{
    //rotate the layer 45 degrees
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    self.layerView.layer.affineTransform = transform;
}

#pragma mark 5.2
- (void)creatingACompoundTransformUsingSeveralFunctions
{
    //这里对平移的结果有点疑问，打日志方便理解
    NSLog(@"%f,%f,%f,%f",self.layerView.frame.origin.x,self.layerView.frame.origin.y,self.layerView.frame.size.width,self.layerView.frame.size.height);

    CGAffineTransform transform = CGAffineTransformIdentity; //create a new transform
    transform = CGAffineTransformScale(transform, 0.5, 0.5); //scale by 50%
    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0); //rotate by 30 degrees
    transform = CGAffineTransformTranslate(transform, 200,0); //translate by 200 points

    //apply transform to layer
    self.layerView.layer.affineTransform = transform;
    
    NSLog(@"%f,%f,%f,%f",self.layerView.frame.origin.x,self.layerView.frame.origin.y,self.layerView.frame.size.width,self.layerView.frame.size.height);

}

#pragma mark 5.3
- (void)implementingAShearTransform
{
    //shear the layer at a 45-degree angle
    self.layerView.layer.affineTransform = CGAffineTransformMakeShear(1, 0);
}

CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y) {
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}

#pragma mark 5.4
- (void)rotatingALayerAroundTheYAxis
{
    //rotate the layer 45 degrees along the Y axis
    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerView.layer.transform = transform;
}

#pragma mark 5.5
- (void)applyingPerspectiveToTheTransform
{
    //create a new transform
    CATransform3D transform = CATransform3DIdentity; //apply perspective
    transform.m34 = - 1.0 / 500.0; //rotate by 45 degrees along the Y axis
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    //apply to layer
    self.layerView.layer.transform = transform;
}

#pragma mark 5.6
- (void)applyingASublayerTransform
{
    self.containerView = [self createView:CGRectMake([UIScreen mainScreen].bounds.size.width/2-150, 50, 300, 300) bgColor:[UIColor grayColor] superView:self.view];
    self.layerView1 = [self createView:CGRectMake(10, 100, 100, 100) bgColor:[UIColor whiteColor] superView:self.containerView];
    self.layerView2 = [self createView:CGRectMake(190, 100, 100, 100) bgColor:[UIColor whiteColor] superView:self.containerView];
    [self addStretchableImage:[UIImage imageNamed:@"doraemon"] withContentCenter:CGRectMake(0, 0, 100, 100) toLayer:self.layerView1.layer];
    [self addStretchableImage:[UIImage imageNamed:@"doraemon"] withContentCenter:CGRectMake(0, 0, 100, 100) toLayer:self.layerView2.layer];

    
    //apply perspective transform to container
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    
    //rotate layerView1 by 45 degrees along the Y axis
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerView1.layer.transform = transform1;
    //rotate layerView2 by 45 degrees along the Y axis
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.layerView2.layer.transform = transform2;
}

#pragma mark 5.6
- (void)oppositeRotationTransformsAroundZAxis
{
    //rotate the outer layer 45 degrees
    CATransform3D outer = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    self.outerView.layer.transform = outer;
    
    //rotate the inner layer -45 degrees
    CATransform3D inner = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    self.innerView.layer.transform = inner;
}

- (void)addOuterAndInnerView
{
    self.outerView = [self createView:CGRectMake([UIScreen mainScreen].bounds.size.width/2-100, 50, 200, 200) bgColor:[UIColor whiteColor] superView:self.view];
    self.innerView = [self createView:CGRectMake(50, 50, 100, 100) bgColor:[UIColor lightGrayColor] superView:self.outerView];

    //rotate the layer 45 degrees
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    self.outerView.layer.affineTransform = transform;
    self.innerView.layer.affineTransform = transform;

}

#pragma mark 5.7
- (void)oppositeRotationTransformsAroundYAxis
{
    //rotate the outer layer 45 degrees
    CATransform3D outer = CATransform3DIdentity;
    outer.m34 = -1.0 / 500.0;
    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
    self.outerView.layer.transform = outer;
    
    //rotate the inner layer -45 degrees
    CATransform3D inner = CATransform3DIdentity;
    inner.m34 = -1.0 / 500.0;
    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
    self.innerView.layer.transform = inner;
}

#pragma mark 5.8 & 5.9
- (void)creatingACube
{
    self.containerView = [self createView:[UIScreen mainScreen].bounds bgColor:[UIColor grayColor] superView:self.view];
    
    //set up the container sublayer transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    //get the face view and add it to the container
    UIView *face = self.faces[index];
    [self.containerView addSubview:face];
    //center the face view within the container
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    // apply the transform
    face.layer.transform = transform;
    //apply lighting
    [self applyLightingToFace:face.layer];
}

- (void)addFacesArray
{
    self.faces = [NSMutableArray new];
    for (int i = 1; i < 7; i++)
    {
        UIView * tempView =  [self createView:CGRectMake(0, 0, 200, 200) bgColor:[UIColor whiteColor] superView:self.view];
        tempView.layer.borderWidth = 1.0;
        tempView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        UIButton *tempBtn = [self createButton:tempView.frame buttonText:[NSString stringWithFormat:@"%d",i] superView:tempView];
        tempBtn.tag = i;
        [tempBtn addTarget:self action:@selector(cubeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i != 3)
        {
            tempView.userInteractionEnabled = NO;//Summary中：实现只响应按钮3的点击
        }
        [self.faces addObject:tempView];
    }
}

- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer]; layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    //算出的数值有问题，想测试的话可以修改数值试一下
//    shadow = (CGFloat)(arc4random() % 100)/100;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

- (void)cubeBtnClicked:(UIButton*)sender
{
    NSLog(@"%ld cicked",(long)sender.tag);
}

#pragma mark
#pragma mark Utils Method
#pragma mark
- (UIImageView*)createImageview:(CGRect)rect imageName:(nonnull NSString*)imageName superView:(UIView*)superView
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:rect];
    imageview.image = [UIImage imageNamed:imageName];
    [superView addSubview:imageview];
    return imageview;
}

- (UIView*)createView:(CGRect)rect bgColor:(UIColor*)bgColor superView:(UIView*)superView
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    if (bgColor)
    {
        view.backgroundColor = bgColor;
    }
    [superView addSubview:view];
    return view;
}

- (UILabel*)createLabel:(CGRect)rect labelText:(nonnull NSString*)labelText superView:(UIView*)superView
{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = labelText;
    label.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:label];
    return label;
}

- (UIButton*)createButton:(CGRect)rect buttonText:(nonnull NSString*)buttonText superView:(UIView*)superView
{
    UIButton * btn = [[UIButton alloc] initWithFrame:rect];
    [btn setTitle:buttonText forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [superView addSubview:btn];
    return btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
