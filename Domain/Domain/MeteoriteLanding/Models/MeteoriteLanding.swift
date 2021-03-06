//
//  MeteoriteLanding.swift
//  Domain
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

public struct MeteoriteLanding {
    public let name: String
    public let id: String
    public let meteoriteClass: String
    public let mass: Double?
    public let fall: FallingState?
    public let year: Date
    public let location: GeoLocation?
    
    public init(name: String,
                id: String,
                meteoriteClass: String,
                mass: Double?,
                fall: FallingState?,
                year: Date,
                location: GeoLocation?) {
        self.name = name
        self.id = id
        self.meteoriteClass = meteoriteClass
        self.mass = mass
        self.fall = fall
        self.year = year
        self.location = location
    }
}
