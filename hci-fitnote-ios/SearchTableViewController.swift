//
//  SearchTableViewController.swift
//  hci-fitnote-ios
//
//  Created by Michael Chang on 4/6/18.
//  Copyright © 2018 Michael Chang. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    var tableentries = [Exercise]()
    var bodyparts_search = [Bodyparts]()
    var exercises_dict = [String: Exercise]()
    var filteredData: [String]!
    var exercises = [String]()
    var workout = Workout()
    var index: Int?
    
    
    @IBAction func cancel(_ sender: Any) {
        self.performSegue(withIdentifier: "fromSearch", sender: nil)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func unwindToSearch(segue:UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        for item in tableentries{
            exercises.append(item.name!)
            exercises_dict[item.name!] = item
        }
        filteredData = exercises
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath[1]
        self.performSegue(withIdentifier: "addsetssearch", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.filteredData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "search"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let search = filteredData[indexPath.row]
        
        cell.textLabel?.text = search
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? exercises : exercises.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "create_search") {
            let destinationVC = segue.destination as! UINavigationController
            let targetController = destinationVC.topViewController as! CreateViewController
            targetController.bodyparts_create = self.bodyparts_search
            targetController.exercises = self.tableentries
        }
        if (segue.identifier == "addsetssearch") {
            let destinationVC = segue.destination as! UINavigationController
            let targetController = destinationVC.topViewController as! AddSetsViewController
            targetController.navigationBar.title = filteredData[index!]
            targetController.exercise = exercises_dict[filteredData[index!]]!
            targetController.workout = workout
        }
        if (segue.identifier == "fromSearch") {
            if workout.exercises.count > 0 {
                let destinationVC = segue.destination as! FirstViewController
                let targetController = destinationVC
                targetController.currentWorkout = workout
                targetController.startTextField.text = "Add exercises to current workout"
                targetController.startTextField.sizeToFit()
                targetController.startTextField.center.x = self.view.center.x
                targetController.tableView.isHidden = false
                targetController.tableView.reloadData()
            }
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
