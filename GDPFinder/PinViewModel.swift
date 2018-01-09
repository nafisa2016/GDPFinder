//
//  PinViewModel.swift
//  GDPFinder
//
//  Created by Nafisa Rahman on 1/9/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import Foundation
import MapKit

@objc protocol GDPOperations {
    
    func getGDP(ISOCountry: String)
    func updateGDP(largeGDP : Double,gdpYear: String)
    func noGDP(info: String)
    
}

class PinViewModel  {
    
    var pin : PinLocationModel?
    
    var fetchGDP : FetchGDP
    var handleISOCountry : HandleISOCountry
    
    //Protocol delegate
    weak var delegate : PinHandler?
    
    init() {
        
        fetchGDP = FetchGDP()
        handleISOCountry  = HandleISOCountry()
    }
    
    //MARK:- create annotation from location received
    func locationTouched(title : String , coordinate: CLLocationCoordinate2D){
        
        //get ISO code for the country
        handleISOCountry.getISOCountry(pinCoordinate: CLLocation(latitude: coordinate.latitude,longitude: coordinate.longitude))
        
        pin = PinLocationModel(title: title, coordinate: coordinate)
        
        //Update mapview
        delegate?.addPin(touchedPt: pin!)
        
    }
}

extension PinViewModel : GDPOperations {
    
    //MARK :- get current year
    func getCurrentYear() -> Int {
        
        let date = Date() //UTC
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        
        let year =  components.year
        return year!
    }
    
    //MARK:- Get GDP
    func getGDP(ISOCountry: String){
        
        //get current year
        let currYear = getCurrentYear()
        fetchGDP.getGDP(ISOCountry, currYear: currYear)
        
    }
    
    //MARK:- Format GDP value
    func formatGDP(_ largeGDP : Double,gdpYear: String) -> String? {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.usesGroupingSeparator = true
        
        let gdp = NSNumber(floatLiteral: largeGDP)
        if let formattedString = numberFormatter.string(from: gdp) {
            return formattedString + " (" + gdpYear + ")"
            
        }
        
        return nil
    }
    
    //MARK:- update GDP
    func updateGDP(largeGDP : Double,gdpYear: String) {
        
        if let formattedGDP = formatGDP(largeGDP, gdpYear: gdpYear) {
            
            delegate?.updatePin(info: formattedGDP)
            
        }else {
            noGDP(info: "No GDP data")
        }
        
    }
    
    //MARK:- Handle no GDP data
    func noGDP(info: String) {
        
        delegate?.updatePin(info: info)
    }
    
}

