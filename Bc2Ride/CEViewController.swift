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
    @IBOutlet weak var inputEventDescription: UITextView!
    @IBOutlet weak var inputEventName: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputEventData: UIDatePicker!
    
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
            if(inputEventName.text?.isEmpty as! BooleanType){
                alertPop()
            }else if(inputEventDescription.text?.isEmpty as! BooleanType){
                alertPop()
            }else{
                let DestVC : SEViewController = segue.destinationViewController as! SEViewController
                let newEvent = PFObject(className:"event")
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM/dd/yy"
                let dateString = dateFormatter.stringFromDate(inputEventData.date)
                newEvent["eventName"] = inputEventName.text
                newEvent["eventData"] = dateString
                newEvent["eventInfo"] = inputEventDescription.text
                newEvent.saveInBackground()
                
                // give back event id
                DestVC.eventDataReciver = dateString
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
