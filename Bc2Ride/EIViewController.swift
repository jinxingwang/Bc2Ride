//
//  EIViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/12/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit
import Parse

class EIViewController: UIViewController {
    var eventIdReciver = String()
    var eventDataReciver = String()
    var eventNameReciver = String()
    @IBOutlet weak var eventInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadEventInfo()
        self.hideKeyboardWhenTappedAround()
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
    func loadEventInfo(){
        let query = PFQuery(className:"event")
        query.whereKey("objectId", equalTo:eventIdReciver)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        self.eventInfo.text = "\(object["eventInfo"] as! String)"
                    }
                }
            } else {
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // go back
        if(sender?.tag == 1){
            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
            // give back event id
            DestVC.eventDataReciver = eventDataReciver
            DestVC.eventIdReciver = eventIdReciver
            DestVC.eventNameReciver = eventNameReciver
        }
    }
}
