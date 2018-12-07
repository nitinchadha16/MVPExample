//
//  MenuDetailPresenter.swift
//  MvpSample
//
//  Created by Rahul Kapoor on 10/05/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import Foundation

/*
 * Protocol Methods which are responsible for UI updates
 */
@objc protocol MenuDetailViewProtocol : NSObjectProtocol {
    
    // To know when request is started
    func onRequestStarted()
    
    // To inform when we receievd menu details
    func onMenuDetailsReceived(menuDetails : [MenuDetailModel])
    
    // To inform on UI that we received error in request
    func onReceivedError()
    
}

protocol MenuDetailInteractor {
    
    /*
     This method will get details from server which could be time consuming
     */
    func getMenuForCustomer()
    
    /*
     * To stop UI for getting future updates
     */
    func detachView()
    
}

@objcMembers
class MenuDetailPresenter : NSObject, MenuDetailInteractor, MenuRequestProtocol {
    
    weak var view : MenuDetailViewProtocol?
    
    /*
     * Custom constructor for attaching view
     */
    required init(view: MenuDetailViewProtocol) {
        self.view = view
    }
    
    func getMenuForCustomer() {
        
        if(isViewAdded()) {
            self.view!.onRequestStarted()
            MenuRequestFetcher.getDetails(requestProtocol: self)
        } else {
            print("View is not added")
        }
    }
    
    func detachView() {
        self.view = nil
    }
    
    private func isViewAdded() -> Bool {
        return self.view != nil
    }
    
    // MARK : Delegate method of Server Request
    
    func onMenuReceived(details:[MenuDetailModel]) {
        
        if(isViewAdded()) {
            
            self.view!.onMenuDetailsReceived(menuDetails: details)
        } else {
            print("View is not added")
        }
    }
    
    func onErrorReceived(error: NSError) {
        
        if(isViewAdded()) {
            self.view!.onReceivedError()
            
        } else {
            print("View is not added")
        }
    }
    
}


