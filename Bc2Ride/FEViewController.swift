//
//  FEViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/8/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit
import Parse

class FEViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var eventView: UITableView!
    var eventNames: [String] = []
    var eventIds: [String] = []
    var eventDataReciver = String()
    var eventIdReciver = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadEvents()
        self.eventView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        eventView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        //removing empty rows
        eventView.tableFooterView = UIView()
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
    func loadEvents(){
        let query = PFQuery(className:"event")
        query.whereKey("eventData", equalTo:eventDataReciver)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        self.eventNames.append("\(object["eventName"])")
                        self.eventIds.append(object.objectId!)
                    }
                }
                self.eventView.reloadData()
            } else {
                
            }
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = eventView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        cell.eventName.text = eventNames[indexPath.row]
        cell.eventButton.tag = indexPath.row
        cell.eventButton.addTarget(self, action: #selector(FEViewController.showInfo(_:)), forControlEvents: .TouchUpInside)
        cell.eventIdReciver = "\(eventIds[indexPath.row])"
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showEvent", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    @IBAction func showInfo(sender: UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: SEViewController = storyboard.instantiateViewControllerWithIdentifier("SEVC") as! SEViewController
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        let cell = eventView.cellForRowAtIndexPath(indexPath) as! CustomCell
        // give event id
        vc.eventIdReciver = cell.eventIdReciver
        vc.eventDataReciver = eventDataReciver
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showEvent"){
            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
            let cell = eventView.cellForRowAtIndexPath(eventView.indexPathForSelectedRow!) as! CustomCell
            // give event id
            DestVC.eventIdReciver = cell.eventIdReciver
            DestVC.eventDataReciver = eventDataReciver
            self.eventView.deselectRowAtIndexPath(self.eventView.indexPathForSelectedRow!, animated: true)
        }
    }
}
