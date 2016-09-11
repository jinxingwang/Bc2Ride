//
//  FEViewController.swift
//  Bc2Ride
//
//  Created by jinxingwang on 9/8/16.
//  Copyright © 2016 jinxingwang. All rights reserved.
//

import UIKit

class FEViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate{
    var dateReciver = String()
    @IBOutlet weak var eventView: UITableView!
    var lables = ["car1", "car2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // self.eventView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        eventView.registerNib(nib, forCellReuseIdentifier: "cell")
        let nib2 = UINib(nibName: "CustomCell2", bundle: nil)
        eventView.registerNib(nib2, forCellReuseIdentifier: "cell2")
        
        //removing empty rows
        eventView.tableFooterView = UIView()
        
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
        return self.lables.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {      
        if(indexPath.row == 0) {
            let cell = eventView.dequeueReusableCellWithIdentifier( "cell", forIndexPath: indexPath) as! CustomCell
            cell.eventImage.image = UIImage(named: lables[indexPath.row])
            cell.eventName.text = lables[indexPath.row]
            cell.eventButton.tag = indexPath.row
            cell.eventButton.addTarget(self, action: #selector(FEViewController.showInfo(_:)), forControlEvents: .TouchUpInside)
            return cell
        } else {
            let cell = eventView.dequeueReusableCellWithIdentifier( "cell2", forIndexPath: indexPath) as! CustomCell2
            cell.eventImage.image = UIImage(named: lables[indexPath.row])
            cell.eventName.text = lables[indexPath.row]
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("select \(indexPath.row) row")
        self.performSegueWithIdentifier("showEvent", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    @IBAction func showInfo(sender: UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: ViewController = storyboard.instantiateViewControllerWithIdentifier("VC") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showEvent"){
            let DestVC : SEViewController = segue.destinationViewController as! SEViewController
            DestVC.receiveEventDescription = "1"
            DestVC.receiveEventName = "2"
            DestVC.receiveEmail = "3"
            DestVC.receiveName = "4"
            DestVC.receiveEventData = "5"
            self.eventView.deselectRowAtIndexPath(self.eventView.indexPathForSelectedRow!, animated: true)
        }
    }
}
