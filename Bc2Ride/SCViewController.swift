//
//  SCViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/12/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit
import Parse

class SCViewController: UIViewController {
    @IBOutlet weak var carInfo: UITextView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    var carIdReciver : String!
    var eventIdReciver = String()
    var eventDataReciver = String()
    var spaces = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadcar()
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
    func loadcar(){
        print(carIdReciver!)
        let query = PFQuery(className:"car")
        query.whereKey("objectId", equalTo:carIdReciver)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        self.carInfo.text = "\(object["carInfo"])"
                        self.spaces = object["carSpace"] as! Int
                    }
                }
            } else {
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // go back
        if(sender?.tag == 0){
            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
            // give back event id
            DestVC.eventDataReciver = eventDataReciver
            DestVC.eventIdReciver = eventIdReciver
        }else if(sender?.tag == 1){
            let newcar = PFObject(className:"people")
            newcar["carId"] = carIdReciver
            newcar["name"] = name.text
            newcar["phoneNumber"] = Int(phoneNumber.text!)
            newcar.saveInBackground()
            
            let query = PFQuery(className:"car")
            query.whereKey("objectId", equalTo:carIdReciver)
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    // Do something with the found objects
                    if let objects = objects {
                        for object in objects {
                            object["carSpace"] = self.spaces - 1
                            object.saveInBackground()
                            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
                            DestVC.carView.reloadData()
                        }
                    }
                } else {
                    
                }
            }
            
            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
            // give back event id
            DestVC.eventDataReciver = eventDataReciver
            DestVC.eventIdReciver = eventIdReciver
        }
    }
    
}
