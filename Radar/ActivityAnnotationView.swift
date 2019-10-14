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
//            calloutOffset = CGPoint(x: -5, y: 5)
//            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            leftCalloutAccessoryView = UISwitch()
            // 2
            markerTintColor = UIColor(red:1, green: 1, blue: 1, alpha: 1)
            glyphText = String(activity.emoji)
            
            titleVisibility = .adaptive
            subtitleVisibility = .hidden
//
//
//            let detailLabel = UILabel()
//            detailLabel.numberOfLines = 0
//            detailLabel.font = detailLabel.font.withSize(12)
//            detailLabel.text = activity.subtitle
//            //detailCalloutAccessoryView = detailLabel
//
//            //titleVisibility = .hidden
//            subtitleVisibility = .hidden
//
//            //self.addSubview(detailLabel)
//
////            let emojiLabel = UILabel()
////            emojiLabel.numberOfLines = 0
////            emojiLabel.font = emojiLabel.font.withSize(20)
////            emojiLabel.text = activity.emoji
////            leftCalloutAccessoryView = emojiLabel
//
////            let frame = CGRect(x: 10, y: 10, width: 50, height: 50)
////
////            let blueSquare = UIView(frame: frame)
////            blueSquare.backgroundColor = UIColor.blue
////
////            detailCalloutAccessoryView = blueSquare
//
//
//
//
        }
    }
    
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

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


