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
    var password: UITextField!
    var eventNames: [String] = []
    var eventIds: [String] = []
    var eventHasPasswords: [Bool] = []
    var eventDateReciver = String()
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
        query.whereKey("eventDate", equalTo:eventDateReciver)
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
                        self.eventHasPasswords.append(object["hasPassword"] as! Bool)
                    }
                }
                self.eventView.reloadData()
            } else {
                print(error)
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
        if(eventHasPasswords[indexPath.row]){
            cell.lockImage.image = UIImage(named: "passwordKey")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showEvent", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    @IBAction func showInfo(sender: UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: SEViewController = storyboard.instantiateViewControllerWithIdentifier("SEVC") as! SEViewController
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        let cell = eventView.cellForRowAtIndexPath(indexPath) as! CustomCell
        if(eventHasPasswords[sender.tag]){
            alertPop(eventIds[cell.eventButton.tag], tag: cell.eventButton.tag)
        }else{
            // give event id
            vc.eventIdReciver = cell.eventIdReciver
            vc.eventDateReciver = eventDateReciver
            vc.eventNameReciver = cell.eventName.text!
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showEvent"){
            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
            let cell = eventView.cellForRowAtIndexPath(eventView.indexPathForSelectedRow!) as! CustomCell
            if(eventHasPasswords[cell.eventButton.tag]){
                alertPop(eventIds[cell.eventButton.tag], tag: cell.eventButton.tag)
            }else{
                // give event id
                DestVC.eventIdReciver = cell.eventIdReciver
                DestVC.eventDateReciver = eventDateReciver
                DestVC.eventNameReciver = cell.eventName.text!
                self.eventView.deselectRowAtIndexPath(self.eventView.indexPathForSelectedRow!, animated: true)
            }
        }
    }
    
    func checkPassword(id: String, password: String, tag: Int){
        let query = PFQuery(className:"event")
        query.whereKey("objectId", equalTo:id)
        
        do {
            let objects: [PFObject] = try query.findObjects()
            for object in objects {
                if(object["password"] as! String == password){
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc: SEViewController = storyboard.instantiateViewControllerWithIdentifier("SEVC") as! SEViewController
                    let indexPath = NSIndexPath(forRow: tag, inSection: 0)
                    let cell = eventView.cellForRowAtIndexPath(indexPath) as! CustomCell
                    // give event id
                    vc.eventIdReciver = cell.eventIdReciver
                    vc.eventDateReciver = eventDateReciver
                    vc.eventNameReciver = cell.eventName.text!
                    self.presentViewController(vc, animated: true, completion: nil)
                }else{
                    alertPop2("wrong password")
                }
            }
        } catch {
            print(error)
        }
    }
    
    func config(password: UITextField){
        password.placeholder = "event password"
        self.password = password
    }
    
    func alertPop(id: String, tag: Int){
        let alert = UIAlertController(title: "password required", message: nil, preferredStyle:  UIAlertControllerStyle.Alert)
        
        let enterAction = UIAlertAction(title: "enter", style: UIAlertActionStyle.Default){
            UIAlertAction in
            self.checkPassword(id, password: self.password.text!,tag: tag)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        
        alert.addTextFieldWithConfigurationHandler(config)
        alert.addAction(enterAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func alertPop2(input: String) {
        let alert = UIAlertController(title: input, message: nil, preferredStyle:  UIAlertControllerStyle.Alert)
        
        let enterAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        
        alert.addAction(enterAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
