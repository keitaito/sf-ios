//
//  Event.h
//  SF iOS
//
//  Created by Amit Jain on 7/29/17.
//  Copyright © 2017 Amit Jain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventType.h"
@import UIKit;

NS_ASSUME_NONNULL_BEGIN
@interface Event : NSObject

@property (nonatomic, assign) EventType type;
@property (nonatomic) NSDate* date;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic) NSURL *venueURL;
@property (nonatomic) NSString *name;
@property (nonatomic, readonly) UIImage *annotationImage;
@property (nonatomic, readonly) NSDate *endDate;
@property (nonatomic, readonly, assign) BOOL isActive;
@property (nullable, nonatomic) NSURL *imageFileURL;

- (instancetype)initWithDictionary:(NSDictionary *)record;

@end
NS_ASSUME_NONNULL_END
