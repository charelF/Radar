//
//  ActivityDetailTableViewCell.swift
//  Radar
//
//  Created by Charel FELTEN on 04/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit

class ActivityDetailTableViewCell: UITableViewCell {
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        let views = Bundle.main.loadNibNamed("ActivityView", owner: nil, options: nil)
//        let activityView = views?[0] as! ActivityView
//
//        //self.addSubview(activityView)
//        self.addSubview(cellView)
//        print("subview \(activityView) has been added to cell view")
    }
    
    let cellView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.cornerRadius  = 15
        view.backgroundColor     = UIColor.clear
        view.layer.shadowColor   = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset  = CGSize.zero
        view.layer.shadowRadius  = 5
        return view
    }()

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
