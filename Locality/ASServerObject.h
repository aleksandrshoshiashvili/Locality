//
//  ASServerObject.h
//  APITest
//
//  Created by Александр on 08.04.15.
//  Copyright (c) 2015 Александр. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASServerObject : NSObject

@property (strong, nonatomic) NSString *uid;

- (id) initWithServerResponse:(NSDictionary *) responseObject;

@end
