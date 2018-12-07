//
//  RestaurantViewController+DataSource.swift
//  MvpSample
//
//  Created by Rahul Kapoor on 10/05/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import Foundation
import UIKit

extension RestaurantViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableIdentifier = "defaultCellIdentifier"
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: reusableIdentifier)
        
        if(cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reusableIdentifier)
        }
        
        let menuDetail = menuDetails[indexPath.row]
        
        cell!.textLabel!.text = menuDetail.title
        cell!.textLabel?.textColor = UIUtils.getColorCodeForDish(menuDetail: menuDetail)
        
        cell!.detailTextLabel!.text = menuDetail.subTitle
        
        return cell!
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuDetails.count
    }
    
}
