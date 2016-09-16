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
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carInfo: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    var carIdReciver : String!
    var eventIdReciver = String()
    var eventDataReciver = String()
    var spaces = Int()
    var carNameReciver = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let indexStartOfText = carNameReciver.startIndex.advancedBy(7)
        carName.text = "\(carNameReciver.substringFromIndex(indexStartOfText))'s car"
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
            if(name.text?.isEmpty as! BooleanType){
                alertPop()
            }else if(phoneNumber.text?.isEmpty as! BooleanType){
                alertPop()
            }else{
                let newcar = PFObject(className:"people")
                newcar["carId"] = carIdReciver
                newcar["name"] = name.text
                newcar["phoneNumber"] = phoneNumber.text
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
                            }
                        }
                    } else {
                        
                    }
                    let DestVC : SEViewController = segue.destinationViewController as! SEViewController
                    // give back event id
                    DestVC.eventDataReciver = self.eventDataReciver
                    DestVC.eventIdReciver = self.eventIdReciver
                    DestVC.loadEvent()
                }
            }
        }
    }
    
    func alertPop() {
        let alert = UIAlertController(title: "Missing inputs", message: nil, preferredStyle:  UIAlertControllerStyle.Alert)
        
        let enterAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        
        alert.addAction(enterAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
