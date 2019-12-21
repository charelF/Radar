//
//  ActivityTableViewCell.swift
//  Radar
//
//  Created by Charel FELTEN on 02/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityIcon: UILabel!
    @IBOutlet weak var activityTitle: UILabel!
    @IBOutlet weak var activityDescription: UILabel!
    @IBOutlet weak var activityDate: UILabel!
    
    func setActivity(activity: Activity) {
        activityIcon.text = activity.emoji
        activityTitle.text = activity.name
        activityDescription.text = activity.desc
        activityDate.text = Time.stringFromDate(from: activity.activityTime)
    }
}
