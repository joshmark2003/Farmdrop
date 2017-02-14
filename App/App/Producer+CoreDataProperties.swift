//
//  Producer+CoreDataProperties.swift
//  App
//
//  Created by Joshua Thompson on 14/02/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import Foundation
import CoreData

extension Producer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Producer> {
        return NSFetchRequest<Producer>(entityName: "Producer");
    }

    @NSManaged public var producerId: Int
    @NSManaged public var producerName: String?
    @NSManaged public var producerPermalink: String?
    @NSManaged public var producerCreatedAt: String?
    @NSManaged public var producerUpdatedAt: String?
    @NSManaged public var producerImages: NSArray?
    @NSManaged public var producerShortDescription: String?
    @NSManaged public var producerDescription: String?
    @NSManaged public var producerLocation: String?
    @NSManaged public var producerVia_wholesaler: String?
    @NSManaged public var producerWholesaler_name: String?

}
