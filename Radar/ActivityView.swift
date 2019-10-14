//
//  ActivityView.swift
//  Radar
//
//  Created by Charel FELTEN on 08/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

// this uiview is responsable to manage the ActivityView.xib file
// tutorial from: https://medium.com/better-programming/swift-3-creating-a-custom-view-from-a-xib-ecdfe5b3a960

import UIKit

class ActivityView: UIView {

    //@IBOutlet var contentView: UIView!
    
//    @IBOutlet weak var emojiLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    private func commonInit() {
//
//        Bundle.main.loadNibNamed("ActivityView", owner: self, options: nil)
//        addSubview(contentView)
//        contentView.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//
//        self.layer.cornerRadius = 10
//        self.layer.masksToBounds = true
//
//    }
}
