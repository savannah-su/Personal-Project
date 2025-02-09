//
//  KingFisherWrapper.swift
//  Furry
//
//  Created by Savannah Su on 2020/3/2.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(_ urlString: String?, placeHolder: UIImage? = nil) {
        
        guard urlString != nil, let url = URL(string: urlString!) else {
            
            self.image = placeHolder
            
            return
            
        }
        
        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
