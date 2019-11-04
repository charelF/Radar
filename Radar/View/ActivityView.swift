//
//  ActivityView.swift
//  Radar
//
//  Created by Charel FELTEN on 08/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

// this uiview is responsable to manage the ActivityView.xib file
// tutorial from: https://medium.com/better-programming/swift-3-creating-a-custom-view-from-a-xib-ecdfe5b3a960
// however this is wrong!
// here is the correct way: https://medium.com/@ingun37/using-xib-in-storyboard-you-are-doing-it-wrong-how-to-use-xib-in-storyboard-ios-dd1b427a2247
// summary: do as shown below, do not set this UIVIEW as the files owner of the XIB!

import UIKit

class ActivityView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var delegate: ActivityViewDelegate?
    
    
    static func loadViewFromNib() -> ActivityView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: String(describing:self), bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as! ActivityView
        
    }
    
    override func awakeFromNib() {
        // why? -> https://stackoverflow.com/a/28385946
        super.awakeFromNib()
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        //button.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        

        
//        self.layer.shadowPath =
//              UIBezierPath(roundedRect: self.bounds,
//              cornerRadius: self.layer.cornerRadius).cgPath
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.25
//        self.layer.shadowOffset = CGSize(width: 0, height: 0)
//        self.layer.shadowRadius = 2
//        self.layer.masksToBounds = false
        
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.25
        
        //self.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        //self.layer.bounds = CGRect(x:0, y:0, width: 250, height: 500)
//        commonInit()
    }
    
    
    @IBAction func buttonPress(_ sender: Any) {
        delegate?.action()
    }
    
    
}


protocol ActivityViewDelegate {
    // using delegate pattern -> https://stackoverflow.com/a/45936716/9439097
    func action()
}
