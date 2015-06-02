//
//  BackForwardListViewController.swift
//  WebViewDemo
//
//  Created by nyaago on 2015/06/01.
//  Copyright (c) 2015年 nyaago. All rights reserved.
//

import UIKit
import WebKit

class BackForwardListViewController: UITableViewController {
    
    var webViewController: ViewController?
    var backForwardList: WKBackForwardList?
    var incBackItems: Bool = false
    var incForwardItems: Bool = false
    var list: Array<AnyObject>?
    
    /*
    func setBackForwardList(list: WKBackForwardList?) {
    self.backForwardList = list
    }
    
    func setIncBackAndForwardItem(incBack: Bool = false, incForward: Bool = false) {
    self.incBackItems = incBack
    self.incForwardItems = incForward
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
        self.navigationController?.navigationBarHidden = false
        addNavigationbarItem()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationbarItem()
        setBackForwardList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if(list == nil) {
            return 0
        }
        var i : Int? =  list?.count
        return i!;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        // Configure the cell...
        var any : AnyObject? = list?[indexPath.row]
        var item : WKBackForwardListItem? = (any as! WKBackForwardListItem)
        cell.textLabel?.text = item?.title
        cell.detailTextLabel?.text = item?.description

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var any : AnyObject? = list?[indexPath.row]
        var item : WKBackForwardListItem? = (any as! WKBackForwardListItem)
        if(self.webViewController != nil) {
            self.webViewController?.backForwardListItem = item
        }
        self.navigationController?.dismissViewControllerAnimated(true, completion: {
        })
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func complete() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: {})
    }
    
    private func setBackForwardList() {
        if(incBackItems) {
            list = backForwardList?.backList
        }
        else if(incForwardItems) {
            list = backForwardList?.forwardList
        }
        else {
            
        }
        
    }
    
    private func addNavigationbarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Done,
            target: self,
            action: "complete")
    }

    
}
