//
//  HandleISOCountry.swift
//  GDPFinder
//
//  Created by Nafisa Rahman on 1/9/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import Foundation
import MapKit

class HandleISOCountry {
    
    weak var GDPdelegate : GDPOperations?
    
    
    //MARK:- get ISO Country code of the country where user has long pressed
    func getISOCountry(pinCoordinate : CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(pinCoordinate, completionHandler: {[weak self](placemarks, error)   -> Void in
            
            if let weakSelf = self{
                
                if error != nil {
                    print("Reverse geocoder failed " + error!.localizedDescription)
                    return
                }
                
                //remove old values
                var oceanName = ""
                var inlandWaterBody = ""
                
                if placemarks!.count > 0 {
                    let placeInfo = placemarks![0]
                    
                    //save ocean name
                    if let ocean = placeInfo.ocean{
                        oceanName  = ocean
                    }
                    
                    // save inland water body
                    if let inlandWater  = placeInfo.inlandWater{
                        inlandWaterBody = inlandWater
                    }
                    
                    //if not an ocean or inland water body then get details
                    if  oceanName.isEmpty &&  inlandWaterBody.isEmpty{
                        
                        //ISO country name
                        if let ISOCountryCode = placeInfo.isoCountryCode {
                            print(ISOCountryCode)
                            
                            //get GDP
                            weakSelf.GDPdelegate?.getGDP(ISOCountry: ISOCountryCode)
                            
                        }
                    }
                    else {
                        
                        weakSelf.GDPdelegate?.noGDP(info: "Not applicable for an ocean/ a water body")
                    }
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            } // weak self ref
        })
        
    }
}

