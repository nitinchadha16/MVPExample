//
//  UIUtils.swift
//  MvpSample
//
//  Created by Rahul Kapoor on 10/05/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import Foundation
import UIKit

class UIUtils {
    
    static func getColorCodeForDish(menuDetail : MenuDetailModel) -> UIColor {
        
        let colorCode : UIColor
        
        switch menuDetail.id {
        case 1, 2, 3:
            colorCode = .brown
            
        case 4, 6, 7:
            colorCode = .red
            
        case 5, 8, 9:
            colorCode = .green
            
        default:
            colorCode = .darkGray
        }
        
        return colorCode
    }
    
}
