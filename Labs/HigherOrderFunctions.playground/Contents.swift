import UIKit
import Foundation

// Higher order functions

// MARK: - MAP


var numberArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

// Forma tradicional
var emptyArray: [Int] = []
for number in numberArray {
    emptyArray.append(number*2)
}

// Funciones
var newArray = numberArray.map { (value) -> Int in
    return value * 2
}
newArray

var newArray2 = numberArray.map { (value: Int) in
    return value * 2
}
newArray2

var newArray3 = numberArray.map { $0 * 2 }
newArray3

// MARK: - FILTER


var cities: [String] = ["Cordoba", "Madrid", "Malaga", "Caracas", "Milan", "Roma"]

// Forma tradicional
var citiesWithM: [String] = []
for city in cities {
    if city.hasPrefix("M") {
        citiesWithM.append(city)
    }
}

// Functions
let citiesWithM2 = cities.filter({ $0.hasPrefix("M") })
citiesWithM


// MARK: - REDUCE

// Forma tradicional
var sum: Int = 0
for number in numberArray {
    sum += number
}

// Function
var total = numberArray.reduce(0, +)

var total2 = numberArray.reduce(0, { $0 + $1 })
total2

var stringsReduced = cities.reduce("", { $0 + $1 })
stringsReduced

// MARK: - FlatMap / CompactMap

let multipleArray = [[1, 2, 3], [4, 5, 6]]

let flatArray = multipleArray.flatMap({ $0 })
flatArray

var cities2: [String?] = ["Cordoba", nil, "Madrid", "Malaga", "Caracas", nil, "Milan", "Roma"]

let validCities = cities2.compactMap({ $0 })
validCities

// MARK: ENCADENAR
var value = multipleArray.flatMap({ $0 }).filter({ $0 % 2 == 0})
