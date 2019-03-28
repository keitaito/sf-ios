//
//  FeedItemTests.m
//  SF iOSTests
//
//  Created by Amit Jain on 7/31/17.
//  Copyright © 2017 Amit Jain. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Event.h"
#import "FeedItem.h"

@interface FeedItemTests : XCTestCase

@property (nonatomic) Event *event;

@end

@implementation FeedItemTests

- (void)setUp {
    [super setUp];
    

    NSDictionary *dict = @{@"end_at": @"2019-04-03T17:00:00.000Z",
                           @"group_id": @"28ef50f9-b909-4f03-9a69-a8218a8cbd99",
                           @"id": @"adb7eb98-ed48-4d09-8eba-2f3acec9cf64",
                           @"image_url": @"https://fastly.4sqi.net/img/general/720x537/mIIPSQkw8mreYwS5STIU3srMXddR2rQD56uzvcEL7n4.jpg",
                           @"name": @"Four Barrel Coffee",
                           @"start_at": @"2019-04-03T15:30:00.000Z",
                           @"venue_url": @"https://foursquare.com/v/four-barrel-coffee/480d1a5ef964a520284f1fe3"};
    self.event = [[Event alloc] initWithDictionary:dict];
    self.event.type = EventTypeSFCoffee;
    self.event.date = [NSDate new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEventInTomorrow {
    NSDate *eventDate = [self dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate new]];
    self.event.date = eventDate;
    FeedItem *item = [[FeedItem alloc] initWithEvent:self.event];
    XCTAssertTrue([item.dateString isEqualToString:@"Tomorrow"]);
    XCTAssertTrue(item.isActive);
}

- (void)testEventInToday {
    NSDate *eventDate = [self dateByAddingUnit:NSCalendarUnitHour value:1 toDate:[NSDate new]];
    self.event.date = eventDate;
    FeedItem *item = [[FeedItem alloc] initWithEvent:self.event];
    
    XCTAssertTrue([item.dateString isEqualToString:@"Today"]);
    XCTAssertTrue(item.isActive);
}

- (void)testEventInPastButStillInToday {
    NSDate *eventDate = [self dateByAddingUnit:NSCalendarUnitHour value:-2 toDate:[NSDate new]];
    self.event.date = eventDate;
    FeedItem *item = [[FeedItem alloc] initWithEvent:self.event];
    
    XCTAssertTrue([item.dateString isEqualToString:@"Today"]);
    XCTAssertFalse(item.isActive);
}

- (void)testEventInYesterday {
    NSDate *eventDate = [self dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:[NSDate new]];
    self.event.date = eventDate;
    FeedItem *item = [[FeedItem alloc] initWithEvent:self.event];
    
    XCTAssertTrue([item.dateString isEqualToString:@"Yesterday"]);
    XCTAssertEqual(item.isActive, false);
}

- (void)testEventInLastMonth {
    NSDate *eventDate = [self dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:[NSDate new]];
    self.event.date = eventDate;
    FeedItem *item = [[FeedItem alloc] initWithEvent:self.event];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MMM d";
    NSString *expctedTime = [formatter stringFromDate:eventDate];
    
    XCTAssertTrue([item.dateString isEqualToString:expctedTime]);
    XCTAssertFalse(item.isActive);
}

- (NSDate *)dateByAddingUnit:(NSCalendarUnit)calendarUnit value:(NSInteger)value toDate:(NSDate *)date {
    return [[NSCalendar currentCalendar] dateByAddingUnit:calendarUnit value:value toDate:date options:0];
}

@end
