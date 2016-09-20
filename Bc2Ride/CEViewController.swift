//
//  CEViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/8/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit
import Parse

class CEViewController: UIViewController {
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPhoneNumber: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEventName: UITextField!
    @IBOutlet weak var inputEventDescription: UITextView!
    @IBOutlet weak var inputEventDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didCreateTouchup(sender: UIButton) {
        
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
        if(sender?.tag == 2){
            if(((inputName.text?.isEmpty)! as Bool) ||
                ((inputEmail.text?.isEmpty)! as Bool) ||
                ((inputPhoneNumber.text?.isEmpty)! as Bool) ||
                ((inputEventName.text?.isEmpty)! as Bool)){
                alertPop("Missing inputs")
            }else{
                let DestVC : SEViewController = segue.destinationViewController as! SEViewController
                let newEvent = PFObject(className:"event")
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM/dd/yy"
                let dateString = dateFormatter.stringFromDate(inputEventDate.date)
                newEvent["ownerName"] = inputName.text
                newEvent["ownerEmail"] = inputEmail.text
                newEvent["ownerPhoneNumber"] = inputPhoneNumber.text
                newEvent["eventName"] = inputEventName.text
                newEvent["eventInfo"] = inputEventDescription.text
                newEvent["eventDate"] = dateString
                
                if(inputPassword.text!.isEmpty){
                    newEvent["hasPassword"] = false
                }else{
                    newEvent["hasPassword"] = true
                    newEvent["password"] = inputPassword.text
                }
                newEvent.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if success == true {
                        let DestVC : SEViewController = segue.destinationViewController as! SEViewController
                        // give back event id
                        DestVC.eventDateReciver = dateString
                        DestVC.eventIdReciver = newEvent.objectId!
                        DestVC.loadEvent()
                    } else {
                    }
                }
                
                // give back event id
                DestVC.eventDateReciver = dateString
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
