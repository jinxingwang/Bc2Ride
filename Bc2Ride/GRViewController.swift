//
//  GRViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/12/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit

class GRViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var carInfo: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var carSpace: UITextField!
    var eventIdReciver = String()
    
    @IBAction func EnterR(sender: UIButton) {
    }
    
    @IBAction func cancleR(sender: UIButton) {
    }

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
}

