//
//  StationInfoModel.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 01.03.2022.
//

import Foundation

struct StationInfoModel: Codable {
    let routePath: [RoutePath]
    
    struct RoutePath: Codable {
        let type: String
        let timeArrival: [String]
    }
}
