//
//  Sample.swift
//  SpatialDBDataEntry
//
//  Created by Karan Sequeira on 10/11/17.
//  Copyright © 2017 University of Utah. All rights reserved.
//

import Foundation
import os.log
import CoreLocation

enum SampleType: Int {
    case ground
    case lake
    case riverOrStream
    case tap
    case precipitation
    case spring
    case ocean
    case irrigation
    case bottled
    case iceCore
    case snowPit
    case firnCore
    case vapor
    case canal
    case sprinkler
    case mine
    case cloudWater
    
    var description: String {
        switch self {
        case .ground:               return "Ground"
        case .lake:                 return "Lake"
        case .riverOrStream:        return "River or Stream"
        case .tap:                  return "Tap"
        case .precipitation:        return "Precipitation"
        case .spring:               return "Spring"
        case .ocean:                return "Ocean"
        case .irrigation:           return "Irrigation"
        case .bottled:              return "Bottled"
        case .iceCore:              return "Ice Core"
        case .snowPit:              return "Snow Pit"
        case .firnCore:             return "Firn Core"
        case .vapor:                return "Vapor"
        case .canal:                return "Canal"
        case .sprinkler:            return "Sprinkler"
        case .mine:                 return "Mine"
        case .cloudWater:           return "Cloud Water"
        }
    }
    
    static var count: Int {
        return 17
    }
}

enum PhaseType: Int {
    case none
    case liquid
    case solid
    case mixed
    
    var description: String {
        switch self {
        case .none:                 return ""
        case .liquid:               return "Liquid"
        case .solid:                return "Solid"
        case .mixed:                return "Mixed"
        }
    }
    
    static var count: Int {
        return 4
    }
}

class Sample: NSObject, NSCoding {
    
    //MARK: Properties
    
    var id: String
    var siteID: String
    var type: SampleType
    var dateTime: Date
    var startDateTime: Date
    var depth: Int = -1
    var volume: Int = -1
    var phase: PhaseType = PhaseType.none
    var comments: String = ""
    
    //MARK: Types
    
    struct PropertyKeys {
        static let sampleID = "sampleID"
        static let siteID = "siteID"
        static let type = "sampleType"
        static let dateTime = "dateTime"
        static let startDateTime = "startDateTime"
        static let depth = "depth"
        static let volume = "volume"
        static let phase = "phase"
        static let comments = "sampleComments"
    }
    
    //MARK: Initialization
    
    init?(id: String, siteID: String, type: SampleType, dateTime: Date, startDateTime: Date) {
        guard !id.isEmpty else {
            return nil
        }
        
        self.id = id
        self.siteID = siteID
        self.type = type
        self.dateTime = dateTime
        self.startDateTime = startDateTime
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKeys.sampleID)
        aCoder.encode(siteID, forKey: PropertyKeys.siteID)
        aCoder.encode(type.rawValue, forKey: PropertyKeys.type)
        aCoder.encode(dateTime, forKey: PropertyKeys.dateTime)
        aCoder.encode(startDateTime, forKey: PropertyKeys.startDateTime)
        aCoder.encode(depth, forKey: PropertyKeys.depth)
        aCoder.encode(volume, forKey: PropertyKeys.volume)
        aCoder.encode(phase.rawValue, forKey: PropertyKeys.phase)
        aCoder.encode(comments, forKey: PropertyKeys.comments)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeObject(forKey: PropertyKeys.sampleID) as? String else {
            os_log("Unable to decode the id for a Site object!", log: .default, type: .debug)
            return nil
        }
        
        let siteID = aDecoder.decodeObject(forKey: PropertyKeys.siteID) as? String
        let type = SampleType(rawValue: aDecoder.decodeInteger(forKey: PropertyKeys.type))!
        let dateTime = aDecoder.decodeObject(forKey: PropertyKeys.dateTime) as? Date
        let startDateTime = aDecoder.decodeObject(forKey: PropertyKeys.startDateTime) as? Date
        let depth = aDecoder.decodeInteger(forKey: PropertyKeys.depth)
        let volume = aDecoder.decodeInteger(forKey: PropertyKeys.volume)
        let phase = PhaseType(rawValue: aDecoder.decodeInteger(forKey: PropertyKeys.phase))!
        let comments = aDecoder.decodeObject(forKey: PropertyKeys.comments) as? String
        
        self.init(id: id, siteID: siteID!, type: type, dateTime: dateTime!, startDateTime: startDateTime!)
        
        self.depth = depth
        self.volume = volume
        self.phase = phase
        self.comments = comments ?? ""
    }
    
}
