//
//  EditSportTableViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/9/3.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit

class EditSportTableViewController: UITableViewController {
    var selectedSport = Cuser.shareObj.infos.sport
    
    @IBAction func doneSelect(_ sender: AnyObject) {
        uploadData(["sport" : Cuser.shareObj.infos.sport!])
        navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true

        print("cuer shareobj sport ~\(Cuser.shareObj.infos.sport)")
        print("select sport~\(selectedSport?.count)")
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Cuser.shareObj.defaultSports.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! EditSportTableViewCell
        cell.sportLabel.text = Cuser.shareObj.defaultSports[(indexPath as NSIndexPath).row]
        
        for obj in selectedSport! {
            
            if Cuser.shareObj.defaultSports.contains(obj) {
                Cuser.shareObj.sportCheck[Cuser.shareObj.defaultSports.index(of: obj)!] = true
                
                cell.accessoryType = Cuser.shareObj.sportCheck[(indexPath as NSIndexPath).row] ? .checkmark : .none
            }
        }
        
        cell.accessoryType = Cuser.shareObj.sportCheck[(indexPath as NSIndexPath).row] ? .checkmark : .none

        print(" check mark of sport \(Cuser.shareObj.sportCheck[(indexPath as NSIndexPath).row])")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! EditSportTableViewCell
        cell.sportLabel.text = Cuser.shareObj.defaultSports[(indexPath as NSIndexPath).row]
        cell.isSelected = false
        
        if Cuser.shareObj.sportCheck[(indexPath as NSIndexPath).row] == true {
            Cuser.shareObj.sportCheck[(indexPath as NSIndexPath).row] = false
            
            selectedSport?.remove(at: (selectedSport?.index(of: Cuser.shareObj.defaultSports[(indexPath as NSIndexPath).row]))!)
            
            print("my remove ~ \(selectedSport)")
        }else if Cuser.shareObj.sportCheck[(indexPath as NSIndexPath).row] == false {

            selectedSport?.append(Cuser.shareObj.defaultSports[(indexPath as NSIndexPath).row])
            Cuser.shareObj.sportCheck[(indexPath as NSIndexPath).row] = true
    
            print("my append ~ \(selectedSport)")
        }
        Cuser.shareObj.infos.sport = selectedSport
        tableView.reloadData()
        print("did select~ \(Cuser.shareObj.sportCheck[(indexPath as NSIndexPath).row])")
    }
    




    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
