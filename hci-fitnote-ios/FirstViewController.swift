//
//  FirstViewController.swift
//  hci-fitnote-ios
//
//  Created by Michael Chang on 3/7/18.
//  Copyright © 2018 Michael Chang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
var ref: DatabaseReference!

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var textView: UITextView!
    
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: nil))
        
        present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func copyPreviousWorkout(_ sender: Any) {
        self.displayAlertWithTitle(title: "Feature not Implemented Yet",
                                   message: "Please contact the creator")
    }
    @IBAction func nextDay(_ sender: Any) {
        self.displayAlertWithTitle(title: "Feature not implemented yet",
                                   message: "Please contact the creator")
    }
    
    @IBAction func previousDay(_ sender: Any) {
        self.displayAlertWithTitle(title: "Feature not implemented yet",
                                   message: "Please contact the creator")
    }
    @IBOutlet weak var dateTextField: UILabel!
    @IBOutlet weak var workoutTextField: UILabel!
    
    @IBOutlet weak var startTextField: UILabel!
    @IBAction func unwindToFirst(segue:UIStoryboardSegue) {
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    var bodyparts = [Bodyparts]();
    var all_exercises = [Exercise]();
    var currentWorkout = Workout()
    var day = Day()
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("bodyparts").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            for (bodypartEntry, datr) in value! {
                var bodypart = Bodyparts()
                bodypart.name = bodypartEntry as! String
                for (key, value) in (datr as? NSDictionary)! {
                    var keyString = key as! String
                    if (keyString == "exercises") {
                        var exercises = [Exercise]();
                        for (items, item) in (value as? NSDictionary)! {
                            var exercise = Exercise()
                            exercise.name = item as! String
                            exercises.append(exercise)
                            if !(self.all_exercises.contains(exercise)) {
                                self.all_exercises.append(exercise)
                            }
                        }
                        bodypart.exercises = exercises
                    }
                    
                }
                self.bodyparts.append(bodypart)
            }
            
        })
        // Do any additional setup after loading the view, typically from a nib.
        if currentWorkout.exercises.count < 1 {
            self.tableView.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "search") {
            let destinationVC = segue.destination as! UINavigationController
            let targetController = destinationVC.topViewController as! SearchTableViewController
            targetController.tableentries = self.all_exercises
            targetController.bodyparts_search = self.bodyparts
            targetController.workout = self.currentWorkout
        }
        
        if (segue.identifier == "search2") {
            let destinationVC = segue.destination as! UINavigationController
            let targetController = destinationVC.topViewController as! SearchTableViewController
            targetController.tableentries = self.all_exercises
            targetController.bodyparts_search = self.bodyparts
            targetController.workout = self.currentWorkout
        }
        
        if (segue.identifier == "viewsets") {
            let destinationVC = segue.destination as! UINavigationController
            let targetController = destinationVC.topViewController as! EditSetsViewController
            targetController.navigationBar.title = currentWorkout.exercises[index!].name
            targetController.exercise = currentWorkout.exercises[index!]
        }
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
        return self.currentWorkout.exercises.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath[1]
        self.performSegue(withIdentifier: "viewsets", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "exercises"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let exercise = self.currentWorkout.exercises[indexPath.row].name
        
        cell.textLabel?.text = exercise
        
        return cell
    }

}

