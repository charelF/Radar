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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var emojiLabel: UILabel!
    
    static func loadViewFromNib() -> ActivityView {
        print(self)
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: String(describing:self), bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as! ActivityView
        
    }
    
    
    
    
    
    
    
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("this initialiser was called")
        
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
//
//        self.layer.shadowPath =
//              UIBezierPath(roundedRect: self.bounds,
//              cornerRadius: self.layer.cornerRadius).cgPath
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize(width: 0, height: 0)
//        self.layer.shadowRadius = 1
//        self.layer.masksToBounds = false
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        
        //elf.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        //self.layer.bounds = CGRect(x:0, y:0, width: 250, height: 500)
//        commonInit()
    }
//
//    private func commonInit() {
//
//        print("common init was called")
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
