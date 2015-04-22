//
//  ViewController.swift
//  HeadzupPOC
//
//  Created by Matt Solano on 4/21/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import UIKit

@IBDesignable class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LoginButtonPressed(sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainNavigation") as? UIViewController
        
        self.presentViewController(vc!, animated: true, completion: nil)
        
    }

}

