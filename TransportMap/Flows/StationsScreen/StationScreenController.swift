//
//  StationScreenController.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 01.03.2022.
//

import Foundation
import UIKit
import MapKit
import SnapKit

protocol StationScreenView: AnyObject {
    func updateUI()
}

class StationScreenViewController: UIViewController {
    // MARK: - Internal Properties
    
    var presenter: StationScreenPresenter?
    
    // MARK: - Private Properties
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Идет загрузка..."
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshStation), for: .valueChanged)
        
        presenter?.fetchCurrectStations()
        setupConstarints()
        registerCells()
    }
}

extension StationScreenViewController: StationScreenView {
    func updateUI() {
        title = "Список остановок"
        tableView.reloadData()
    }
}

extension StationScreenViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return presenter?.getStations().count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getStationCell(indexPath: indexPath)
    }
}

extension StationScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension StationScreenViewController {
    func getStationCell(indexPath: IndexPath) -> StationTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell", for: indexPath) as? StationTableViewCell,
              let station = presenter?.getStations()[indexPath.row]
        else { return StationTableViewCell() }
        
        cell.configure(stationData: station)
        
        cell.onCellTapped = { [weak self] in
            self?.presenter?.showStation(station: station)
        }
        
        return cell
    }
    
    func setupConstarints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func registerCells() {
        tableView.register(StationTableViewCell.self,
                           forCellReuseIdentifier: "StationTableViewCell")
    }
    
    @objc
    func refreshStation() {
        refreshControl.endRefreshing()
        presenter?.fetchCurrectStations()
    }
}

