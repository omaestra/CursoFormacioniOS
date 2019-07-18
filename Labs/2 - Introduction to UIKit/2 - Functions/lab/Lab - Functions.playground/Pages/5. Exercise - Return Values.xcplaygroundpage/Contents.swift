/*:
 ## Exercise - Return Values and Tuples
 
 Write a function called `greeting` that takes a `String` argument called name, and returns a `String` that greets the name that was passed into the function. I.e. if you pass in "Dan" the return value might be "Hi, Dan! How are you?" Use the function and print the result.
 */
func function() -> (name: String, lastName: String) {
    return (name: "Oswaldo", lastName: "Maestra")
    
}

let y = function()

//for i in 1...3 {
//    print(i)
//}

func multipleParams(numbers: [Int]) {
    for number in numbers {
        print(number)
    }
}

multipleParams(numbers: [2,3,4,5,6])

/*:
 Write a function that takes two `Int` arguments, and returns an `Int`. The function should multiply the two arguments, add 2, then return the result. Use the function and print the result.
 */


//: [Previous](@previous)  |  page 5 of 6  |  [Next: App Exercise - Separating Functions](@next)
