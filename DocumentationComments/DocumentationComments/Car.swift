//
//  Car.swift
//  DocumentationComments
//
//  Created by omaestra on 23/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

class Car {
    /// The car's brand name
    var make: String
    /// The car's model
    var model: String
    /// Car's built year
    var year: Int
    
    /// The number of trips traveled by the car.
    private(set) var numberOfTrips: Int
    
    /// The total distance traveled by the car, in meters.
    private(set) var distanceTraveled: Double
    
    // MARK: - Initializers
    
    /**
     Initializes a new car with the provided properties.
     
     - Parameter make: The brand of the car
     - Parameter model: The car's model
     - Parameter year: The year when the car was built
     
     - Returns: A beautiful, brand-new car object.
     */
    init(make: String, model: String, year: Int) {
        self.make = make
        self.model = model
        self.year = year
        
        self.numberOfTrips = 0
        self.distanceTraveled = 0
    }
    
    /**
     Takes a car for a drive.
     
     Calling this method increments the `numberOfTrips` variable
     and increases `distanceTraveled` by the value of `meters`.
     
     - Parameter meters: The distance to travel in meters.
     - Precondition: `meters` must be greater than 0.
     */
    func travel(distance meters: Double) {
        // TODO: Update this to avoid closing the app.
        precondition(meters > 0)
        distanceTraveled += meters
        numberOfTrips += 1
    }
}

// MARK: - CustomStringConvertible

extension Car: CustomStringConvertible {
    public var description: String {
        // FIXME: User a thousand separator formatter to print 1.991 as year.
        // FIXME: User a distance formatter.
        return "My car is a \(year) \(self.make), \(model) that have traveled around \(self.distanceTraveled) meters"
    }
}
