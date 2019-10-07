//
//  AddAcitvityPopoverViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 06/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit

class AddAcitvityPopoverViewController: UIViewController {
    
    // popover designed with the help of: https://www.youtube.com/watch?v=S5i8n_bqblE
    
    // the view itself:
    @IBOutlet weak var addActivityPopoverView: UIView!
    
    // the activity type view inside the main view
    @IBOutlet weak var activityTypeView: UIView!
    
    @IBOutlet weak var nextActivityTypeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addActivityPopoverView.layer.cornerRadius = 10
        
        // masks all content of uiview to its constraints, aka the rounded corners
        addActivityPopoverView.layer.masksToBounds = true
        
        // same for the activity type view
        activityTypeView.layer.cornerRadius = 10
        activityTypeView.layer.masksToBounds = true
        
        nextActivityTypeView.layer.cornerRadius = 10
        nextActivityTypeView.layer.masksToBounds = true
        
    }
    
    
    // cancel button on the top left
    @IBAction func closeAAPopoverView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
