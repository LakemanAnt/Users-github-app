//
//  UsersTableViewCell.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

class UsersTableViewCell: UITableViewCell, Reusable {

    private let nameLabel: UILabel = {
        let obj = UILabel()
        obj.text = "Test text"
        
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
        
        addSubview(nameLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
