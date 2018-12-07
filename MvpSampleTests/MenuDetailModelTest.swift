//
//  MenuDetailModelTest.swift
//  MvpSampleTests
//
//  Created by Rahul Kapoor on 10/05/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import XCTest
import OCMock

@testable import MvpSample

class MenuDetailModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: Testing Methods related to UI logics
    
    /*
     * To test we are showing correct color code on UI
     */
    func testWeAreShowingCorrectColorCodeOnUI() {
        
        let brownCodeDish = MenuDetailModel.init(id: 2, title: "", subTitle: "")
        XCTAssertTrue(UIUtils.getColorCodeForDish(menuDetail: brownCodeDish) == .brown, "Dish color mismatched")
        
        let greenCodeDish = MenuDetailModel.init(id: 5, title: "", subTitle: "")
        XCTAssertTrue(UIUtils.getColorCodeForDish(menuDetail: greenCodeDish) == .green, "Dish color mismatched")
        
        let grayCodeDish = MenuDetailModel.init(id: 101, title: "", subTitle: "")
        XCTAssertTrue(UIUtils.getColorCodeForDish(menuDetail: grayCodeDish) == .darkGray, "Dish color mismatched")
        
        let someOtherDishCode = MenuDetailModel.init(id: 5, title: "", subTitle: "")
        XCTAssertFalse(UIUtils.getColorCodeForDish(menuDetail: someOtherDishCode) == .darkGray, "Dish color mismatched")
    }
    
    /*
     * To test we are not duplicating elements on UI
     */
    func testWeAreShowingUniqueDataSetOnUI() {
        
        var menuDetails : [MenuDetailModel] = [MenuDetailModel]()
        
        let bundle = Bundle(for: type(of: self))
        do {
            if let file = bundle.url(forResource: "sample_response", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let jsonArr = json as? [Any] {
                    
                    for jsonDict in jsonArr {
                        
                        let jsonDictData = try JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)
                        
                        guard let menuDetail = try? JSONDecoder().decode(MenuDetailModel.self, from: jsonDictData) else {
                            print("Couldn't decode menu detail")
                            XCTAssertThrowsError(NSError(domain: "Unable to decode menu detail", code: 104, userInfo: nil))
                            return
                        }
                        
                        // Save unique ids only
                        // Bad loop, but sadly equatable won't work for objective c
                        var isContains = false
                        
                        for savedMenuDetail in menuDetails {
                            if savedMenuDetail.id == menuDetail.id {
                                isContains = true
                            }
                        }
                        
                        if !isContains {
                            menuDetails.append(menuDetail)
                        }
                        
                    }
                    
                    // To make sure we are not duplicating elements
                    XCTAssertTrue(menuDetails.count == 10)
                    
                } else {
                    XCTAssertThrowsError(NSError(domain: "Json is in invalid format", code: 101, userInfo: nil))
                }
            } else {
                XCTAssertThrowsError(NSError(domain: "ResourceNotFoundException", code: 100, userInfo: nil))
            }
        } catch {
            XCTAssertThrowsError(error)
        }
    }
    
}
