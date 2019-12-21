//
//  ActivityMapViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 05/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

// a lot of the mapkit stuff is from:
// https://www.raywenderlich.com/548-mapkit-tutorial-getting-started
// https://sweettutos.com/2016/03/16/how-to-completely-customise-your-map-annotations-callout-views/


import UIKit
import CoreLocation
import MapKit
import PromiseKit

class ActivityMapViewController: UIViewController, MKMapViewDelegate, ActivityViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var mapLongPressOutlet: UILongPressGestureRecognizer!
    var mapCoordinates: CLLocationCoordinate2D? = nil
    var currentlySelectedActivityID: String?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        mapView.register(ActivityAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    // update Annotations by removing all then readding all, not ideal
    func loadAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(ActivityWrapper.wrap(for: DataBase.data.activities))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        DataBase.data.getActivities(completion: {
            self.loadAnnotations()
        })
    }
    
    @IBAction func mapLongPressAction(_ sender: Any) {
        if mapLongPressOutlet.state == .began {
            let currentFingerLocation = mapLongPressOutlet.location(in: mapView)
            let currentMapLocation = mapView.convert(currentFingerLocation, toCoordinateFrom: mapView)
            mapCoordinates = currentMapLocation
            performSegue(withIdentifier: "addActivitySegue", sender: self)
        }
    }
    
    // preparing segue as described here:
    // https://appsandbiscuits.com/move-between-view-controllers-with-segues-ios-9-7e231159e8f4
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addActivitySegue" {
            if let navigationController = segue.destination as? UINavigationController {
                if let receiver = navigationController.topViewController as? AddActivityTableViewController {
                    if mapCoordinates != nil {
                        receiver.mapCoordinates = mapCoordinates
                    }
                }
            }
        } else if segue.identifier == "showActivityFromMap" {
            if let receiver = segue.destination as? ActivityDetailViewController {
                if let activityID = currentlySelectedActivityID {
                    receiver.activityID = activityID
                }
            }
        }
    }
    
    // simultaneously zooms and centers onto a specific coordinate
    func zoomAndCenter(on centerCoordinate: CLLocationCoordinate2D, zoom: Double) {
        var span: MKCoordinateSpan = mapView.region.span
        span.latitudeDelta *= zoom
        span.longitudeDelta *= zoom
        let region: MKCoordinateRegion = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
                
        if view.annotation is MKClusterAnnotation {
            zoomAndCenter(on: (view.annotation?.coordinate)!, zoom: 0.25)
            // deselect marker as we are not interested in it and want to possibly continue zooming
            mapView.deselectAnnotation(view.annotation, animated: false)
            return
        }
        
        let activityWrapper = view.annotation as! ActivityWrapper
        let activity = activityWrapper.activity
        let views = Bundle.main.loadNibNamed("ActivityView", owner: nil, options: nil)
        let activityView = views?[0] as! ActivityView
        activityView.delegate = self
        
        activityView.titleLabel.text = activity.name
        activityView.emojiLabel.text = activity.emoji
        activityView.dateLabel.text = Time.stringFromDate(from: activity.activityTime)
        activityView.descriptionTextView.text = activity.desc
        
        view.addSubview(activityView)
        
        // we store the currently selected activity id for when we switch to the ActivityDetailViewController
        currentlySelectedActivityID = activity.id
        
        activityView.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height*0.37)
        
        // we center the map on a point that is 50px above the annotation
        // so that the activity view is more centered
        var pointOfAnnotationCoord = mapView.convert((view.annotation?.coordinate)!, toPointTo: mapView)
        pointOfAnnotationCoord.y -= 50
        let coordOfPoint = mapView.convert(pointOfAnnotationCoord, toCoordinateFrom: mapView)
        mapView.setCenter(coordOfPoint, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view is ActivityAnnotationView {
            for subview in view.subviews {
                if subview is ActivityView {
                    subview.removeFromSuperview()
                    currentlySelectedActivityID = nil
                }
            }
        }
    }
    
    // this function is called from the popup (ActivityView) itself via the delegate pattern
    func action() {
        performSegue(withIdentifier: "showActivityFromMap", sender: self)
    }
}
