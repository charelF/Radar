//
//  UITextViewFixed.swift
//  Radar
//
//  Created by Charel FELTEN on 16/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

// simple way to fix UITextViews from having more padding than other UI Elements
// https://stackoverflow.com/questions/746670/how-to-lose-margin-padding-in-uitextview

import UIKit

class UITextViewFixed: UITextView {

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}
