//
// CoffeeShopModel.swift
// 
// This is the model for parsed JSON string.
// We are going to us this model to populate the tableview.
//
//

import UIKit

class CoffeeShopModel: NSObject {
    var Name:NSString?
    var Distance:NSNumber = 0.0
    var Address:NSString?
    
    var latitude:NSNumber = 0.0
    var longitude:NSNumber = 0.0

}
