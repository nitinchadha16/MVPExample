//
//  MenuDetailFlowTest.m
//  MvpSampleTests
//
//  Created by Rahul Kapoor on 11/05/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

#import "MenuDetailFlowTest.h"
#import <OCMock/OCMock.h>
#import "MvpSampleTests-Swift.h"		


@implementation MenuDetailFlowTest {
    
    id mockedProtocol;
}

-(void)setUp {
    
    mockedProtocol = [OCMockObject mockForProtocol:@protocol(MenuDetailViewProtocol)];
}

-(void)testWeAreInformingAboutRequestStart {
    
    mockedProtocol = [OCMockObject mockForProtocol:@protocol(MenuDetailViewProtocol)];
    OCMStub([mockedProtocol onRequestStarted])._andDo(nil);
    OCMStub([mockedProtocol onReceivedError])._andDo(nil);
    
    MenuDetailPresenter *presenter = [[MenuDetailPresenter alloc] initWithView:mockedProtocol];
    
    // Get menu
    [presenter getMenuForCustomer];
    
    OCMVerify([mockedProtocol onReceivedError]);
}

/**
 * Summary: defaultTestSuite
 * This method is used to run a set of test cases.
 * return:
 */
+ (id)defaultTestSuite {
    
    XCTestSuite *suite= [XCTestSuite testSuiteWithName:@"Menu detail flow Test case"];
    
    [suite addTest: [MenuDetailFlowTest testCaseWithSelector:@selector(testWeAreInformingAboutRequestStart)]];
    
    return suite;
}

@end
