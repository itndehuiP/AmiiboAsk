//
//  CustonButton.swift
//  AmiiboAsk
//
//  Created by ItandehuiP on 6/6/19.
//  Copyright © 2019 ItandehuiP. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2.0
        self.layer.borderColor = ColorPalette().primaryLightColor.cgColor
    }

}
