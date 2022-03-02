//
//  StationTableViewCell.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 01.03.2022.
//

import UIKit
import SnapKit

final class StationTableViewCell: UITableViewCell {
    
    var onCellTapped: (() -> Void)?
    
    private let titleLabel = UILabel()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            onCellTapped?()
        }
    }
    
    // MARK: - Internal Methods
    
    func configure(stationData: TransportModel.TransportData) {
        titleLabel.text = stationData.name
    }
}

// MARK: - Private Methods

private extension StationTableViewCell {
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
