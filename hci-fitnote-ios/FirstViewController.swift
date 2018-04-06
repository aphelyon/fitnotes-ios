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

class FirstViewController: UIViewController {
    
    var bodyparts = [Bodyparts]();
    
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
                        }
                        bodypart.exercises = exercises
                    }
                    
                }
                self.bodyparts.append(bodypart)
            }
            
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addWorkout") {
            let destinationVC = segue.destination as! UINavigationController
            let targetController = destinationVC.topViewController as! AddWorkoutViewController
            targetController.tableentries = self.bodyparts
        }
        
        if (segue.identifier == "addWorkout2") {
            let destinationVC = segue.destination as! UINavigationController
            let targetController = destinationVC.topViewController as! AddWorkoutViewController
            targetController.tableentries = self.bodyparts

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

