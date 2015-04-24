//
//  TrackerHistoryViewController.swift
//  HeadzupPOC
//
//  Created by Matt Solano on 4/24/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import UIKit
import CoreData

class TrackerHistoryViewController: UIViewController {
    
    
    
    var trackerInstancesArray:Array<AnyObject> = []
    
    let pointWidth: CGFloat = 15
    let pointGutter: CGFloat = 10
    var pointLeft: CGFloat = 0

    @IBOutlet weak var graphOuterView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the stored Tracker Instances
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "TrackerInstance")
        trackerInstancesArray = manObjContext.executeFetchRequest(fetchRequest, error: nil)!
        // ---------------------------------
        
        
        self.view.clipsToBounds = true
        graphOuterView.clipsToBounds = true
        
        var totalInstances = CGFloat(trackerInstancesArray.count)
        
        for (index, instance) in enumerate(trackerInstancesArray) {
            
            //let pointHeight: CGFloat = pointWidth
            let pointHeight: CGFloat = 240
            
            var thisInstance = instance as! TrackerInstance
            var pointTop = 240 - (thisInstance.painIntensity * 24)
            
            let newPointView = UIView(frame: CGRectMake(pointLeft, CGFloat(pointTop), pointWidth, pointHeight))
            newPointView.backgroundColor = UIColor(red: 80/255, green: 67/255, blue: 117/255, alpha: 1)
            
            graphOuterView.addSubview(newPointView)
            
            pointLeft = pointLeft + pointWidth + pointGutter
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
