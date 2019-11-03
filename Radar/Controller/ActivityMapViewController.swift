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
    
    var mapCoordinates: CLLocationCoordinate2D? = nil
    
    
    
    var activities: [Activity] = []
    
    override func viewDidLoad() {
        print("view did load was called")
        super.viewDidLoad()
        
        // this VC becomes a mapview delegate
        self.mapView.delegate = self
        
        // also copied from mapkit tutorial
        mapView.register(ActivityAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
//        activities = ActivityHandler.instance.activityList
//        mapView.addAnnotations(activities)
        
        print("viewDidLoad called")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        
        activities = ActivityHandler.instance.activityList
        print(activities)
        
        mapView.addAnnotations(activities)
        
        super.viewWillAppear(animated)
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
            
            mapCoordinates = currentMapLocation
            
            // we will now move to the add activity view controller, as described in this article
            // https://appsandbiscuits.com/move-between-view-controllers-with-segues-ios-9-7e231159e8f4
             performSegue(withIdentifier: "addActivitySegue", sender: self)
        }
    }
    
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let navigationController = segue.destination as? UINavigationController {
            if let receiver = navigationController.topViewController as? AddActivityTableViewController {
            
                if mapCoordinates == nil {
                    print("problem")
                } else {
                    receiver.mapCoordinates = mapCoordinates
                }
            }
        }
    }
    
    
    
    func zoomAndCenter(on centerCoordinate: CLLocationCoordinate2D, zoom: Double) {
        var span: MKCoordinateSpan = mapView.region.span
        span.latitudeDelta *= zoom
        span.longitudeDelta *= zoom
        let region: MKCoordinateRegion = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
                
        if view.annotation is MKClusterAnnotation {
            
            // zoom and center on marker
            zoomAndCenter(on: (view.annotation?.coordinate)!, zoom: 0.25)
            
            // deselect marker as we are not interested in it and want to possibly continue zooming
            mapView.deselectAnnotation(view.annotation, animated: false)
            
            return
        }
        
            
        let activity = view.annotation as! Activity
        let views = Bundle.main.loadNibNamed("ActivityView", owner: nil, options: nil)
        let activityView = views?[0] as! ActivityView
        
        // mapping activity properties to activity view ui elements
        print(activity.name)
        activityView.titleLabel.text = activity.name
        activityView.emojiLabel.text = activity.emoji
        activityView.dateLabel.text = ActivityHandler.getDescriptiveTime(from: activity.activityTime)
        activityView.descriptionTextView.text = activity.desc
        
        // adding the view
        view.addSubview(activityView)

//        let button = UIButton(frame: activityView.starbucksPhone.frame)
//        button.addTarget(self, action: #selector(ViewController.callPhoneNumber(sender:)), for: .touchUpInside)
//        activityView.addSubview(button)
        // 3
        
        // we center the activity view a bit on the annotation (actually a bit lower)
        activityView.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height*0.37)
        
        // we center the map on a point that is 50px above the annotation so that the activity view is more centered
        var pointOfAnnotationCoord = mapView.convert((view.annotation?.coordinate)!, toPointTo: mapView)
        pointOfAnnotationCoord.y -= 50
        let coordOfPoint = mapView.convert(pointOfAnnotationCoord, toCoordinateFrom: mapView)
        mapView.setCenter(coordOfPoint, animated: true)
//        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
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
    
//    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
//
//        print("--- called")
//
//        var clusterAnnotation = MKClusterAnnotation(memberAnnotations: memberAnnotations)
//
//        return clusterAnnotation
//    }

    // crash when clicking on cluster --> https://forums.developer.apple.com/message/271061#271061
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print("function mapview called")
//        if annotation is MKClusterAnnotation {
//            return mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier, for: annotation)
//        } else if annotation is Activity {
//            return mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
//        } else {
//            return nil
//        }
//    }
}


