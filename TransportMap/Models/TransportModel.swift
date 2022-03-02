//
//  TransportModel.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 25.02.2022.
//

import Foundation

struct TransportModel: Codable {
    let data: [TransportData]
    
    struct TransportData: Codable {
        let id: String
        let lat, lon: Double
        let name: String
    }
}
