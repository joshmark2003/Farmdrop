//
//  Producer+CoreDataClass.swift
//  App
//
//  Created by Joshua Thompson on 14/02/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Producer: NSManagedObject {
    
}

public class ProducerManager: NSObject {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /**
     Add new or update producers if already saved.
     */
    func addProducers(arrProducers: NSArray) {
        
        for dictObject in arrProducers {
            
            let dictProducer = (dictObject as! NSDictionary)
            
            //Check for existence
            var producerObject = getPrducerWithId(producerId: dictProducer["id"] as! Int)
            
            if (producerObject == nil) {
                
                // Create a new producer
                producerObject = NSEntityDescription.insertNewObject(forEntityName: "Producer", into: appDelegate.managedObjectContext!) as? Producer
            }
            
            producerObject!.producerId = dictProducer["id"] as! Int
            producerObject!.producerName = dictProducer["name"] as? String ?? ""
            producerObject!.producerPermalink = dictProducer["permalink"] as? String
            producerObject!.producerCreatedAt = dictProducer["created_at"] as? String
            producerObject!.producerUpdatedAt = dictProducer["updated_at"] as? String
            producerObject!.producerImages = dictProducer["images"] as? NSArray
            producerObject!.producerShortDescription = dictProducer["short_description"] as? String
            producerObject!.producerDescription = dictProducer["description"] as? String
            producerObject!.producerLocation = dictProducer["location"] as? String
            producerObject!.producerVia_wholesaler = dictProducer["via_wholesaler"] as? String
            producerObject!.producerWholesaler_name = dictProducer["wholesaler_name"] as? String
            
        }
        // Save to managed object context
        do {
            try appDelegate.managedObjectContext!.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func getPrducerWithId(producerId: Int) -> Producer? {
        
        let request: NSFetchRequest<Producer> = NSFetchRequest(entityName: "Producer")
        
        let predicate = NSPredicate(format: "producerId == %i", producerId)
        
        request.predicate = predicate
        
        let arrResults = try! appDelegate.managedObjectContext!.fetch(request) as NSArray
        
        if (arrResults.count == 0) {
            
            return nil
        }
        
        let producer = arrResults.firstObject as! Producer
        
        return producer
    }
}
