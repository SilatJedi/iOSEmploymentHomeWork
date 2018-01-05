//: Playground - noun: a place where people can play

import UIKit


let AIRPLANE_CAPACITY = 26


/*
 You have been contracted to build an app for the airline industry.  Please complete the following tasks.
 */

/*
 1) Create a model object for a passenger.
 
 Example JSON object would look like:
 {
   "id": 5,
   "fullname": "Rick Sanchez",
   "age": 73,
   "weight: 142
 }
*/

class Passenger {
    var id = 0
    var fullName = ""
    var age = 0
    var weight = 0
    var seat = ""
    
    convenience init(id: Int, fullName: String, age: Int, weight: Int) {
        self.init()
        self.id = id
        self.fullName = fullName
        self.age = age
        self.weight = weight
    }
}


/*
 2) Create a model object for the plane.  The plane will need properties for a passenger list.
*/

class Plane {
    var id = 0
    var capacity = 0
    var passengers = [Passenger]()
    
    convenience init (id: Int, capacity: Int) {
        self.init()
        self.id = id
        self.capacity = capacity
    }
}
/*
 3) Create a plane and fill it with passengers by using the provided Backend.getPassengers(: ) method.
*/

let mrsPancakesPlane = Plane(id: 911, capacity: AIRPLANE_CAPACITY)

Backend.getPassengers(capacity: mrsPancakesPlane.capacity, completion: { results in
    for result in results {
        var id = 0
        var fullName = ""
        var age = 0
        var weight = 0
        
        if let resultId = result["id"] as? Int {
            id = resultId
        }
        if let resultFullName = result["fullname"] as? String {
            fullName = resultFullName
        }
        if let resultAge = result["age"] as? Int {
            age = resultAge
        }
        if let resultWeight = result["weight"] as? Int {
            weight = resultWeight
        }
        
        mrsPancakesPlane.passengers.append(
            Passenger(
                id: id,
                fullName: fullName,
                age: age,
                weight: weight
            )
        )
    }
})


/*
 4) Assign seats to passengers in attempt to keep the planes weight balanced from side to side.
 Assumptions:
 - Seats are assigned by row, with 4 seats per row.  eg. 1A, 1B, 1C, 1D.
 - All seats are will be filled.
 
 Print the passenger list with their assigned seat.
*/

/*
 5) Update your plane to accept a total capacity, then update Backend.swift to return enough passengers to fill the plane.
*/


mrsPancakesPlane.passengers.sort(by: {$0.weight > $1.weight}) //pre-sort(makes the final sort better. trust me)
var seatAssignments = [Passenger]()
var rowIndex = 1

for i in stride(from: 0, to: mrsPancakesPlane.passengers.count, by: 4) {
    var passengerRow = [Passenger]()

    if i < mrsPancakesPlane.passengers.count  {
        passengerRow.append(mrsPancakesPlane.passengers[i])
    }
    if i + 1 < mrsPancakesPlane.passengers.count  {
        passengerRow.append(mrsPancakesPlane.passengers[i + 1])
    }
    if i + 2 < mrsPancakesPlane.passengers.count  {
        passengerRow.append(mrsPancakesPlane.passengers[i + 2])
    }
    if i + 3 < mrsPancakesPlane.passengers.count  {
        passengerRow.append(mrsPancakesPlane.passengers[i + 3])
    }
    
    passengerRow.sort(by: {$0.weight > $1.weight})//sort descending by weight

    if passengerRow.count == 4 {
        passengerRow[0].seat = "\(rowIndex)B"//heavy ppl in the middle(easier to balance)
        passengerRow[1].seat = "\(rowIndex)C"
        passengerRow[2].seat = "\(rowIndex)D"//heaviest light person on the same side as lightest heavy
        passengerRow[3].seat = "\(rowIndex)A"//lightest person on same side as heaviest
        seatAssignments.append(passengerRow[3])
        seatAssignments.append(passengerRow[0])
        seatAssignments.append(passengerRow[1])
        seatAssignments.append(passengerRow[2])
    }
    else {
        for (index, passenger) in passengerRow.enumerated() {
            switch index {
            case 0:
                passenger.seat = "\(rowIndex)A"
                seatAssignments.append(passenger)
                break
            case 1:
                passenger.seat = "\(rowIndex)B"
                seatAssignments.append(passenger)
                break
            case 2:
                passenger.seat = "\(rowIndex)C"
                seatAssignments.append(passenger)
                break
            default: break
            }
        }
    }
    rowIndex += 1
    
}

for passenger in seatAssignments {
    print("\(passenger.fullName)      seat: \(passenger.seat)        weight: \(passenger.weight) lbs")
}






