//
//  ViewController.swift
//  HeadzupPOC
//
//  Created by Matt Solano on 4/21/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import UIKit

@IBDesignable class ViewController: UIViewController {

    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var pinTF: UITextField!
    
    @IBOutlet weak var feedbackLB: UILabel!
    var theConnnection: NSURLConnection?
    
    var webServiceData:NSMutableData?
    
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LoginButtonPressed(sender: UIButton) {
       
        let userPhoneNumber = phoneNumberTF.text
        let userPassword = pinTF.text
        
        
        
        if(userPhoneNumber.isEmpty || userPassword.isEmpty)
        {
            displayAlertMessage("All fields are required.")
            return
        }
        
        let parametersString = "email=\(userPhoneNumber)&password=\(userPassword)"
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
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainNavigation") as? UIViewController
            
            self.presentViewController(vc!, animated: true, completion: nil)
        }
        else
        {
            feedbackLB.text = "Wrong credential, try again"//jsonDict["Message"] as! String!
            
        }
        
    }

    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
        println("connection failed \(error.description))")
        
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

