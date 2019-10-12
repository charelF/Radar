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
        mapView.register(ActivityAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        mapView.addAnnotations(activities)

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
//    func mapView(_ mapView: MKMapView, viewFor activity: MKAnnotation) -> MKAnnotationView? {
//        if activity is MKUserLocation {
//            return nil
//        }
//        var activityView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
//        if annotationView == nil{
//            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
//            annotationView?.canShowCallout = false
//        }else{
//            annotationView?.annotation = annotation
//        }
//        annotationView?.image = UIImage(named: "starbucks")
//        return annotationView
//    }
//    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//
//
//        let views = Bundle.main.loadNibNamed("ActivityView", owner: nil, options: nil)
//        let calloutView = views?[0] as! ActivityView
//        calloutView.titleLabel.text = "test"
//        calloutView.emojiLabel.text = "test"
//        calloutView.dateLabel.text = "test"
//        calloutView.descriptionText.text = "test"
//
////        let button = UIButton(frame: calloutView.starbucksPhone.frame)
////        button.addTarget(self, action: #selector(ViewController.callPhoneNumber(sender:)), for: .touchUpInside)
////        calloutView.addSubview(button)
////         3
////        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
////        view.addSubview(calloutView)
////        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
//    }


}


