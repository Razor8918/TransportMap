//
//  StationScreenRouter.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 01.03.2022.
//

import Foundation
import UIKit

protocol StationScreenRouter {
    func showStationMap(station: TransportModel.TransportData)
}

final class StationScreenRouterImp {
    weak var rootController: UIViewController?
}

extension StationScreenRouterImp: StationScreenRouter {
    func showStationMap(station: TransportModel.TransportData) {
        let controler = MapScreenAssembly().assembly(with: .init(station: station))
        rootController?.navigationController?.pushViewController(controler, animated: true)
    }
}
