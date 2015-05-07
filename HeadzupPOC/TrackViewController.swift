//
//  TrackViewController.swift
//  HeadzupPOC
//
//  Created by Matt Solano on 5/4/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import UIKit
import CoreData

class TrackViewController: UIViewController {

    
    var dataMgr: DataManager? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logout(sender: AnyObject) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login") as? UIViewController
        
        // update login status
         dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedOut, isSecured: true)
        
        
        self.presentViewController(vc!, animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
