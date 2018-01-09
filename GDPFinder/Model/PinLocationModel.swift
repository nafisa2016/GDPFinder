//
//  PinLocationModel.swift
//  GDPFinder
//
//  Created by Nafisa Rahman on 1/9/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import Foundation
import MapKit

class PinLocationModel : NSObject, MKAnnotation{
    
    var title : String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    init (title: String, coordinate : CLLocationCoordinate2D ) {
        
        self.title = title
        self.coordinate = coordinate
        super.init()
        
    }
}

