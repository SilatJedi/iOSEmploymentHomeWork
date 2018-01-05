//
//  Backend.swift
//  
//
//  Created by Josh Lytle on 9/19/17.
//
//

import Foundation
import Standard

class Backend {
    static func getPassengers(completion: (_ results: [[String: Any]]) -> Void) {
        var passengerList: [[String: Any]] = [:]
        
        for i in 0..<50 {
            var passenger: [String: Any] = [:]
            passenger["id"] = i
            passenger["fullname"] = randomName()
            passenger["age"] = arc4random_uniform(100)
            passenger["weight"] = 75 + arc4random_uniform(200)
            
            passenger.append(passenger)
        }
        
        completion(passengerList)
    }
    
    private static func randomName() -> String {
        let firstnames = ["Morty", "Kevin", "Tyrell", "Meryl", "Yong", "Megan", "Irwin", "Rufus", "Rosario", "Marjorie", "Teresia", "Ursula", "Charity", "Micha", "Giuseppe", "Temika", "Meghan", "Lissette", "Genesis", "Belle", "Tiesha", "Velva", "Sima", "Soraya", "Louis", "Glenda", "Thersa", "Lesli", "Saul", "Rueben", "Cortney", "Niesha", "Clorinda", "Shante", "Nereida", "Yvette", "Ardith", "Douglass", "Candra", "Hedy", "Ammie", "Margareta", "Flossie", "Dillon", "Hiroko", "Lester","Rick", "Fonda", "Willian", "Julian", "Winston", "Clarice"]
        let lastnames = ["Smith", "Jones", "Jackson", "Maxwell", "Trump", "Clinton", "Sanchez", "Williams", "Johnson", "Miller", "Taylor", "Thomas", "Garcia"]
        
        return firstnames[arc4random_uniform(firstnames.count)] + " " + lastnames[arc4random_uniform(lastnames.count)]
    }

}
