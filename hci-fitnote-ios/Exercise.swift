//
//  Exercise.swift
//  hci-fitnote-ios
//
//  Created by Diego Sierra on 4/5/18.
//  Copyright © 2018 Michael Chang. All rights reserved.
//

import Foundation

extension Exercise: Equatable { }

func ==(lhs: Exercise, rhs: Exercise) -> Bool {
    return lhs.name == rhs.name // === returns true when both references point to the same object
}

class Exercise {
    var name: String? = ""
    var sets = [WorkoutSet]()  // sets is an array of integers with the sets and reps
}
