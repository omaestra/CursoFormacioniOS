/*:
 ## Exercise - Type Casting and Inspection
 
 Create a collection of type [Any], including a few doubles, integers, strings, and booleans within the collection. Print the contents of the collection.
 */
let collection: [Any] = [2.3, 2, "Hello", 5.4, true, false]
print(collection)
/*:
 Loop through the collection. For each integer, print "The integer has a value of ", followed by the integer value. Repeat the steps for doubles, strings and booleans.
 */
for value in collection {
    switch value.self {
    case is Int:
        print("The integer has a value of \(value as! Int)")
    case is Double:
        print("The \(type(of: value)) has a value of \(value as! Double)")
    case is String:
        print("The string has a value of \(value as! String)")
    default:
        break
    }
}

for value in collection {
    switch value {
    case let integer as Int:
        print("The integer has a value of \(integer)")
    default:
        break
    }
}

for value in collection {
    if let value = value as? Int {
        print("\(value) is an Int")
    }
}

collection.forEach({
    if let value = $0 as? Int {
        
    }
})

/*:
 Create a [String : Any] dictionary, where the values are a mixture of doubles, integers, strings, and booleans. Print the key/value pairs within the collection
 */
let dict: [String: Any] = ["string": "hello", "integer": 4, "double": 5.3, "bool": false]

for pair in dict {
    print(pair)
}
/*:
 Create a variable `total` of type `Double` set to 0. Then loop through the dictionary, and add the value of each integer and double to your variable's value. For each string value, add 1 to the total. For each boolean, add 2 to the total if the boolean is `true`, or subtract 3 if it's `false`. Print the value of `total`.
 */
var total: Double = 0
for pair in dict {
    switch pair.value.self {
    case is Int:
        total += Double(pair.value as! Int)
    case is Double:
        total += pair.value as! Double
    case is String:
        total += 1
    case is Bool:
        total += (pair.value as! Bool) ? 2 : -3
    default:
        break
    }
}

for pair in dict {
    switch pair.value {
    case let integer as Int:
        total += Double(integer)
    default:
        break
    }
}

for pair in dict {
    switch pair.value.self {
    case is Int:
        total += Double(pair.value as! Int)
    case is Double:
        total += pair.value as! Double
    case is String:
        total += 1
    case is Bool:
        total += (pair.value as! Bool) ? 2 : -3
    default:
        break
    }
}

print("TOTAL: \(total)")
/*:
 Create a variable `total2` of type `Double` set to 0. Loop through the collection again, adding up all the integers and doubles. For each string that you come across during the loop, attempt to convert the string into a number, and add that value to the total. Ignore booleans. Print the total.
 */
var total2: Double = 0
dict.map({
    if let value = $0.value as? Int {
        total2 += Double(value)
    }
    if let value = $0.value as? Double {
        total2 += Double(value)
    }
    guard let stringValue = $0.value as? String, let double = Double(stringValue) else { return }
    
    
//    if let stringValue = $0.value as? String, let doubleValue = Double(stringValue) {
//        total2 += Double(doubleValue)
//    }
})

print("TOTAL2 \(total2)")
//: page 1 of 2  |  [Next: App Exercise - Workout Types](@next)
