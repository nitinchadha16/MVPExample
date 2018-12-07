//
//  RestaurantViewController.swift
//  MvpSample
//
//  Created by Rahul Kapoor on 09/05/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import UIKit

class RestaurantViewController: BaseTableViewController, MenuDetailViewProtocol {
    
    var menuDetailPresenter : MenuDetailPresenter?
    
    var menuDetails : [MenuDetailModel] = [MenuDetailModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // To initialize presenter
        initPresenter()
        
        // Next step is to get data from server
//        menuDetailPresenter!.getMenuForCustomer()
    }
    
    private func initPresenter() {
        menuDetailPresenter = MenuDetailPresenter(view: self)
    }
    
    // MARK : Delegate methods of View protocol
    
    func onRequestStarted() {
        print("Started server request")
        showActivityIndicator()
    }
    
    func onReceivedError() {
        print("Received an error from server request")
        DispatchQueue.main.async {
            self.hideActivityIndicator()
        }
    }
    
    func onMenuDetailsReceived(menuDetails: [MenuDetailModel]) {
        print("Received menu details from server")
        DispatchQueue.main.async {
            
            self.hideActivityIndicator()
            
            // Reassign new items and refresh UI
            self.menuDetails = menuDetails
            self.tableView.reloadData()
        }
    }
    
}

