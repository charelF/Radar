//
//  ActivityView.swift
//  Radar
//
//  Created by Charel FELTEN on 08/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

// this uiview is responsable to manage the ActivityView.xib file
// tutorial from: https://medium.com/better-programming/swift-3-creating-a-custom-view-from-a-xib-ecdfe5b3a960
// however this is not apparently wrong, here is the correct way:
// https://medium.com/@ingun37/using-xib-in-storyboard-you-are-doing-it-wrong-how-to-use-xib-in-storyboard-ios-dd1b427a2247
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
    
    // what is this function used for? -> https://stackoverflow.com/a/28385946
    override func awakeFromNib() {
        super.awakeFromNib()
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        // shadow around activity popup
        self.layer.shadowPath =
              UIBezierPath(roundedRect: self.bounds,
              cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 50
        self.layer.masksToBounds = false
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        delegate?.action()
    }
}

// using delegate pattern to push the activity detail view controller
// from the button on the popup -> https://stackoverflow.com/a/45936716/9439097
protocol ActivityViewDelegate {
    func action()
}


/// Notes to myself:
///how to use this nib inside another view / vc:
///1) define a container view:
//@IBOutlet weak var activityViewContainer: UIView!
//
///2) define this in the view did load:
//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    let views = Bundle.main.loadNibNamed("ActivityView", owner: nil, options: nil)
//    let activityView = views?[0] as! ActivityView
//
//    activityView.titleLabel.text = activity?.name
//    activityView.emojiLabel.text = activity?.emoji
//    activityView.dateLabel.text = Time.stringFromDate(from: activity?.activityTime ?? Date())
//    activityView.descriptionTextView.text = activity?.desc
//
//    // adding the view
//    activityViewContainer.addSubview(activityView)
//
//    // centering the view in the container
//    activityView.center = activityViewContainer.convert(activityViewContainer.center, from: activityViewContainer.superview)
//}
