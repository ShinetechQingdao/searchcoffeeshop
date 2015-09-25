//
//  LocationTestTests.swift
//  LocationTestTests
//
//  Created by LiuZhenbang on 15/9/24.
//  Copyright © 2015年 LiuZhenbang. All rights reserved.
//

import XCTest
@testable import LocationTest

class AIPTest: XCTestCase {
    
    override func setUp() {
        
        super.setUp()
        IsVenuesSearchAPIAccessable()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func IsVenuesSearchAPIAccessable() {
        let httphelper = HttpHelper()
        let url:NSURL = httphelper.GetVenuesSearchAPI("37.33233141,-122.0312186")
        
        let request: NSURLRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
            (response, data, error) -> Void in
            
            if (error != nil) {
                XCTAssertNotNil("URL conntion error:\(error)")
            }else{
                XCTAssertNotNil("URL conntion finish")
            }
            
        })

    }
    
}
