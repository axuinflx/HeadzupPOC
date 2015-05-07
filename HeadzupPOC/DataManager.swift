import Foundation

import CoreData



public class DataManager
    
{

    var dbContext: NSManagedObjectContext!
    
    
    public init(objContext: NSManagedObjectContext) {
        self.dbContext = objContext
    }
    
    public func saveMetaData(name: String, value: String, isSecured :Bool ){
        // check if given meta exists
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        fetchRequest.predicate = NSPredicate(format: "name == \"\(name)\"")
        
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [MetaData]
        
        var theMetaData:MetaData!
        
        if (fetchResults?.count>0){
           // newMetaData
            println("metadata exists before saving: \(fetchResults?[0])")
            theMetaData = fetchResults?[0]
        } else {
        
        theMetaData = NSEntityDescription.insertNewObjectForEntityForName("MetaData", inManagedObjectContext: dbContext) as! MetaData
        }
        
        theMetaData.name = name
        theMetaData.value = value
        theMetaData.isSecured = isSecured
            
            //println("New meta created: \(theMetaData.description)")
            
            dbContext.save(nil)
           println("New meta created: \(theMetaData.description)")
        
        
    }
    
     public func getMetaData(name: String) -> MetaData?{
        // check if given meta exists
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        fetchRequest.predicate = NSPredicate(format: "name == \"\(name)\"")
        
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [MetaData]
        
        var theMetaData:MetaData? = nil
        
        if (fetchResults?.count>0){
            // newMetaData
            println("found metadata: \(fetchResults?[0])")
            theMetaData = fetchResults?[0]
        } else {
            println("Cannot find matching MetaData with name of \(name)")
        }
        return theMetaData
    }
    
    
    public func getAllMetaData() -> [MetaData]?{
        // check if given meta exists
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [MetaData]
        
        println("found \(fetchResults?.count) meta data")
        return fetchResults
    }
    
    
}