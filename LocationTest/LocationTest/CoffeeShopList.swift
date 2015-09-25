//
//  CoffeeShop.swift
//  LocationTest
//
//  Created by LiuZhenbang on 15/9/24.
//

import UIKit

class CoffeeShopList: NSObject {
    internal var datasoures:NSMutableArray?
    
    required init(arrayList:NSArray) {
        super.init()
        
        datasoures = NSMutableArray()
        
        //Parsing json String to CoffeeShop object
        for (var i = 0;i < arrayList.count;i++) {
            
            let coffeeshop:CoffeeShopModel = CoffeeShopModel()
            
            coffeeshop.Name=arrayList[i].objectForKey("name") as?NSString
            let location=arrayList[i].objectForKey("location") as? NSDictionary
            
            coffeeshop.Distance=(location?.objectForKey("distance") as? NSNumber)!
            coffeeshop.Address=(location?.objectForKey("formattedAddress") as? NSArray)?.objectAtIndex(0) as?NSString
            coffeeshop.latitude=NSNumber(double:(location?.objectForKey("lat")as!Double))
            coffeeshop.longitude=NSNumber(double:(location?.objectForKey("lng")as!Double))
            datasoures?.addObject(coffeeshop)
        }
        
        self.Ordered()
    }
    
    /*
    * sort by distant asc
    */
    func Ordered()
    {
        for var i = 0; i < datasoures!.count - 1; ++i {
            for var j = 0; j < datasoures!.count - 1 - i; ++j{
                
                let coffeeshop1=datasoures!.objectAtIndex(j)as! CoffeeShopModel
                let coffeeshop2=datasoures!.objectAtIndex(j+1)as! CoffeeShopModel
                
                if (coffeeshop1.Distance.compare(coffeeshop2.Distance) == NSComparisonResult.OrderedDescending) {
                    let temp = datasoures![j + 1]
                    datasoures![j + 1] = datasoures![j]
                    datasoures![j] = temp
                }
            }
        }
    }
}
