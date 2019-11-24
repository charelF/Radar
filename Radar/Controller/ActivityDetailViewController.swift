//
//  ActivityDetailViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 23/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit
import MapKit

class ActivityDetailViewController: UIViewController {
    
    var activity: Activity? = nil
    
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var locationMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiLabel.text = activity?.emoji ?? "❌"
        titleLabel.text = activity?.name ?? "///"
        dateLabel.text = Time.stringFromDate(from: activity?.activityTime ?? Date())
        descriptionTextView.text = activity?.desc ?? "///"
        
    }
    
    @IBAction func participateButton(_ sender: Any) {
        print("participated")
    }
    
}
