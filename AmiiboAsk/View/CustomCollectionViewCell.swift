//
//  CustomCollectionViewCell.swift
//  AmiiboAsk
//
//  Created by ItandehuiP on 6/6/19.
//  Copyright © 2019 ItandehuiP. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePortrait: UIImageView!
    
    @IBOutlet weak var headName: UILabel!
    
    @IBOutlet weak var subheadName: UILabel!
    
    override func awakeFromNib() {
        
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2.0
        self.layer.borderColor = ColorPalette().secondaryLightColor.cgColor
        
    }
}
