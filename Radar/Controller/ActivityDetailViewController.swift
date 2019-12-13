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
    
    func changeButtonStyle(isUserParticipating) {
        if userParticipating {
            print("changed button style to user participating")
            /
            
            // Note to charel from the future:
            // currently there is a problem: e.g. this view controller has an activity property. it sends it to the database, which updates the activity on the server and everything should work. the problem is that the updated activity (where the user participation choice is now switched) is not yet sent to this viewcontroller, so if we call the function again, it sends the initila activity again to the server, because this VC does not know there is an updated version
            // TODO: somehow we have to update this controllers current copy of the activity... but how? and do we also need to reload our activites array that is stored in the parent of this viewcontroller (or inside the database? because it also does not have the correct version. perhaps easiest is to do that, but even then we need to propagate the changed activity also to this VC
            
            
        }
        
    }
    
    @IBAction func participateButton(_ sender: Any) {
        DataBase.data.switchActivityParticipation(for: activity!, completion: { activity in
            let isUserParticipating = activity.participantIDs.contains(DataBase.data.user.id)
            
            self.changeButtonStyle(isUserParticipating)
        })
    }
    
}
