//
//  MenuDetailModel.swift
//  MvpSample
//
//  Created by Rahul Kapoor on 10/05/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import Foundation

@objc class MenuDetailModel : NSObject, Decodable {
    
    var id : Int
    var title : String
    var subTitle : String
    
    required init(id : Int, title : String, subTitle : String) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
    }
    
    enum CodingKeys : String, CodingKey {
        case id = "userId"
        case title = "title"
        case subTitle = "body"
    }
    
    static func == (lhs: MenuDetailModel, rhs: MenuDetailModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
