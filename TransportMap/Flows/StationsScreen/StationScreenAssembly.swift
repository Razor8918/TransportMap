//
//  StationScreenAssembly.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 01.03.2022.
//

import Foundation

final class StationScreenAssembly {
    static func assembly() -> StationScreenViewController {
        let controller = StationScreenViewController()
        let router = StationScreenRouterImp()
        let presenter = StationScreenPresenterImp(router: router)
        
        controller.presenter = presenter
        presenter.view = controller
        router.rootController = controller
        
        return controller
    }
}
