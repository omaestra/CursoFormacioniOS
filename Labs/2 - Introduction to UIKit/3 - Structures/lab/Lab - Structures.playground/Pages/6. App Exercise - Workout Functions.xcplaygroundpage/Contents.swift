/*:
 ## App Exercise - Workout Functions
 
 >These exercises reinforce Swift concepts in the context of a fitness tracking app.
 
 A `RunningWorkout` struct has been created for you below. Add a method on `RunningWorkout` called `postWorkoutStats` that prints out the details of the run. Then create an instance of `RunningWorkout` and call `postWorkoutStats()`.
 */
struct RunningWorkout {
    var distance: Double = 10
    var time: Double
    var elevation: Double
    
    func postWorkoutStats() {
        print("\(distance), \(time), \(elevation)")
    }
}

let workout = RunningWorkout(distance: 10, time: 10, elevation: 10)
workout.postWorkoutStats()
/*:
 A `Steps` struct has been created for you below, representing the day's step-tracking data. It has the goal number of steps for the day and the number of steps taken so far. Create a method on `Steps` called `takeStep` that increments the value of `steps` by one. Then create an instance of `Steps` and call `takeStep()`. Print the value of the instance's `steps` property before and after the method call.
 */
class Steps {
    var steps: Int
    var goal: Int
    
    init(steps: Int, goal: Int) {
        self.steps = steps
        self.goal = goal
    }
    
    func getSteps() -> Int {
        return steps
    }
    
    func takeStep() {
        steps += 1
    }
}

var structSteps = Steps(steps: 0, goal: 1000)
print(structSteps.steps)
structSteps.takeStep()
print(structSteps.steps)

var structSteps2 = structSteps
print(structSteps2.steps)
structSteps2.takeStep()
structSteps2.takeStep()
structSteps2.takeStep()
structSteps2.takeStep()

print(structSteps.steps)
print(structSteps2.steps)




struct Prueba {
    var x: Double
}

struct Rectangle {
    var width: Double
    var height: Double
    var prueba: Prueba
    
    var area: Double {
        get {
            return self.width * self.height * self.prueba.x
        }
    }
}

//: [Previous](@previous)  |  page 6 of 10  |  [Next: Exercise - Computed Properties and Property Observers](@next)
