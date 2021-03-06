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
    
    var coreDataManager = CoreDataManager()
    
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
                producerObject = NSEntityDescription.insertNewObject(forEntityName: "Producer", into: coreDataManager.managedObjectContext) as? Producer
            } else {
                
                //Only update if date is different
                if dictProducer["updated_at"] as? String ==  producerObject?.producerUpdatedAt {
                    
                    continue
                }
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
        
        coreDataManager.saveContext()
    }
    
    func getPrducerWithId(producerId: Int) -> Producer? {
        
        let request: NSFetchRequest<Producer> = NSFetchRequest(entityName: "Producer")
        
        let predicate = NSPredicate(format: "producerId == %i", producerId)
        
        request.predicate = predicate
        
        let arrResults = try! coreDataManager.managedObjectContext.fetch(request) as NSArray
        
        if (arrResults.count == 0) {
            
            return nil
        }
        
        let producer = arrResults.firstObject as! Producer
        
        return producer
    }
    
    /**
     Get all producers
     */
    func getAllProducers() -> NSArray? {
        
        let request: NSFetchRequest<Producer> = NSFetchRequest(entityName: "Producer")
        
        do {
            let results = try coreDataManager.managedObjectContext.fetch(request) as NSArray
            
            return results
            
        } catch {
            
            return nil
        }
    }
    
    /**
     Search for producers
     */
    func getProducerWithName(name: String) -> NSArray? {
        
        let request: NSFetchRequest<Producer> = NSFetchRequest(entityName: "Producer")
        
        let predicate = NSPredicate(format: "producerName CONTAINS[cd] %@", name)

        let sortDescriptor = NSSortDescriptor(key: "producerName", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        request.predicate = predicate
        
        do {
            let results = try coreDataManager.managedObjectContext.fetch(request) as NSArray
            
            return results

        } catch {
            
            return nil
        }
    }
}
