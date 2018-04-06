//
//  AddWorkoutViewController.swift
//  hci-fitnote-ios
//
//  Created by Michael Chang on 4/5/18.
//  Copyright © 2018 Michael Chang. All rights reserved.
//

import UIKit

class AddWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableentries = [Bodyparts]()
    var index: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tableentries.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath[1]
        self.performSegue(withIdentifier: "exercises", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "bodyparts"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let bodypart = self.tableentries[indexPath.row].name
        
        cell.textLabel?.text = bodypart
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "exercises") {
            let destinationVC = segue.destination as! UINavigationController
            let targetController = destinationVC.topViewController as! ExercisesTableViewController
            targetController.bodypart = tableentries[index!]
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
