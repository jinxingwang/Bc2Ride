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
    var eventDateReciver = String()
    var eventNameReciver = String()
    @IBOutlet weak var eventInfo: UITextView!
    //@IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        eventInfo.sizeToFit()
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
                        self.eventInfo.text = "\n\nevent name: \n\(object["eventName"] as! String)\n\nevent Date: \n\(object["eventDate"] as! String)\n\nevent owner: \n\(object["ownerName"] as! String)\n\nowner email: \n\(object["ownerEmail"] as! String)\n\nowner phone Number: \n\(object["ownerPhoneNumber"] as! String)\n\nevent info: \n\(object["eventInfo"] as! String)"
                    }
                }
            } else {
                print(error)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // go back
        if(sender?.tag == 1){
            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
            // give back event id
            DestVC.eventDateReciver = eventDateReciver
            DestVC.eventIdReciver = eventIdReciver
            DestVC.eventNameReciver = eventNameReciver
        }
    }
}
