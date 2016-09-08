//
//  ViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/8/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var didInputDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didFindaEventTouchUp(sender: UIButton) {
        
    }
    
    @IBAction func didCreateaEventTouchUp(sender: UIButton) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(sender?.tag == 1){
            let DestVC : FEViewController = segue.destinationViewController as! FEViewController
            DestVC.dateReciver = didInputDate.text!
        }
    }

}

