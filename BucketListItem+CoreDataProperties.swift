//
//  BucketListItem+CoreDataProperties.swift
//  bucketListCoreData
//
//  Created by admin on 15/12/2021.
//
//

import Foundation
import CoreData


extension BucketListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BucketListItem> {
        return NSFetchRequest<BucketListItem>(entityName: "BucketListItem")
    }

    @NSManaged public var item: String?
    @NSManaged public var id: String?

}

extension BucketListItem : Identifiable {

}
