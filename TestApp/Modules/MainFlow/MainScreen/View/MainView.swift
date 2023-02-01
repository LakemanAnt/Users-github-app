//
//  MainView.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    let titleLabel: UILabel = {
        let obj = UILabel()
        obj.font = .Gilroy(type: .bold, ofSize: 32.sizeH)
        obj.text = "users_list_title".localized
        obj.textColor = .Custom(type: .purple)

        return obj
    }()
    
    let topDividingLineView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .Custom(type: .purple)
        return obj
    }()

    let usersTableView: UITableView = {
        let obj = UITableView()
        obj.showsVerticalScrollIndicator = false
        obj.backgroundColor = .clear
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .Custom(type: .blueGray)
        
        addSubview(titleLabel)
        addSubview(topDividingLineView)
        addSubview(usersTableView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24.sizeH)
            make.centerX.equalToSuperview()
        }
        
        topDividingLineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16.sizeH)
            make.height.equalTo(1)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16.sizeW)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16.sizeW)
        }
        
        usersTableView.snp.makeConstraints { make in
            make.top.equalTo(topDividingLineView.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(24.sizeW)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-24.sizeW)
            make.bottom.equalToSuperview()
        }
    }
}

