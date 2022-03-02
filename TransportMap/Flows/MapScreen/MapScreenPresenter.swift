//
//  MapScreenPresenter.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 24.02.2022.
//

import Foundation

protocol MapScreenPresenter {
    func didTriggerViewReadyEvent()
}


final class MapScreenPresenterImp {
    
    weak var view: MapScreenView?
    
    // MARK: - Private Properies
    
    private let networkManager = NetworkManager()
    private let station: TransportModel.TransportData
 
    // MARK: - Initialization
    
    init(station: TransportModel.TransportData) {
        self.station = station
    }
}

// MARK: - MapPresenter

extension MapScreenPresenterImp: MapScreenPresenter {
    func didTriggerViewReadyEvent() {
        view?.showStation(station: station)
        
        networkManager.fetchStationInfo(id: station.id) { [weak self] stationInfoModel in
            guard let stationInfo = stationInfoModel.routePath.first else { return }
            self?.view?.showStationInfo(stationInfo: stationInfo)
        }
    }
}
