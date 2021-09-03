//
//  MeteoriteLandingAPI.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Moya

enum MeteoriteLandingAPI: TargetType {
    case getLandings
}

extension MeteoriteLandingAPI {
    var baseURL: URL {
        return URL(string: "https://data.nasa.gov/resource/")!
    }
    
    var path: String {
        switch self {
        case .getLandings:
            return "y77d-th95.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getLandings:
            return .get
        }
    }
    
    var sampleData: Data {
        
    }
    
    var task: Task
    
    var headers: [String : String]?
    
    
}
