//
//  EditSetsViewController.swift
//  hci-fitnote-ios
//
//  Created by Michael Chang on 4/25/18.
//  Copyright © 2018 Michael Chang. All rights reserved.
//

import UIKit

class EditSetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var navigationBar: UINavigationItem!
    var exercise = Exercise()
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repTextField: UITextField!
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    @IBOutlet weak var SetTableView: UITableView!
    @IBAction func addSet(_ sender: Any) {
        if weightTextField.text != "" && repTextField.text != "" {
            var set = WorkoutSet()
            set.reps = Int(repTextField.text!)!
            set.weight = Double(weightTextField.text!)!
            exercise.sets.append(set)
            self.SetTableView.reloadData()
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
        for index in 1...20 {
            picker2Options.append(index)
        }
        for i in stride(from: 0, to: 1200, by: 2.5) {
            myPickerData.append(i)
        }
        
        let thePicker = UIPickerView()
        let thePicker2 = UIPickerView()
        thePicker.tag = 1
        thePicker2.tag = 2
        weightTextField.inputView = thePicker
        repTextField.inputView = thePicker2
        thePicker.delegate = self
        thePicker2.delegate = self
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return myPickerData.count
        }
        else {
            return picker2Options.count
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return String(myPickerData[row])
        }
        else {
            return String(picker2Options[row])
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            weightTextField.text = String(myPickerData[row])
        } else if pickerView.tag == 2 {
            repTextField.text = String(picker2Options[row])
        }
    }
}
