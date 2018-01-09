//
//  ViewController.swift
//  GDPFinder
//
//  Created by Nafisa Rahman on 1/9/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import UIKit
import MapKit

@objc protocol PinHandler : class {
    
    func addPin(touchedPt: MKAnnotation) -> ()
    func updatePin(info: String)
    func removePin()
}

class ViewController: UIViewController,UIGestureRecognizerDelegate,MKMapViewDelegate {
    
    //MARK:- properties
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    
    //view model
    lazy var pinViewModel = PinViewModel()
    
    //map annotation
    var annotation:MKAnnotation!
    
    //MARK:- methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set all delegates
        setDelegates()
        
        //show world map
        let  worldMap : MKCoordinateRegion = MKCoordinateRegionForMapRect(MKMapRectWorld);
        mapView.region = worldMap
        
        //long press gesture
        addLongPressGesture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Select Map Type
    @IBAction func selectMapType(_ sender: UISegmentedControl) {
        
        let type = mapType.selectedSegmentIndex
        
        switch (type) {
        case 0:
            mapView.mapType = MKMapType.standard
            
        case 1:
            mapView.mapType = MKMapType.satellite
            
        case 2:
            mapView.mapType = MKMapType.hybrid
            
        default:
            mapView.mapType = MKMapType.standard
            
        }
    }
    
    //MARK:- Configure Pin.Show pin callout.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
        }
        else {
            
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
}

extension ViewController {
    
    func setDelegates(){
        
        mapView.delegate = self
        
        //set view model delegate
        pinViewModel.delegate = self
        
        pinViewModel.handleISOCountry.GDPdelegate = pinViewModel
        pinViewModel.fetchGDP.GDPdelegate = pinViewModel
        
    }
    
    //MARK:- Add a long press gesture
    func addLongPressGesture(){
        
        let lngPress = UILongPressGestureRecognizer()
        lngPress.minimumPressDuration = 0.5
        lngPress.delaysTouchesBegan = true
        lngPress.delegate = self
        lngPress.addTarget(self, action: #selector(ViewController.addPin(_:)))
        view.isUserInteractionEnabled = true
        
        mapView.addGestureRecognizer(lngPress)
    }
    
    //long press to add pin
    @objc func addPin(_ gestureReconizer: UILongPressGestureRecognizer){
        
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            
            let touchLocation = gestureReconizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation,toCoordinateFrom: mapView)
            
            //remove previous pin
            removePin()
            
            //MARK: pass touch coordinate to view model
            pinViewModel.locationTouched(title: "GDP", coordinate: locationCoordinate)
            return
        }
        
        if gestureReconizer.state != UIGestureRecognizerState.began {
            return
        }
    }
    
}

//MARK:- conforms to Pinhandler protocol
extension ViewController : PinHandler {
    
    //MARK: Add annotation to mapview
    func addPin(touchedPt: MKAnnotation) -> () {
        
        mapView.addAnnotation(touchedPt)
    }
    
    
    
    //MARK:- Update pin subtitle with formatted GDP value
    func updatePin(info : String) {
        
        //update pin title from main thread
        DispatchQueue.main.async { [weak self] in
            
            if let weakSelf = self {
                
                weakSelf.pinViewModel.pin?.subtitle = info
            }
        }
        
    }
    
    //MARK:- remove pin
    func removePin(){
        
        if mapView.annotations.count != 0 {
            
            annotation = mapView.annotations[0]
            mapView.removeAnnotation(annotation)
            
        }
    }
    
}

