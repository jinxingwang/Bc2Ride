//
//  SEViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/8/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit

class SEViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var carView: UITableView!
    var names = ["will", "yih"]
    var space = ["3", "4"]
    var eventIdReciver = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SEVC" + eventIdReciver)
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "CustomCell2", bundle: nil)
        carView.registerNib(nib, forCellReuseIdentifier: "cell2")
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = carView.dequeueReusableCellWithIdentifier("cell2", forIndexPath: indexPath) as! CustomCell2
        cell.driverName.text = "driver:\(names[indexPath.row])"
        cell.space.text = "space available:\(space[indexPath.row])"
        cell.carButton.tag = indexPath.row
        cell.carButton.addTarget(self, action: #selector(SEViewController.showInfo(_:)), forControlEvents: .TouchUpInside)
        cell.carIdReciver = "number from parse \(names[indexPath.row])"
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 102
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("select \(indexPath.row) row")
        self.performSegueWithIdentifier("showCar", sender: self)
    }
    
    @IBAction func showInfo(sender: UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: SCViewController = storyboard.instantiateViewControllerWithIdentifier("SCVC") as! SCViewController
        let cell = carView.cellForRowAtIndexPath(carView.indexPathForSelectedRow!) as! CustomCell2
        // give car id
        vc.carIdReciver = cell.carIdReciver
        // give event id
        vc.eventIdReciver = eventIdReciver
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "showCar"){// click cell
            let DestVC : SCViewController = segue.destinationViewController as! SCViewController
            let cell = carView.cellForRowAtIndexPath(carView.indexPathForSelectedRow!) as! CustomCell2
            // give car id
            DestVC.carIdReciver = cell.carIdReciver
            // give event id
            DestVC.eventIdReciver = eventIdReciver
            self.carView.deselectRowAtIndexPath(self.carView.indexPathForSelectedRow!, animated: true)
        }else if(sender?.tag == 1){ // need more ride

        }else if(sender?.tag == 2){ // give a ride
            let DestVC : GRViewController = segue.destinationViewController as! GRViewController
            // give event id
            DestVC.eventIdReciver = eventIdReciver
        }else if(sender?.tag == 3){ // cancle
            let DestVC : FEViewController = segue.destinationViewController as! FEViewController
            // give event id
            DestVC.eventIdReciver = eventIdReciver
        }else if(sender?.tag == 4){ // home
            
        }else if(sender?.tag == 5){ //edit (todo later)
        
        }else if(sender?.tag == 6){ // info
            let DestVC : EIViewController = segue.destinationViewController as! EIViewController
            // give event id
            DestVC.eventIdReciver = eventIdReciver
        }

    }

}
