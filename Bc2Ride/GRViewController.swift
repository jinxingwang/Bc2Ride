//
//  GRViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/12/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit
import Parse

class GRViewController: UIViewController {
    @IBOutlet weak var carInfo: UITextView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var carSpace: UITextField!
    var eventIdReciver = String()
    var eventDateReciver = String()
    var eventNameReciver = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // go back
        if(sender?.tag == 0){
            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
            // give back event id
            DestVC.eventDateReciver = eventDateReciver
            DestVC.eventIdReciver = eventIdReciver
            DestVC.eventNameReciver = eventNameReciver
        }else if(sender?.tag == 1){
            if(name.text?.isEmpty as! BooleanType){
                alertPop()
            }else if(carSpace.text?.isEmpty as! BooleanType){
                alertPop()
            }else if(phoneNumber.text?.isEmpty as! BooleanType){
                alertPop()
            }else{
                let newcar = PFObject(className:"car")
                newcar["eventId"] = eventIdReciver
                newcar["carName"] = name.text
                newcar["carInfo"] = carInfo.text
                newcar["carSpace"] = Int(carSpace.text!)
                newcar["phoneNumber"] = phoneNumber.text!
                newcar.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if success == true {
                        let DestVC : SEViewController = segue.destinationViewController as! SEViewController
                        // give back event id
                        DestVC.eventDateReciver = self.eventDateReciver
                        DestVC.eventIdReciver = self.eventIdReciver
                        DestVC.eventNameReciver = self.eventNameReciver
                        DestVC.loadEvent()
                    } else {
                        self.failePop()
                    }
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
    
    func failePop() {
        let alert = UIAlertController(title: "Save ride failed\nTry again", message: nil, preferredStyle:  UIAlertControllerStyle.Alert)
        
        let enterAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(enterAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

