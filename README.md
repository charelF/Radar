#  Radar

iOS app that shows activities nearby


07/10/19
todo:
-  callout from annotatio: see if we can insert a custom view or similar, so that we can fit our whole activity presentation inside such a callout.
- include ask for location and center app on users location
- see if its possible to resize the markers

- explore which swift file is the best to store the activity arrays? Right now we can store them in activity.swift in a static function, but how to do it latter on? One class that handles requests maybe and stores an activity array that can be accessed by the different view controllers?


08/10/19
we implemented custom view with this tutorial: https://medium.com/better-programming/swift-3-creating-a-custom-view-from-a-xib-ecdfe5b3a960
todo:
- do a custom callout by desigining the view in the activityview.xib and then implementing that. tutorials: 
    - https://sweettutos.com/2016/03/16/how-to-completely-customise-your-map-annotations-callout-views/ (see example application we downloaded)
    - https://www.raywenderlich.com/548-mapkit-tutorial-getting-started
    
10/10/19
- before implementing the tutorial with the custom map annotaiton view, see if there is no conflict between these methods and then ones we copied previously from raywunderlich, e.g. understand difference between a MKAnnotationView and an MKMarkerAnnotationView and so on


12/10/19
some resources:

https://stackoverflow.com/questions/49703257/mkannotationview-callout-accessory-is-not-getting-displayed-in-ios-11

https://stackoverflow.com/questions/25631410/swift-different-images-for-annotation

https://stackoverflow.com/questions/32581049/mapkit-ios-9-detailcalloutaccessoryview-usage

https://developer.apple.com/documentation/mapkit/mapkit_annotations/annotating_a_map_with_custom_data

https://stackoverflow.com/questions/30793315/customize-mkannotation-callout-view

https://sweettutos.com/2016/03/16/how-to-completely-customise-your-map-annotations-callout-views/




