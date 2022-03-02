//
//  MapScreenAssembly.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 24.02.2022.
//

import Foundation
import UIKit

final class MapScreenAssembly {
    func assembly(with context: Context) -> MapScreenViewController {
        let controller = MapScreenViewController()
        let presenter = MapScreenPresenterImp(station: context.station)
        
        controller.presenter = presenter
        presenter.view = controller
        
        return controller
    }
}

extension MapScreenAssembly {
    struct Context {
        let station: TransportModel.TransportData
    }
}
