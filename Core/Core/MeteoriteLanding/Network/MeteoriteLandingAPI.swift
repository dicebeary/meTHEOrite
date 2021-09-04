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
        return URL(string: "https://data.nasa.gov/resource")!
    }
    
    var path: String {
        switch self {
        case .getLandings:
            return "/y77d-th95.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getLandings:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getLandings:
            return StubbedResponse.getResponse(from: "nasa")
        }
    }
    
    var task: Task {
        switch self {
        case .getLandings:
            return .requestParameters(parameters: ["$where": "year>'1900-01-01T00:00:00.000'"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["X-App-Token": CoreConstants.appToken]
    }
}
