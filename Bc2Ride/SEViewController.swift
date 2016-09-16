//
//  SEViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/8/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit
import Parse

class SEViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var carView: UITableView!
    var carNames: [String] = []
    var carSpaces: [Int] = []
    var carIds: [String] = []
    var eventIdReciver = String()
    var eventDataReciver = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        carNames.removeAll()
        carSpaces.removeAll()
        carIds.removeAll()
        loadEvent()
        let nib = UINib(nibName: "CustomCell2", bundle: nil)
        carView.registerNib(nib, forCellReuseIdentifier: "cell2")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func loadEvent(){
        let query = PFQuery(className:"car")
        query.whereKey("eventId", equalTo:eventIdReciver)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        self.carNames.append("\(object["carName"])")
                        self.carSpaces.append(object["carSpace"] as! Int)
                        self.carIds.append(object.objectId!)
                    }
                }
                self.carView.reloadData()
            } else {
                
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = carView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! CustomCell2
        cell.driverName.text = "driver:\(carNames[indexPath.row])"
        cell.space.text = "space available:\(carSpaces[indexPath.row])"
        cell.rideButton.tag = indexPath.row
        cell.rideButton.addTarget(self, action: #selector(SEViewController.showCar(_:)), forControlEvents: .TouchUpInside)
        cell.studentButton.tag = indexPath.row
        cell.studentButton.addTarget(self, action: #selector(SEViewController.showStudent(_:)), forControlEvents: .TouchUpInside)
        cell.carIdReciver = carIds[indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 102
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showCar", sender: self)
    }
    
    @IBAction func showCar(sender: UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: SCViewController = storyboard.instantiateViewControllerWithIdentifier("SCVC") as! SCViewController
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        let cell = carView.cellForRowAtIndexPath(indexPath) as! CustomCell2
        if(carSpaces[indexPath.row] <= 0){
            // todo pop a window
        }else{
            // give car id
            vc.carIdReciver = cell.carIdReciver
            // give event id
            vc.eventDataReciver = eventDataReciver
            vc.eventIdReciver = eventIdReciver
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func showStudent(sender: UIButton){
        print(sender.tag)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: SSViewController = storyboard.instantiateViewControllerWithIdentifier("SSVC") as! SSViewController
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        let cell = carView.cellForRowAtIndexPath(indexPath) as! CustomCell2
        print(cell.carIdReciver)
        vc.carIdReciver = cell.carIdReciver
        vc.eventDataReciver = eventDataReciver
        vc.eventIdReciver = eventIdReciver
        vc.carNameReciver = cell.driverName.text!
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // need more ride
    @IBAction func needMoreRide(sender: UIButton) {
        alertPop()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showCar"){// click cell
            let DestVC : SCViewController = segue.destinationViewController as! SCViewController
            let cell = carView.cellForRowAtIndexPath(carView.indexPathForSelectedRow!) as! CustomCell2
            // give car id
            DestVC.carIdReciver = cell.carIdReciver
            // give event id
            DestVC.eventDataReciver = eventDataReciver
            DestVC.eventIdReciver = eventIdReciver
            eventDataReciver.removeAll()
            eventIdReciver.removeAll()
            self.carView.deselectRowAtIndexPath(self.carView.indexPathForSelectedRow!, animated: true)
        }else if(sender?.tag == 2){ // give a ride
            let DestVC : GRViewController = segue.destinationViewController as! GRViewController
            // give event id
            DestVC.eventDataReciver = eventDataReciver
            DestVC.eventIdReciver = eventIdReciver
            eventDataReciver.removeAll()
            eventIdReciver.removeAll()
        }else if(sender?.tag == 3){ // cancle
            let DestVC : FEViewController = segue.destinationViewController as! FEViewController
            // give event id
            DestVC.eventDataReciver = eventDataReciver
            DestVC.eventIdReciver = eventIdReciver
        }else if(sender?.tag == 4){ // home
            eventDataReciver.removeAll()
            eventIdReciver.removeAll()
        }else if(sender?.tag == 5){ //edit (todo later)
            
        }else if(sender?.tag == 6){ // info
            let DestVC : EIViewController = segue.destinationViewController as! EIViewController
            // give event id
            DestVC.eventDataReciver = eventDataReciver
            DestVC.eventIdReciver = eventIdReciver
            eventDataReciver.removeAll()
            eventIdReciver.removeAll()
        }
        
    }
    
    func alertPop() {
        let alert = UIAlertController(title: "message Will for more rides.\n425-974-9158\nwjx101220@hotmail.com", message: nil, preferredStyle:  UIAlertControllerStyle.Alert)
        
        let enterAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        
        alert.addAction(enterAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
