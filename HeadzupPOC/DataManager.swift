import Foundation
import CoreData

public class DataManager
{
    var dbContext: NSManagedObjectContext!
    //Set IV and Key
    let iv:[UInt8] = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
    let key:[UInt8] = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
    
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
        
        //if Security is enabled, encrypt the value
        if(isSecured == true)
        {
            //encrypt value
            let encryptedValue = CryptoUtil().getEncryptedData(value, iv: iv, key: key)
            
            theMetaData.value = encryptedValue
        }
        else
        {
            theMetaData.value = value
        }
        //theMetaData.value = value
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
            if(theMetaData?.isSecured == true)
            {
                //encrypt value
                var decryptedValue = CryptoUtil().getDecryptedData(theMetaData!.value, iv: iv, key: key)
                theMetaData?.value = decryptedValue as String
                
            }
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