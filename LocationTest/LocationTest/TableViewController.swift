//
//  TableViewController.swift
//  LocationTest
//
//  
//
//

import UIKit
import CoreLocation

class TableViewController: UITableViewController , CLLocationManagerDelegate{
    
    
    var lm:CLLocationManager!
    var LL=""
    var coffeeStopList:CoffeeShopList?
    var locationStatus : NSString = "Not Started"
    var timmer:NSTimer?
    var locationCoordinate:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //location timmer
       timmer  = NSTimer.scheduledTimerWithTimeInterval(60, target:self, selector:"timerFunction", userInfo:nil, repeats:true)
        
        getCurrentLocation();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if coffeeStopList != nil
        {
            return (coffeeStopList?.datasoures?.count)!
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as? TableViewCell
        
        if (cell == nil)
        {
            cell = NSBundle.mainBundle().loadNibNamed("TableViewCell", owner: self, options: nil).last as? TableViewCell
        }
        
        if(coffeeStopList != nil)
        {
            let coffeeshop:CoffeeShopModel = (coffeeStopList?.datasoures![indexPath.row])! as! CoffeeShopModel
            cell!.initData(coffeeshop)
        }
        
        return cell!
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if(locations.count>0)
        {
        let location=locations[0]
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            locationCoordinate=location.coordinate;
            if  (LL != "\(location.coordinate.latitude),\(location.coordinate.longitude)")
            {
            //
            lm.stopUpdatingLocation()
            LL="\(location.coordinate.latitude),\(location.coordinate.longitude)";
                addDatasoures()
            }
            }
    }
    
    
    /*
    *Get the user current location
    */
    func getCurrentLocation(){
        lm = CLLocationManager()
        
        lm.delegate=self
        lm.distanceFilter = kCLDistanceFilterNone
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestAlwaysAuthorization()
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()

    }
    
    /*
    * Time to open get current location
    */
    func timerFunction()
        
    {
        lm.startUpdatingLocation()
    }
    
    
    /*
    * From an API to get the data
    */
    func addDatasoures()
    {
        let httphelper = HttpHelper()
        let url:NSURL = httphelper.GetVenuesSearchAPI(LL)
        
        let request: NSURLRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
            (response, data, error) -> Void in
            
            if (error != nil) {
                print(error)
            }else{
                
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    print(jsonResult)
                    let meta=jsonResult!.objectForKey("meta") as? NSDictionary
                    let code=meta!.objectForKey("code") as? NSNumber
                    
                    if(code == 200 )
                    {
                        let arraylist=(jsonResult!.objectForKey("response") as? NSDictionary)?.objectForKey("venues") as? NSArray
                        self.coffeeStopList=CoffeeShopList(arrayList: arraylist!);
                        self.tableView.reloadData()
                    }
                    else
                    {
                        print(code)
                    }
                    
                    
                    
                } catch let error as NSError {
                    print(error)
                }
                
            }
            
        })

    }
    
    
    /*
    * The value for MapViewController
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationController = segue.destinationViewController as! MapViewController
        destinationController.locationCoordinate=locationCoordinate;
        destinationController.coffeeStopList=coffeeStopList;
        
    }
}
