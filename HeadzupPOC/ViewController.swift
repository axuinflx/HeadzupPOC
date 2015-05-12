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
    @IBOutlet weak var nickNameTF: UITextField!
    @IBOutlet weak var FirstTimeCredsView: UIView!
    @IBOutlet weak var feedbackLB: UILabel!
    
    var theConnnection: NSURLConnection?
    var webServiceData:NSMutableData?
    var dataMgr: DataManager?  // initialized in viewDidLoad
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
            //self.phoneNumberTF.hidden = true
            self.FirstTimeCredsView.hidden = true
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

    @IBAction func LoginButtonPressed(sender: UIButton) {
        let userPassword = pinTF.text
        
        if AppContext.loginStatus == LoginStatus.LoggedOut  {
            userPhoneNumber = AppContext.phoneNumber
        } else {
            userPhoneNumber = phoneNumberTF.text
        }
        
        if((userPhoneNumber!.isEmpty && nickNameTF.text.isEmpty && AppContext.loginStatus == LoginStatus.NeverLoggedIn) || userPassword.isEmpty)
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
        
        if(status == 1) // pass authentication
        {
            // update cache and local db
            if AppContext.loginStatus == "" {
                dataMgr?.saveMetaData(MetaDataKeys.PhoneNumber, value: phoneNumberTF.text, isSecured: true)
                dataMgr?.saveMetaData(MetaDataKeys.PIN, value: pinTF.text, isSecured: true)
                dataMgr?.saveMetaData(MetaDataKeys.NickName, value: nickNameTF.text, isSecured: true)
                AppContext.phoneNumber = phoneNumberTF.text
                AppContext.pin = pinTF.text
                AppContext.userName = nickNameTF.text
            }
            dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedIn, isSecured: true)
            AppContext.loginStatus = LoginStatus.LoggedIn
            
            // go to landing page
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TabBarController") as? UIViewController
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

