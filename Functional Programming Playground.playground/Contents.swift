//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

// Context: building an amusement park app
// Assume that the park's ride data is provided by an API on a remote server.

enum RideType {
    case Family
    case Kids
    case Thrill
    case Scary
    case Relaxing
    case Water
}

struct Ride {
    let name: String
    let types: Set<RideType>
    let waitTime: Double
}

// Functional programming is just another software writing approach, it is a paradigm.
// Functional programming encourages a declarative approach to solving problems 
// (rather than imperative) using functions.

// Key concepts: immutable state and lack of side effects

// MARK: - Immutability and side effects

var x = 3
// other stuff..
x = 4
// You told me x was 3! Why is it now 4??

// Mutable state can be dangerous in a large OOP project, where two different threads could try to
// acces and mutate the variable concurrently, causing unexpected behaviors such as a race condition
// (the variable is mutated before your expectations) or a deadlock (both thread block each other 
// and both cease to function)

// Key benefit of using immutable date is that the units of code that use it will be free of side
// effects (from other units of code) and will not cause any neither.

let parkRides = [
    Ride(name: "Raging Rapids", types: [.Family, .Thrill, .Water], waitTime: 45.0),
    Ride(name: "Crazy Funhouse", types: [.Family], waitTime: 10.0),
    Ride(name: "Spinning Tea Cups", types: [.Kids], waitTime: 15.0),
    Ride(name: "Spooky Hollow", types: [.Scary], waitTime: 30.0),
    Ride(name: "Thunder Coaster", types: [.Family, .Thrill], waitTime: 60.0),
    Ride(name: "Grand Carousel", types: [.Family, .Kids], waitTime: 15.0),
    Ride(name: "Bumper Boats", types: [.Family, .Water], waitTime: 25.0),
    Ride(name: "Mountain Railroad", types: [.Family, .Relaxing], waitTime: 0.0)
]

// Both the array parkRides and its contents are immutable since we initialized the array with let
// parkRides[0] = Ride(name: "Test", types: [.Family], waitTime: 5.0)
// will produce a compiler error: Cannot assign through subscript: parkRides is a let constant

// MARK: - Modularity

// Suppose we need an alphabetical list of all the rides' names, using an insertion sort

//func sortedNames(rides: [Ride]) -> [String] {
//    var sortedRides = rides
//    var i, j: Int
//    var key: Ride
//    
//    // Looping over all the rides passed into the function
//    for (i = 0; i < sortedRides.count; i++) {
//        key = sortedRides[i]
//        
//        // Performing an insertion sort
//        for (j = i; j > -1; j--) {
//            if key.name.localizedCompare(sortedRides[j].name) == .orderedAscending {
//                sortedRides.remove(at: j + 1)
//                sortedRides.insert(key, at: j)
//            }
//        }
//    }
//    
//    // Gathering the names of the sorted rides
//    var sortedNames = [String]()
//    for ride in sortedRides {
//        sortedNames.append(ride.name)
//    }
//    
//    print(sortedRides)
//    return sortedNames
//}

// Alternative implementation as the one provided in tutorial is not supported in Swift 3

func sortedNamesBis(rides: [Ride]) -> [String] {
    var sortedRides = rides
    
    for primaryIndex in 0..<sortedRides.count {
        let key = sortedRides[primaryIndex]
        var secondaryIndex = primaryIndex
        
        while secondaryIndex > -1 {
            if key.name < sortedRides[secondaryIndex].name {
                sortedRides.remove(at: secondaryIndex + 1)
                sortedRides.insert(key, at: secondaryIndex)
            }
            secondaryIndex -= 1
        }
    }
    
    var sortedNames = [String]()
    for ride in sortedRides {
        sortedNames.append(ride.name)
    }
    
    return sortedNames
}

print(sortedNamesBis(rides: parkRides))

// The above function didn't affect the original rides list (parkRides) - since we made 
// a copy of it (sortedRides). Therefore the function could be considered quasi-functional
// despite all the imperative code: the logic of sorting rides by name is captured in a 
// single, testable modular and reusable function.
// Yet the imperative code makes for a pretty big function, which could be improve!


