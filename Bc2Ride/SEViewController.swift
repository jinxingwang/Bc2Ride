//
//  SEViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/8/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit

class SEViewController: UIViewController {
    var receiveEventDescription = String()
    var receiveEventName = String()
    var receiveEmail = String()
    var receiveName = String()
    var receiveEventData = String()
    
    @IBOutlet weak var showUP: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUP.text = "The event is: \(receiveEventName)\nThe event woner is: \(receiveName)\nThe owner's email is: \(receiveEmail)\nThe event description is: \(receiveEventDescription)\nThe event data is: \(receiveEventData)"
        // Do any additional setup after loading the view.
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

}
