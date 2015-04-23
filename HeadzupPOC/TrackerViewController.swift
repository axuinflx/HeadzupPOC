//
//  TrackerViewController.swift
//  HeadzupPOC
//
//  Created by Matt Solano on 4/21/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import UIKit
import CoreData

class TrackerViewController: UIViewController {
    
    
    
    @IBOutlet weak var painIntensityLabel: UILabel!
    @IBOutlet weak var painIntensitySlider: UISlider!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func intensityChanged(sender: UISlider) {
        
        painIntensityLabel.text = NSString(format: "%.0f", sender.value) as String
        
    }
    
    
    @IBAction func sliderChanged(sender: UISlider) {
        
        var sliderValue: Int
        sliderValue = lroundf(sender.value)
        painIntensitySlider.setValue(Float(sliderValue), animated: true)
        
    }
    
    @IBAction func submitTrackerPressed(sender: UIButton) {
        
        saveTrackerInstance(painIntensitySlider.value)
        
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    
    func saveTrackerInstance(intensityValue: Float){
        
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        
        var newTrackerInstance:TrackerInstance = NSEntityDescription.insertNewObjectForEntityForName("TrackerInstance", inManagedObjectContext: manObjContext) as! TrackerInstance
        
        newTrackerInstance.painIntensity = intensityValue
        
        println("New instance created: \(newTrackerInstance.description)")
        
        manObjContext.save(nil)
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
