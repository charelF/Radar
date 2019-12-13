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
    
    @IBOutlet weak var participateButtonOutlet: UIButton!
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
    
    func changeButtonStyle() {
        
        if self.activity!.participantIDs.contains(DataBase.data.user.id) {
            participateButtonOutlet.titleLabel!.text = "You have joined!"
        } else {
            participateButtonOutlet.titleLabel!.text = "Join this activity!"
        }
        self.viewDidLoad()
        // in any way, we also reload and collect the updated actitivy
        
    }
    
    @IBAction func participateButton(_ sender: Any) {
        DataBase.data.switchActivityParticipation(for: activityID!, completion: {
            self.changeButtonStyle()
        })
    }
    
}
