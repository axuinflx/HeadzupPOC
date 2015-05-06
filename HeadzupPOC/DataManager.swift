//

//  DataManager.swift

//  HeadzupPOC

//

//  Created by Abebe Woreta on 5/5/15.

//  Copyright (c) 2015 mattSOLANO. All rights reserved.

//



import Foundation

import CoreData



public class DataManager
    
{
    
    
    
    static func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        
        let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles([NSBundle.mainBundle()])!
        
        
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        persistentStoreCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil, error: nil)
        
        
        
        let managedObjectContext = NSManagedObjectContext()
        
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        
        
        return managedObjectContext
        
    }
    
    
    
    public static func saveMetaData(name:NSString, value:NSString, isSecured:Bool, moc:NSManagedObjectContext){
        
        
        
        let managedObjectContext = moc //setUpInMemoryManagedObjectContext()
        
        var newMetaData:MetaData = NSEntityDescription.insertNewObjectForEntityForName("MetaData", inManagedObjectContext: managedObjectContext) as! MetaData
        
        newMetaData.name = name as String
        
        newMetaData.value = value as String
        
        newMetaData.isSecured = isSecured
        
        var error: NSError?
        
        if !managedObjectContext.save(&error){
            
            println("Could not save \(error), \(error?.userInfo)")
            
        }
        
        
        
    }
    
    public static func getMetaData(name:NSString, moc:NSManagedObjectContext)
        
    {
        
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        
        if let fetchresults = moc.executeFetchRequest(fetchRequest, error: nil) as? [MetaData]
            
        {
            
            let searchFilter = NSPredicate(format: "name=\(name as String)")
            
            fetchRequest.predicate = searchFilter
            
        }
        
    }
    
    
    
}





