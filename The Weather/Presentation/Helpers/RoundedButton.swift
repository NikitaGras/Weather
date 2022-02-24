//
//  RoundedButton.swift
//  The Weather
//
//  Created by Nikita Gras on 08.03.2021.
//

import UIKit

class RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // вызывается когда весь элемент сверстан
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
}
