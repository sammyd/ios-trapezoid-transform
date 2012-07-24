//
//  TransformView.m
//  3dTransform
//
//  Created by Sam Davies on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TransformView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TransformView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blueColor];
        
        UIView *bgView = [[[UIView alloc] initWithFrame:CGRectMake(25, 25, 100, 100)] autorelease];
        bgView.backgroundColor = [UIColor greenColor];
        [self addSubview:bgView];
        
        UIView *newView = [[[UIView alloc] initWithFrame:CGRectMake(25, 25, 100, 100)] autorelease];
        newView.backgroundColor = [UIColor yellowColor];
        [self addSubview:newView];
        
        
        float m = 0.8;
        float n = 0.9;
        
        newView.layer.anchorPoint = CGPointMake((n+m) / 2, 1.f);
        newView.layer.position = CGPointMake(newView.layer.position.x + newView.layer.frame.size.width * (n+m - 1) / 2, newView.layer.position.y + newView.layer.frame.size.height / 2);
        newView.layer.anchorPointZ = 0;
        
        
        float x[4] = {0, 1, m, n};
        float y[4] = {0, 0, 1, 1};
        
        float dx[3], dy[3];
        
        dx[0] = x[1] - x[2];
        dx[1] = x[3] - x[2];
        dx[2] = x[0] - x[1] + x[2] - x[3];
        dy[0] = y[1] - y[2];
        dy[1] = y[3] - y[2];
        dy[2] = y[0] - y[1] + y[2] - y[3];
        
        float a13 = (dx[2] * dy[1] - dx[1] * dy[2]) / (dx[0] * dy[1] - dx[1] * dy[0]);
        float a23 = (dx[0] * dy[2] - dx[2] * dy[0]) / (dx[0] * dy[1] - dx[1] * dy[0]);
        
        const CATransform3D CATransform3DMagic = {
            x[1] - x[0] + a13 * x[1], y[1] - y[0] + a13 * y[1], 0, a13,
            x[3] - x[0] + a23 * x[3], y[3] - y[0] + a23 * y[3], 0, a23,
            0, 0, 1, 0,
            x[0], y[0], 0, 1
        };
        
        CATransform3D projection = CATransform3DIdentity;
        projection.m34 = 1/10.f;
        
        CATransform3D translation = CATransform3DRotate(CATransform3DMakeScale(1.f,7* sqrt(2), 1.f), -M_PI / 4, 1, 0, 0);
        newView.layer.transform = CATransform3DConcat(translation, projection);
        
    }
    return self;
}

@end
