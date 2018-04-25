//
//  EditSetsViewController.swift
//  hci-fitnote-ios
//
//  Created by Michael Chang on 4/25/18.
//  Copyright © 2018 Michael Chang. All rights reserved.
//

import UIKit

class EditSetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var navigationBar: UINavigationItem!
    var exercise = Exercise()
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repTextField: UITextField!
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    @IBOutlet weak var SetTableView: UITableView!
    @IBAction func addSet(_ sender: Any) {
        if !(weightTextField.text == "" && repTextField.text == "") {
            var set = WorkoutSet()
            set.reps = Int(repTextField.text!)!
            set.weight = Double(weightTextField.text!)!
            exercise.sets.append(set)
            self.SetTableView.reloadData()
        }
    }
    
    @IBAction func addWeight(_ sender: Any) {
        if weightTextField.text! == "" {
            weightTextField.text! = "2.5"
        }
        else {
            var double = Double(weightTextField.text!)
            double = double! + 2.5
            weightTextField.text = String(double!)
        }
    }
    @IBAction func subtractWeight(_ sender: Any) {
        if weightTextField.text! == "" {
            weightTextField.text! = "0.00"
        }
        else {
            var double = Double(weightTextField.text!)
            if double! - 2.5 < 0 {
                double = 0.0
                weightTextField.text = String(double!)
            }
            else {
                double = double! - 2.5
                weightTextField.text = String(double!)
            }
        }
    }
    @IBAction func addReps(_ sender: Any) {
        if repTextField.text! == "" {
            repTextField.text! = "1"
        }
        else {
            var int = Int(repTextField.text!)
            int = int! + 1
            repTextField.text = String(int!)
        }
    }
    @IBAction func subtractReps(_ sender: Any) {
        if repTextField.text! == "" {
            repTextField.text! = "0"
        }
        else {
            var int = Int(repTextField.text!)
            if int! - 1 < 0 {
                int = 0
                repTextField.text = String(int!)
            }
            else {
                int = int! - 1
                repTextField.text = String(int!)
            }
        }
    }
    @IBAction func clear(_ sender: Any) {
        weightTextField.text = ""
        repTextField.text = ""
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weightTextField.text = ""
        repTextField.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.exercise.sets.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "set"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.textAlignment = .center
        let set = String (indexPath.row + 1) + "               " + String(self.exercise.sets[indexPath.row].weight) + "lbs" + "             " + String(self.exercise.sets[indexPath.row].reps) + " reps"
        
        cell.textLabel?.text = set
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            exercise.sets.remove(at: indexPath.row)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.SetTableView.reloadData()
        }
    }
}
