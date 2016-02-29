//
//  InfoWindowOfMarkerView.m
//  Locality
//
//  Created by Aleksandr Shoshiashvili on 30.01.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "InfoWindowOfMarkerView.h"
#import "Constants.h"

@implementation InfoWindowOfMarkerView

- (id)initWithFrameNew:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        InfoWindowOfMarkerView *xibView = [[[NSBundle mainBundle] loadNibNamed:className
                                                                         owner:self
                                                                       options:nil] objectAtIndex:0];
        
        xibView.frame = frame;
        
        [self addSubview:xibView];
        
    }
    return self;
    
}

@end
