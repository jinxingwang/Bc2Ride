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
        print("asd")
        print(eventIdReciver)
        print(eventDataReciver)
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
        cell.carButton.tag = indexPath.row
        cell.carButton.addTarget(self, action: #selector(SEViewController.showInfo(_:)), forControlEvents: .TouchUpInside)
        cell.studentButton.addTarget(self, action: #selector(SEViewController.showStudent(_:)), forControlEvents: .TouchUpInside)
        cell.carIdReciver = carIds[indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 102
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.carView.deselectRowAtIndexPath(self.carView.indexPathForSelectedRow!, animated: true)
//        if(carSpaces[indexPath.row] <= 0){
//            // todo pop a window
//            self.carView.deselectRowAtIndexPath(self.carView.indexPathForSelectedRow!, animated: true)
//        }else{
//            self.performSegueWithIdentifier("showCar", sender: self)
//        }
    }
    
    @IBAction func showInfo(sender: UIButton){
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
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: SSViewController = storyboard.instantiateViewControllerWithIdentifier("SSVC") as! SSViewController
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        let cell = carView.cellForRowAtIndexPath(indexPath) as! CustomCell2
        vc.carIdReciver = cell.carIdReciver
        vc.eventDataReciver = eventDataReciver
        vc.eventIdReciver = eventIdReciver
        self.presentViewController(vc, animated: true, completion: nil)
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
            self.carView.deselectRowAtIndexPath(self.carView.indexPathForSelectedRow!, animated: true)
        }else if(sender?.tag == 1){ // need more ride
            
        }else if(sender?.tag == 2){ // give a ride
            let DestVC : GRViewController = segue.destinationViewController as! GRViewController
            // give event id
            DestVC.eventDataReciver = eventDataReciver
            DestVC.eventIdReciver = eventIdReciver
        }else if(sender?.tag == 3){ // cancle
            let DestVC : FEViewController = segue.destinationViewController as! FEViewController
            // give event id
            DestVC.eventDataReciver = eventDataReciver
            DestVC.eventIdReciver = eventIdReciver
        }else if(sender?.tag == 4){ // home
            
        }else if(sender?.tag == 5){ //edit (todo later)
            
        }else if(sender?.tag == 6){ // info
            let DestVC : EIViewController = segue.destinationViewController as! EIViewController
            // give event id
            DestVC.eventDataReciver = eventDataReciver
            DestVC.eventIdReciver = eventIdReciver
        }
        
    }
    
}
