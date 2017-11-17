//: Playground - noun: a place where people can play

import UIKit

let optInt1: Int? = 4

// This works as expected
let optIntNum1 = optInt1.map({ return NSNumber(value: $0) })

// Does this work?
// This throws an error: ambiguous use of 'init'
//let optIntNum2 = optInt1.map(NSNumber.init)

// Does this work?
// This throws an error: value of type 'Int' has no member 'map'
//let optIntNum3 = optInt1?.map({ return NSNumber(value: $0) })




