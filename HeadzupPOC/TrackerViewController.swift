//
//  TrackerViewController.swift
//  HeadzupPOC
//
//  Created by Matt Solano on 4/21/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import UIKit

class TrackerViewController: UIViewController {
    
    
    
    @IBOutlet weak var painIntensityLabel: UILabel!
    @IBOutlet weak var painIntensitySlier: UISlider!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func CancelButtonPressed(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    @IBAction func intensityChanged(sender: UISlider) {
        
        painIntensityLabel.text = NSString(format: "%.0f", sender.value) as String
        
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
