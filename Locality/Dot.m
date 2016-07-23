//
//  Dot.m
//  Locality
//
//  Created by Alex Shoshiashvili on 22.07.16.
//  Copyright © 2016 OneMoreApp. All rights reserved.
//

#import "Dot.h"
#import "Constants.h"

@implementation Dot

- (Dot *)redDot {
  self.backgroundColor = redDotColor;
  self.layer.cornerRadius = self.frame.size.height / 2.0;
  self.clipsToBounds = YES;
  return self;
}

- (Dot *)greenDot {
  self.backgroundColor = greenDotColor;
  self.layer.cornerRadius = self.frame.size.height / 2.0;
  self.clipsToBounds = YES;
  return self;
}

- (Dot *)blueDot {
  self.backgroundColor = blueDotColor;
  self.layer.cornerRadius = self.frame.size.height / 2.0;
  self.clipsToBounds = YES;
  return self;
}

@end
