//
//  HttpHelper.swift
//  LocationTest
//
//  Created by LiuZhenbang on 15/9/25.
//  Copyright © 2015年 LiuZhenbang. All rights reserved.
//

import UIKit

class HttpHelper: NSObject {
    
    let address = "https://api.foursquare.com/v2/"
    let Client_ID = "ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G"
    let Client_Secret = "YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL"
    let Category_ID = "4bf58dd8d48988d1e0931735"

    func GetVenuesSearchAPI(LL:NSString)->NSURL
    {
        let url:NSURL = NSURL(string:
            "\(address)venues/search?ll=\(LL)&categoryId=\(Category_ID)&client_id=\(Client_ID)&client_secret=\(Client_Secret)&v=20150924")!
        
        return url
    }
}
