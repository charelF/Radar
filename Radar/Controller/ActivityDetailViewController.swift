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
    
    var activityID: String? = nil
    var activity: Activity? {
        get {
            // if ID is not set, return nil
            return DataBase.data.activities[activityID ?? ""]
        }
    }
    
    @IBOutlet weak var participateSwitch: UISwitch!
    @IBOutlet weak var participateLabel: UILabel!
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
        participateSwitch.isOn = activity!.participantIDs.contains(DataBase.data.user.id)
        participateLabel.text = participateSwitch.isOn ? "You are participating!" : "Join this activity!"
    }
    
    @IBAction func participateSwitch(_ sender: Any) { DataBase.data.switchActivityParticipation(for: activityID!, completion: {
            self.viewDidLoad()
        })
    }
    
}
