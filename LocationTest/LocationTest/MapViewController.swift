//
//  MapViewController.swift
//  LocationTest
//
//  Created by LiuZhenbang on 15/9/24.
//  Copyright © 2015年 LiuZhenbang. All rights reserved.
//

import UIKit
import MapKit



class MapViewController: UIViewController ,MKMapViewDelegate{
    
    @IBOutlet weak var MapView: MKMapView!

    
    var coffeeStopList:CoffeeShopList?
    var locationCoordinate:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.MapView.mapType=MKMapType.Standard
        self.MapView.delegate=self
        self.MapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
        
        //Set the display range
        if locationCoordinate != nil
        {
            let viewregion=MKCoordinateRegionMakeWithDistance(locationCoordinate!, 10000, 10000)
            self.MapView.setRegion(viewregion, animated: true)
        }
        
        
        setPoint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
    *Set mark, let its display position name and address
    */
    func setPoint() {
        
        if(coffeeStopList==nil)
        {
            return
        }
        
        let coffeeStopSoures = coffeeStopList?.datasoures
        
        if(coffeeStopSoures==nil)
        {
            return
        }
        
        for var i = 0 ;i < coffeeStopSoures?.count ; i++ {
            
            let coffeeshop=coffeeStopSoures![i] as? CoffeeShopModel
            let annotation = MKPointAnnotation()
            
            annotation.coordinate=CLLocationCoordinate2D(latitude: (coffeeshop?.latitude.doubleValue)!, longitude: (coffeeshop?.longitude.doubleValue)!)
            annotation.title="\(coffeeshop?.Name)"
            annotation.subtitle="\(coffeeshop?.Address)"
            
            self.MapView.addAnnotation(annotation)
        }
    }
}
