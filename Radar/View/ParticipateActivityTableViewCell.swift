//
//  ParticipateActivityTableViewCell.swift
//  Radar
//
//  Created by Charel FELTEN on 06/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit

class ParticipateActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var participatingTitle: UILabel!
    @IBOutlet weak var participatingSubtitle: UILabel!
    
    @IBOutlet weak var participateButton: UISwitch!
    @IBAction func participateButton(_ sender: Any) {
        
        if participateButton.isOn {
            participatingTitle.text = "You are participating!"
        } else {
            participatingTitle.text = "Participate in this activity"
        }
        
    }
    
    

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
