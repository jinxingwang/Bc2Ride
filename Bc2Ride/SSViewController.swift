//
//  SSViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/14/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit
import Parse

class SSViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var eventDataReciver = String()
    var eventIdReciver = String()
    var carIdReciver = String()
    var studentNames: [String] = []
    var studentPhones: [String] = []
    var studentIds: [String] = []
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var studentView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lable.text = eventDataReciver + eventIdReciver + carIdReciver
        loadEvent()
        let nib = UINib(nibName: "CustomCell3", bundle: nil)
        studentView.registerNib(nib, forCellReuseIdentifier: "cell3")
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
        studentNames.removeAll()
        studentPhones.removeAll()
        studentIds.removeAll()
        let query = PFQuery(className:"people")
        query.whereKey("carId", equalTo:carIdReciver)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        self.studentNames.append("\(object["name"])")
                        self.studentPhones.append("\(object["phoneNumber"])")
                        self.studentIds.append(object.objectId!)
                    }
                }
            } else {
                
            }
            self.studentView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = studentView.dequeueReusableCellWithIdentifier("cell3", forIndexPath: indexPath) as! CustomCell3
        cell.name.text = "\(studentNames[indexPath.row])"
        cell.phoneNumber.setTitle("\(studentPhones[indexPath.row])", forState:  UIControlState.Normal)
        //cell.phoneNumber.text = "\(studentPhones[indexPath.row])"
        cell.delete.tag = indexPath.row
        cell.delete.addTarget(self, action: #selector(SSViewController.deleteStudent(_:)), forControlEvents: .TouchUpInside)
        cell.studentIdReciver = studentIds[indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 102
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.studentView.deselectRowAtIndexPath(self.studentView.indexPathForSelectedRow!, animated: true)
    }
    
    @IBAction func deleteStudent(sender: UIButton){
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc: SSViewController = storyboard.instantiateViewControllerWithIdentifier("SSVC") as! SSViewController
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        let cell = studentView.cellForRowAtIndexPath(indexPath) as! CustomCell3
        let query = PFQuery(className:"people")
        query.whereKey("objectId", equalTo:cell.studentIdReciver)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        object.deleteInBackgroundWithBlock{
                            (success: Bool, error: NSError?) -> Void in
                            if success == true {
                                self.loadEvent()
                            } else {
                            }
                        }
                    }
                }
            } else {
                
            }
            self.studentView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // go back
        if(sender?.tag == 1){
            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
            // give back event id
            DestVC.eventDataReciver = eventDataReciver
            DestVC.eventIdReciver = eventIdReciver
        }
    }
}
