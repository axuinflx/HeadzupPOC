//
//  FaceView.swift
//  HeadzupPOC
//
//  Created by Matt Solano on 5/7/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import Foundation
import UIKit

class FaceView: UIView {
    
    private let imageView: UIImageView = UIImageView()
    
    var image: String? {
        didSet {
            if let image = image {
                imageView.image = UIImage(named: image)
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

  
    
    private func initialize(){
        imageView.frame.size.width = 153
        imageView.frame.size.height = 214
        self.addSubview(imageView)
    }

}
