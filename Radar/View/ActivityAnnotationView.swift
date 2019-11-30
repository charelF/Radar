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
            guard let activityWrapper = newValue as? ActivityWrapper else { return }
            let activity = activityWrapper.activity
            canShowCallout = false
            
            // 2
            markerTintColor = UIColor.white
            glyphText = String(activity.emoji)
            
            titleVisibility = .hidden
            subtitleVisibility = .hidden
            
            clusteringIdentifier = "1"
        }
    }
    
    // the two functions below are used to detect whether we click an element inside the activity view or the map
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if (hitView != nil)
        {
            self.superview?.bringSubviewToFront(self)
        }
        return hitView
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.bounds
        var isInside: Bool = rect.contains(point)
        if(!isInside)
        {
            for view in self.subviews
            {
                isInside = view.frame.contains(point)
                if isInside
                {
                    break
                }
            }
        }
        return isInside
    }
}
