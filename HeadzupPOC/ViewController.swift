//
//  ViewController.swift
//  HeadzupPOC
//
//  Created by Matt Solano on 4/21/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import UIKit
import CoreData

@IBDesignable class ViewController: UIViewController {

    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var pinTF: UITextField!
    
    @IBOutlet weak var feedbackLB: UILabel!
    var theConnnection: NSURLConnection?
    
    var webServiceData:NSMutableData?
    var dataMgr: DataManager?  // initialized in viewDidLoad
    //var loginStatus :String?
    var userPhoneNumber : String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // local notification
        var locNotification: UILocalNotification = UILocalNotification()
        locNotification.alertAction = "Check Daily Challenge"
        locNotification.alertBody = "Check your daily challenge"
        locNotification.fireDate = NSDate(timeIntervalSinceNow: 30)
        //locNotification.
        UIApplication.sharedApplication().scheduleLocalNotification(locNotification)
        
        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        
        if AppContext.loginStatus == LoginStatus.LoggedOut {
            println ("user has logged out")
            self.phoneNumberTF.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        if AppContext.loginStatus == LoginStatus.LoggedIn {
            println ("user has logged in")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TabBarController") as? UIViewController
            
            self.presentViewController(vc!, animated: true, completion: nil)

        }
    }
    
    func testMetaData() {
        
        /*
         // save
            let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
            
            var newMetaData:MetaData = NSEntityDescription.insertNewObjectForEntityForName("MetaData", inManagedObjectContext: manObjContext) as! MetaData
            
            newMetaData.name = "Phone"
        newMetaData.value = "1234567890"
        newMetaData.isSecured = false
            
            println("New meta created: \(newMetaData.description)")
            
            manObjContext.save(nil)
        
        // read
       
        let fetchRequest = NSFetchRequest(entityName: "MetaData")
        var mlist = manObjContext.executeFetchRequest(fetchRequest, error: nil)!
        */
        
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        
        var dm = DataManager(objContext: manObjContext)
        dm.saveMetaData(MetaDataKeys.PIN, value: "333", isSecured: false)
        
        var m = dm.getMetaData(MetaDataKeys.PIN)
        
        
    }

    @IBAction func LoginButtonPressed(sender: UIButton) {
       
        
        //testMetaData()
        
        
        let userPassword = pinTF.text
        
        if AppContext.loginStatus == LoginStatus.LoggedOut  {
            var m = dataMgr?.getMetaData(MetaDataKeys.PhoneNumber)
            if m != nil {
                userPhoneNumber = m?.value
            }
        } else {
            userPhoneNumber = phoneNumberTF.text
        }
        
        if((userPhoneNumber!.isEmpty && AppContext.loginStatus == LoginStatus.NeverLoggedIn) || userPassword.isEmpty)
        {
            displayAlertMessage("All fields are required.")
            return
        }
        
        let parametersString = "email=\(userPhoneNumber!)&password=\(userPassword)"
        var url:String = "http://10.200.20.86/api/mobileservice/Login?\(parametersString)"
        
        let theURL = NSURL(string: url)!
        var req:NSURLRequest = NSURLRequest(URL: theURL)
        
        theConnnection = NSURLConnection(request: req, delegate: self, startImmediately: true)
        
        
        
        
    }
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse)
    {
        webServiceData = NSMutableData()
        
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData)
    {
        webServiceData?.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        let JsonStr = NSString(data: webServiceData!, encoding: NSUTF8StringEncoding)
        
        println("json = \(JsonStr)")
        
        var jsonDict =  NSJSONSerialization.JSONObjectWithData(webServiceData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        println("jsonDict = \(jsonDict)")
        
        var status = jsonDict["Status"] as! NSInteger!
        
        if(status == 1)
            
        {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TabBarController") as? UIViewController
            
            // save user info to local 
            dataMgr?.saveMetaData(MetaDataKeys.PhoneNumber, value: userPhoneNumber!, isSecured: true)
            dataMgr?.saveMetaData(MetaDataKeys.PIN, value: pinTF.text, isSecured: true)
            dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedIn, isSecured: true)
            
            
            // list all meta data
            var ms  = dataMgr?.getAllMetaData()
            
            self.presentViewController(vc!, animated: true, completion: nil)
        }
        else
        {
            feedbackLB.text = "Wrong credential, try again"//jsonDict["Message"] as! String!
            
            var location: LogLocation = FileLocation.getInstance("log.txt");
            //location = ConsoleLocation();
            var logger = Logger(name: "FileTester", level: .TRACE, logLocation: location);
          
            logger.error("Wrong credential, try again");
            
            
        }
        
    }

    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
        var location: LogLocation = FileLocation.getInstance("log.txt");
        //location = ConsoleLocation();
        var logger = Logger(name: "FileTester", level: .TRACE, logLocation: location);
        
        logger.error("connection failed \(error.description))");

        //println("connection failed \(error.description))")
        
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
    }

    func displayAlertMessage(userMessage:String)
    {
        var myAlert = UIAlertController(title: "Message", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
}

