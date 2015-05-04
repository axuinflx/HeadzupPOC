//
//  MainViewController.swift
//  HeadzupPOC
//
//  Created by Matt Solano on 4/21/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var FaceCollectionView: UICollectionView!
    
    
    let facesArray = ["Face1", "Face2", "Face3"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logout(sender: AnyObject) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login") as? UIViewController
        
        self.presentViewController(vc!, animated: true, completion: nil)
        
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return facesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:faceCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("faceCollectionViewCell", forIndexPath: indexPath) as! faceCollectionViewCell
        
        let faceType = facesArray[indexPath.row]
        cell.cellImageView.image = UIImage(named: faceType)
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: FaceCollectionView.bounds.size.width - 20, height: FaceCollectionView.bounds.size.height)
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("\(indexPath.row)")
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
        //scrollView.
        var visibleFace = FaceCollectionView.indexPathsForVisibleItems()
        var cells = FaceCollectionView.visibleCells()
        
        var idx = FaceCollectionView.indexPathForCell(cells[cells.count - 1] as! UICollectionViewCell)

        println("visible = \(visibleFace)")
        println("idx = \(idx!.row)")
        
        
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
