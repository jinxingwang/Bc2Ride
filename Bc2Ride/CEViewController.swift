//
//  CEViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/8/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit

class CEViewController: UIViewController {
    
    @IBOutlet weak var inputEventDescription: UITextView!
    @IBOutlet weak var inputEventName: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputEventData: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didCreateTouchup(sender: UIButton) {
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(sender?.tag == 2){
            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
            DestVC.receiveEventDescription = inputEventDescription.text!
            DestVC.receiveEventName = inputEventName.text!
            DestVC.receiveEmail = inputEmail.text!
            DestVC.receiveName = inputName.text!
            DestVC.receiveEventData = NSDateFormatter.localizedStringFromDate(inputEventData.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
