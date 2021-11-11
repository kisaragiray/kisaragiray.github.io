#import "SnowView.h"

@implementation SnowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化设置
        [self setup];
    }
    return self;
}

- (void)setup {
    self.emitterLayer.masksToBounds   = YES;
    self.emitterLayer.emitterShape    = kCAEmitterLayerLine;
    self.emitterLayer.emitterMode     = kCAEmitterLayerSurface;
    self.emitterLayer.emitterSize     = self.frame.size;
    self.emitterLayer.emitterPosition = CGPointMake(self.bounds.size.width / 2, -20);
}

- (void)show {
    // 配置
    CAEmitterCell *snowflake  = [CAEmitterCell emitterCell];

    snowflake.birthRate 		= 1.0f;		//1.0 //量
    snowflake.speed 			= 10.0f;		//10.0
    snowflake.velocity		 	= 2.0f;		//2.0
    snowflake.velocityRange 	= 1.0f;		//1.0
    snowflake.yAcceleration   	= 10.0f;		//10.0 スピード//
    snowflake.emissionRange   	= 0.5 * M_1_PI;	//0.5
    snowflake.spinRange 		= 0.5 * M_PI;	//0.25
    snowflake.lifetime 			= 60000.0f;			//60.0
    snowflake.scale		 		= 0.04;			//0.5
    snowflake.scaleRange 		= 0.2;			//0.3
    snowflake.contents 			= (__bridge id)([UIImage imageNamed:@"snow_white"].CGImage);
    //snowflake.color           = [UIColor whiteColor].CGColor;
    
    // 添加动画
    self.emitterLayer.emitterCells = @[snowflake];
}

@end
