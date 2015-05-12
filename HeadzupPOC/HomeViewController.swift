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
    
    let facesArray = ["Face1", "Face2", "Face3"]
//    let swipeGestureRecognizer = UISwipeGestureRecognizer()
    var currentIndex = 0
    
    
    
    struct Face {
        let faceView: FaceView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var currentFace = facesArray[currentIndex]
        var firstFace = createFace(currentFace)
        
        //swipeGestureRecognizer.addTarget(self, action: "swipeAction:")
        //firstFace.faceView.addGestureRecognizer(swipeGestureRecognizer)
        
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

    
    @IBAction func SwipedLeft(sender: UISwipeGestureRecognizer) {
        println("swiped")
        
        for view in FaceOuterView.subviews as! [UIView] {
            
            println(FaceOuterView.subviews.count)
            
            var viewDesc = view.description
            println("\(viewDesc)")
            
            
            
            UIView.animateWithDuration(1.4, animations: {
                view.transform = CGAffineTransformMakeTranslation(-214, 0)
            }, completion: { finished in
                view.removeFromSuperview()
                var newFace = self.createFace("Face2")
                newFace.faceView.frame.origin.x = 214
                self.FaceOuterView.addSubview(newFace.faceView)
                
                UIView.animateWithDuration(0.4, animations: {
                   newFace.faceView.transform = CGAffineTransformMakeTranslation(-214, 0)
                }, completion: nil)
                
                
            })
            
        }
        
        
        
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
