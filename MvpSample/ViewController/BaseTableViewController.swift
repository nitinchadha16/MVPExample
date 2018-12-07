//
//  BaseTableViewController.swift
//  MvpSample
//
//  Created by Rahul Kapoor on 10/05/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewController : UITableViewController {
    
    var indicator : UIActivityIndicatorView?
    
    func showActivityIndicator() {
        
        if(indicator == nil) {
            
            indicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
            indicator!.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
            indicator!.center = self.view.center
            self.view.addSubview(indicator!)
        }
        indicator!.startAnimating()
        indicator!.backgroundColor = UIColor.gray
    }
    
    func hideActivityIndicator() {
        if(indicator != nil) {
            indicator!.stopAnimating()
            indicator!.hidesWhenStopped = true
        }
    }
    
}
