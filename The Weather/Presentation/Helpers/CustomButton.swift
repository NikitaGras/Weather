//
//  ButtonWithShadow.swift
//  The Weather
//
//  Created by Nikita Gras on 08.03.2021.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            self.layer.shadowColor = shadowColor?.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.layer.masksToBounds = false
        
        //self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: -10, height: -10)
        self.layer.shadowRadius = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForInterfaceBuilder() {
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: -10, height: -10)
        self.layer.shadowRadius = 0
    }
}
