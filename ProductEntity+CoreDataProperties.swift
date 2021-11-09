//
//  ProductEntity+CoreDataProperties.swift
//  
//
//  Created by ZeyadElassal on 09/11/2021.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var desc: String?
    @NSManaged public var category: String?
    @NSManaged public var image: Data?
    @NSManaged public var rating: Double
    @NSManaged public var count: Int32

}
