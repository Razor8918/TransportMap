//
//  StationScreenPresenter.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 01.03.2022.
//

import Foundation

protocol StationScreenPresenter {
    func fetchCurrectStations()
    func getStations() -> [TransportModel.TransportData]
    func showStation(station: TransportModel.TransportData)
}


final class StationScreenPresenterImp {
    
    weak var view: StationScreenView?
    
    // MARK: - Private Properies
    
    private let networkManager = NetworkManager()
    
    private let router: StationScreenRouter
    
    private var stations: [TransportModel.TransportData] = []
    
    // MARK: - Initialization

    init(router: StationScreenRouter) {
        self.router = router
    }
}

extension StationScreenPresenterImp: StationScreenPresenter {
    func showStation(station: TransportModel.TransportData) {
        router.showStationMap(station: station)
    }
    
    func getStations() -> [TransportModel.TransportData] {
        return stations
    }
    
    func fetchCurrectStations() {
        networkManager.fetchCurrentStations { [weak self] stationsArray in
            self?.stations = stationsArray.data
            self?.view?.updateUI()
        }
    }
}
