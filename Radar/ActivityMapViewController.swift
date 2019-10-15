//
//  ActivityMapViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 05/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

// a lot of the mapkit stuff is learned from
// https://www.raywenderlich.com/548-mapkit-tutorial-getting-started

// some of the mapkit stuff is from a tutorial from:
// https://sweettutos.com/2016/03/16/how-to-completely-customise-your-map-annotations-callout-views/


import UIKit
import CoreLocation
import MapKit

class ActivityMapViewController: UIViewController, MKMapViewDelegate {

    // add MKmapview and drag it also to here and tag it as an outlet
    @IBOutlet weak var mapView: MKMapView!
    
    // add long press gesture from object library and drag it from the the storyboard to here and tag it as outlet
    @IBOutlet var mapLongPressOutlet: UILongPressGestureRecognizer!
    
    
    
    var activities: [Activity] = Activity.testActivities()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this VC becomes a mapview delegate
        self.mapView.delegate = self
        
        // also copied from mapkit tutorial
        mapView.register(ActivityAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        mapView.addAnnotations(activities)
        
        print("viewDidLoad called")

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
    
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    
    
    
    
    
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        
//        let bundle = Bundle(for: self)
//        let nib = UINib(nibName: String(describing:self), bundle: bundle)
//        return nib.instantiate(withOwner: nil, options: nil).first as! MyView
        
            
        let activity = view.annotation as! Activity
        let views = Bundle.main.loadNibNamed("ActivityView", owner: nil, options: nil)
        let activityView = views?[0] as! ActivityView
        
        // mapping activity properties to activity view ui elements
        print(activity.name)
        activityView.titleLabel.text = activity.name
        activityView.emojiLabel.text = activity.emoji
        activityView.dateLabel.text = "this afternoon"
        activityView.descriptionTextView.text = activity.desc

//        let button = UIButton(frame: activityView.starbucksPhone.frame)
//        button.addTarget(self, action: #selector(ViewController.callPhoneNumber(sender:)), for: .touchUpInside)
//        activityView.addSubview(button)
        // 3
        
        
        activityView.center = CGPoint(x: view.bounds.size.width / 2, y: -activityView.bounds.size.height*0.37)
        view.addSubview(activityView)
        
        // ugly way of doing it but it does what it should do, i.e. center the opening activityView
        // instead of centering the annotation pin
        var annotationCoordinate = view.annotation?.coordinate
        annotationCoordinate?.latitude += 0.2
        mapView.setCenter(annotationCoordinate!, animated: true)
        print("arrived here")
    }
    
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view is ActivityAnnotationView {
            for subview in view.subviews {
                // circumvents the problem of the annotation being removed, however it does not
                // solve the actual bug: why it was removed here, and not in the example
                if subview is ActivityView {
                    subview.removeFromSuperview()
                }
            }
        }
    }
}


