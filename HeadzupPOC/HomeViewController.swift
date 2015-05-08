//
//  HomeViewController.swift
//  HeadzupPOC
//
//  Created by Matt Solano on 5/4/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var FaceOuterView: UIView!
    
    struct Face {
        let faceView: FaceView
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var firstFace = createFace("Face1")
        FaceOuterView.addSubview(firstFace.faceView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func createFace(image: String) -> Face {
        let faceView = FaceView()
        faceView.image = image
        return Face(faceView:faceView)
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
