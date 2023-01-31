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
        obj.text = "Title"
        
        return obj
    }()
    
    let topDividingLineView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .gray
        return obj
    }()
    
    let bottomDividingLineView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .gray
        return obj
    }()
    
    let usersTableView: UITableView = {
        let obj = UITableView()
        obj.showsVerticalScrollIndicator = false
        obj.separatorStyle = .none
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
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(topDividingLineView)
        addSubview(usersTableView)
        addSubview(bottomDividingLineView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.sizeH)
            make.centerX.equalToSuperview()
        }
        
        topDividingLineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16.sizeH)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(16.sizeW)
        }
        
        usersTableView.snp.makeConstraints { make in
            make.top.equalTo(topDividingLineView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16.sizeW)
            make.bottom.equalTo(bottomDividingLineView.snp.top)
        }
        
        bottomDividingLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(16.sizeW)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16.sizeH)
        }
    }
}
