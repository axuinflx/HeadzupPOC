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
            theMetaData = fetchResults?[0]
            println("found metadata \(theMetaData.toString())")
        } else {
            println("creating new metadata: \(name) : \(value)")
            theMetaData = NSEntityDescription.insertNewObjectForEntityForName("MetaData", inManagedObjectContext: dbContext) as! MetaData
        }
        
        theMetaData.name = name
        theMetaData.value = value
        theMetaData.isSecured = isSecured

        dbContext.save(nil)
        println("meta saved: \(theMetaData.toString())")
    }
    
     public func getMetaData(name: String) -> MetaData?{
        // check if given meta exists
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        fetchRequest.predicate = NSPredicate(format: "name == \"\(name)\"")
        
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [MetaData]
        
        var theMetaData:MetaData? = nil
        
        if (fetchResults?.count>0){
            theMetaData = fetchResults?[0]
            let m :MetaData! = fetchResults?[0]
            println("found metadata \(m.toString())")
        } else {
            println("Cannot find matching MetaData for name \(name)")
        }
        return theMetaData
    }
    
    // Return meta data string value. Empty string will be return if such meta data doesn't exist
    public func getMetaDataValue(name: String) -> String {
        
        var m = getMetaData(name)
        if m != nil {
            return m!.value
        }
        return ""
    }
    
    public func getAllMetaData() -> [MetaData]?{
        // check if given meta exists
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        let fetchResults = dbContext!.executeFetchRequest(fetchRequest, error: nil) as? [MetaData]
        
        var c: Int! = fetchResults?.count
        
        var s = "found \(c) metedata "
        var m:MetaData!
        
        for var i = 0; i < c; i++ {
            m = fetchResults?[i]
            s += m.toString() + " "
        }
        println("\(s)")
        return fetchResults
    }
}