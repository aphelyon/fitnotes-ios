//
//  AddSetsViewController.swift
//  hci-fitnote-ios
//
//  Created by Michael Chang on 4/6/18.
//  Copyright © 2018 Michael Chang. All rights reserved.
//

import UIKit

class AddSetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var exercise = Exercise()
    var workout = Workout()
    
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: nil))
        
        present(controller, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var SetTableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBAction func cancel(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishWorkout(_ sender: Any) {
        if exercise.sets.count > 0{
            workout.exercises.append(exercise)
            self.performSegue(withIdentifier: "saveWorkout", sender: self)
        }
        else {
            self.displayAlertWithTitle(title: "No Sets in Current Exercise",
                                       message: "Please add some to sets to the exercise")
        }
    }
    
    @IBAction func addExercises(_ sender: Any) {
        if exercise.sets.count > 0{
            workout.exercises.append(exercise)
            self.performSegue(withIdentifier: "addMoreExercises", sender: self)
        }
        else {
            self.displayAlertWithTitle(title: "No Sets in Current Exercise",
                                       message: "Please add some to sets to the exercise")
        }
    }
    @IBAction func clearSet(_ sender: Any) {
        weightTextField.text = ""
        repTextField.text = ""
    }
    @IBAction func addSet(_ sender: Any) {
        if weightTextField.text != "" && repTextField.text != "" {
            var set = WorkoutSet()
            set.reps = Int(repTextField.text!)!
            set.weight = Double(weightTextField.text!)!
            exercise.sets.append(set)
            self.SetTableView.reloadData()
        }
    }
    @IBAction func addweight(_ sender: Any) {
        if weightTextField.text! == "" {
            weightTextField.text! = "2.5"
        }
        else {
            var double = Double(weightTextField.text!)
            double = double! + 2.5
            weightTextField.text = String(double!)
        }
    }
    
   
    @IBAction func subtractweight(_ sender: Any) {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var weightTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weightTextField.text = ""
        repTextField.text = ""
    }
   
    
    @IBAction func subtractreps(_ sender: Any) {
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
    @IBAction func addreps(_ sender: Any) {
        if repTextField.text! == "" {
            repTextField.text! = "1"
        }
        else {
            var int = Int(repTextField.text!)
            int = int! + 1
            repTextField.text = String(int!)
        }
    }
    @IBOutlet weak var repTextField: UITextField!
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "saveWorkout") {
            let destinationVC = segue.destination as! FirstViewController
            let targetController = destinationVC
            targetController.currentWorkout = workout
            targetController.startTextField.text = "Add exercises to current workout"
            targetController.startTextField.sizeToFit()
            targetController.startTextField.center.x = self.view.center.x
            targetController.tableView.isHidden = false
            targetController.tableView.reloadData()
        }
        if (segue.identifier == "addMoreExercises") {
            let destinationVC = segue.destination as! AddWorkoutViewController
            let targetController = destinationVC
            targetController.workout = workout
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
