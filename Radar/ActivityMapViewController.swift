//
//  ActivityMapViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 05/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ActivityMapViewController: UIViewController {

    // add MKmapview and drag it also to here and tag it as an outlet
    @IBOutlet weak var mapView: MKMapView!
    
    // add long press gesture from object library and drag it from the the storyboard to here and tag it as outlet
    @IBOutlet var mapLongPressOutlet: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // add long press gesture from object library and drag it from the the storyboard to here and tag it as action
    @IBAction func mapLongPressAction(_ sender: Any) {
        print("long press detected")
        print(mapLongPressOutlet.state.rawValue)
        
        
        if mapLongPressOutlet.state == .began {
            let currentFingerLocation = mapLongPressOutlet.location(in: mapView)
            let currentMapLocation = mapView.convert(currentFingerLocation, toCoordinateFrom: mapView)
            print(currentFingerLocation)
            print(currentMapLocation) // works as expected
            
            // we will now move to the add activity view controller, as described in this article
            // https://appsandbiscuits.com/move-between-view-controllers-with-segues-ios-9-7e231159e8f4
            
             performSegue(withIdentifier: "addActivitySegue", sender: self)
        }
    }
    
    // this is the default implementation, which does not work on iphone as by default, popovers are displayed as fullscreen
    // we have to work around this limitation
//    @IBAction func displayPopover(_ sender: UIButton) {
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "AddAcitvityPopoverViewController") // do not forget to override the identifier
//        vc.modalPresentationStyle = .popover
//        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
//        //popover.barButtonItem =
//        present(vc, animated: true, completion:nil)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
