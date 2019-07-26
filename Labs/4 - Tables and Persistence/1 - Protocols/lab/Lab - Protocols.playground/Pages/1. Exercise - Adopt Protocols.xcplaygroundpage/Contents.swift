/*:
 ## Exercise - Adopt Protocols: CustomStringConvertible, Equatable, and Comparable
 
 Create a `Human` class with two properties: `name` of type `String`, and `age` of type `Int`. You'll need to create a memberwise initializer for the class. Initialize two `Human` instances.
 */
class Human: CustomStringConvertible, Equatable, Comparable, Codable {
    static func < (lhs: Human, rhs: Human) -> Bool {
        return lhs.age < rhs.age
    }
    
    static func == (lhs: Human, rhs: Human) -> Bool {
        return ((lhs.name == rhs.name) && (lhs.age == rhs.age))
    }
    
    var description: String {
        return "\(self.name) \(self.age)"
    }
    
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    
}

let human1 = Human(name: "Human 1", age: 23)
let human2 = Human(name: "Human 2", age: 30)

/*:
 Make the `Human` class adopt the `CustomStringConvertible`. Print both of your previously initialized `Human` objects.
 */
print(human1)
print(human2)

/*:
 Make the `Human` class adopt the `Equatable` protocol. Two instances of `Human` should be considered equal if their names and ages are identical to one another. Print the result of a boolean expression evaluating whether or not your two previously initialized `Human` objects are equal to eachother (using `==`). Then print the result of a boolean expression evaluating whether or not your two previously initialized `Human` objects are not equal to eachother (using `!=`).
 */
print(human1 == human2)
print(human1 != human2)

/*:
 Make the `Human` class adopt the `Comparable` protocol. Sorting should be based on age. Create another three instances of a `Human`, then create an array called `people` of type `[Human]` with all of the `Human` objects that you have initialized. Create a new array called `sortedPeople` of type `[Human]` that is the `people` array sorted by age.
 */
let human3 = Human(name: "Human 3", age: 16)
let human4 = Human(name: "Human 4", age: 32)
let human5 = Human(name: "Human 5", age: 54)

let people: [Human] = [human1, human2, human3, human4, human5]
let sortedPeople: [Human] = people.sorted()
/*:
 Make the `Human` class adopt the `Codable` protocol. Create a `JSONEncoder` and use it to encode as data one of the `Human` objects you have initialized. Then use that `Data` object to initialize a `String` representing the data that is stored, and print it to the console.
 */
import Foundation

let encoder = JSONEncoder()
let human1Data = try! encoder.encode(human1)
let human1String = String(data: human1Data, encoding: .utf8)

print(human1String)
//: page 1 of 5  |  [Next: App Exercise - Printable Workouts](@next)
