//
//  ActivityViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 31/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var activity: Activity? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "activityViewCell", for: indexPath)
        
        cell.textLabel?.text = "comment"
        cell.detailTextLabel?.text = "comment"
        
        return cell
    }
    

    @IBOutlet weak var activityViewContainer: UIView!
    @IBOutlet weak var commentTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let views = Bundle.main.loadNibNamed("ActivityView", owner: nil, options: nil)
        let activityView = views?[0] as! ActivityView
        
        activityView.titleLabel.text = activity?.name
        activityView.emojiLabel.text = activity?.emoji
        activityView.dateLabel.text = Time.stringFromDate(from: activity?.activityTime ?? Date())
        activityView.descriptionTextView.text = activity?.desc
        
        // adding the view
        activityViewContainer.addSubview(activityView)
        
        // centering the view in the container
        activityView.center = activityViewContainer.convert(activityViewContainer.center, from: activityViewContainer.superview)

        // don't forget!!
        commentTableView.dataSource = self
        commentTableView.delegate = self
    }
   
}
