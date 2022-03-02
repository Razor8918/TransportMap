//
//  MapScreenViewController.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 24.02.2022.
//

import UIKit
import Foundation
import MapKit
import SnapKit

protocol MapScreenView: AnyObject {
    func showStation(station: TransportModel.TransportData)
    func showStationInfo(stationInfo: StationInfoModel.RoutePath)
}

class MapScreenViewController: UIViewController {
    // MARK: - Internal Properties
    
    var presenter: MapScreenPresenter?
    
    // MARK: - Private Properties
    
    private let mapView = MKMapView()
    private let stationView = StationInfoView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupMapView()
        presenter?.didTriggerViewReadyEvent()
    }
}

// MARK: - Private Methods

private extension MapScreenViewController {
    func setupConstraints() {
        [mapView,
         stationView
        ].forEach { customView in
            view.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stationView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
    }
    
    func setupMapView() {
        mapView.showsScale = true
        mapView.showsUserLocation = true
        stationView.layer.cornerRadius = 16
    }
}

extension MapScreenViewController: MapScreenView {
    func showStation(station: TransportModel.TransportData) {
        let annotation = MKPointAnnotation()
        annotation.title = station.name
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: station.lat,
            longitude: station.lon
        )
        
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
        
        title = station.name
    }
    
    func showStationInfo(stationInfo: StationInfoModel.RoutePath) {
        stationView.configure(with: stationInfo)
    }
}
