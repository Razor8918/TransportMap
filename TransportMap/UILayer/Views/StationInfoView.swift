//
//  StationInfoView.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 01.03.2022.
//

import UIKit
import SnapKit

final class StationInfoView: UIView {
    
    //MARK: - Private Properties

    private let mainLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupConstraints()
        mainLabel.numberOfLines = 0
        activityIndicator.startAnimating()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func configure(with stationInfo: StationInfoModel.RoutePath) {
        let arriveTime = stationInfo.timeArrival.joined(separator: " / ")
        mainLabel.text = "Тип транспорта: " + stationInfo.type + "\n" + "Время прибытия: " + arriveTime
        activityIndicator.stopAnimating()
    }
}

// MARK: - Private Methods

private extension StationInfoView {
    func setupConstraints() {
        [mainLabel,
         activityIndicator
        ].forEach { customView in
            addSubview(customView)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(24)
            make.right.bottom.equalToSuperview().offset(-24)
        }
    }
}

