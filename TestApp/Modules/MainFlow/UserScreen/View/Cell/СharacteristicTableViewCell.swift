//
//  СharacteristicTableViewCell.swift
//  TestApp
//
//  Created by Anton on 01.02.2023.
//

import Foundation

import UIKit

class СharacteristicTableViewCell: UITableViewCell, Reusable {
    
    var model: UserInformationType? {
        didSet {
            handleUI(model: model)
        }
    }
    
    var value: String? {
        didSet {
            handleValue(value: value)
        }
    }
    
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.font = .Gilroy(type: .bold, ofSize: 24)
        obj.textColor = .Custom(type: .purple)
        return obj
    }()
    
    let valueLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .Custom(type: .gray)
        obj.font = .Gilroy(type: .bold, ofSize: 24)
        obj.numberOfLines = 0
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8.sizeW)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8.sizeW)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8.sizeW)
            make.trailing.equalToSuperview().offset(-8.sizeW)
        }
    }
}

//MARK: Helpers
extension СharacteristicTableViewCell {
    private func handleUI(model: UserInformationType?) {
        guard let model = model else {
            titleLabel.text = "-"
            return
        }
        titleLabel.text = model.title
    }
    
    private func handleValue(value: String?) {
        guard let value = value else {
            valueLabel.text = "-"
            return
        }
        valueLabel.text = value
    }
}
