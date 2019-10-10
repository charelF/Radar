//
//  ActivityAnnotationView.swift
//  Radar
//
//  Created by Charel FELTEN on 07/10/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import UIKit
import MapKit

// copied from: https://www.raywenderlich.com/548-mapkit-tutorial-getting-started

class ActivityAnnotationView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let activity = newValue as? Activity else { return }
            canShowCallout = false
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // 2
            markerTintColor = UIColor(red:1, green: 1, blue: 1, alpha: 1)
            glyphText = String(activity.emoji)
            
            
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
