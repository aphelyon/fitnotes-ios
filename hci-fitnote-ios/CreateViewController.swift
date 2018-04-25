//
//  CreateViewController.swift
//  hci-fitnote-ios
//
//  Created by Michael Chang on 4/6/18.
//  Copyright © 2018 Michael Chang. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var bodyparts_create = [Bodyparts]()
    var selected_picker = Bodyparts()
    var exerciseTextField = Exercise()
    var exercises = [Exercise]()
    
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: nil))
        
        present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func saveExercise(_ sender: Any) {
        if exercise.text == "" {
            self.displayAlertWithTitle(title: "No Sets in Current Exercise",
                                       message: "Please add some to sets to the exercise")
        }
        else {
            exerciseTextField.name = exercise.text!
            selected_picker.exercises.append(exerciseTextField)
            exercises.append(exerciseTextField)
            self.performSegue(withIdentifier: "createExercise", sender: nil)
        }
    }
    @IBOutlet weak var exercise: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var picker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        selected_picker = bodyparts_create[0]
        self.picker.delegate = self
        self.picker.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bodyparts_create.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bodyparts_create[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected_picker = bodyparts_create[row]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "createExercise") {
            let destinationVC = segue.destination as! FirstViewController
            let targetController = destinationVC
            targetController.bodyparts = bodyparts_create
            targetController.all_exercises = exercises
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
