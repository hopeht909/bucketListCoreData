//
//  TableViewDelegate.swift
//  bucketListCoreData
//
//  Created by admin on 15/12/2021.
//

import UIKit

protocol TableViewDelegate: AnyObject{
    
    func cancelButtonPressed(by controller: AddItemViewController)
    func itemSaved(by controller: AddItemViewController, with text: String, at indexPath: NSIndexPath?)
}
