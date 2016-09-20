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
    @IBOutlet weak var address: UITextField!
    var carIdReciver = String()
    var eventIdReciver = String()
    var eventDateReciver = String()
    var carNameReciver = String()
    var eventNameReciver = String()
    var spaces = Int()
    
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
                print(error)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // go back
        if(sender?.tag == 0){
            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
            // give back event id
            DestVC.eventDateReciver = eventDateReciver
            DestVC.eventIdReciver = eventIdReciver
            DestVC.eventNameReciver = eventNameReciver
        }else if(sender?.tag == 1){
            if(name.text!.isEmpty || phoneNumber.text!.isEmpty){
                alertPop("Missing inputs")
            }else{
                let newguy = PFObject(className:"people")
                newguy["carId"] = carIdReciver
                newguy["name"] = name.text
                newguy["phoneNumber"] = phoneNumber.text
                newguy["address"] = address.text
                newguy.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if success == true {
                        let query = PFQuery(className:"car")
                        query.whereKey("objectId", equalTo:self.carIdReciver)
                        query.findObjectsInBackgroundWithBlock {
                            (objects: [PFObject]?, error: NSError?) -> Void in
                            if error == nil {
                                // Do something with the found objects
                                if let objects = objects {
                                    for object in objects {
                                        object["carSpace"] = self.spaces - 1
                                        object.saveInBackgroundWithBlock {
                                            (success: Bool, error: NSError?) -> Void in
                                            if success == true {
                                                let DestVC : SEViewController = segue.destinationViewController as! SEViewController
                                                // give back event id
                                                DestVC.eventDateReciver = self.eventDateReciver
                                                DestVC.eventIdReciver = self.eventIdReciver
                                                DestVC.eventNameReciver = self.eventNameReciver
                                                DestVC.loadEvent()
                                            }else{
                                                self.alertPop("Error try again")
                                            }
                                        }
                                    }
                                }
                            } else {
                                self.alertPop("Error try again")
                            }
                        }
                    } else {
                        self.alertPop("Error try again")
                    }
                }
            }
        }
    }
    
    func alertPop(input: String) {
        let alert = UIAlertController(title: input, message: nil, preferredStyle:  UIAlertControllerStyle.Alert)
        
        let enterAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        
        alert.addAction(enterAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
