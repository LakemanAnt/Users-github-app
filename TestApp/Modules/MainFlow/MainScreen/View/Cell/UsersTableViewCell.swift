//
//  UsersTableViewCell.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

class UsersTableViewCell: UITableViewCell, Reusable {

    var model: UserModel? {
        didSet{
            handleUI()
        }
    }
    
    let avatarImageView: UIImageView = {
        let obj = UIImageView()
        obj.clipsToBounds = true
        obj.contentMode = .scaleAspectFit
        obj.backgroundColor = .Custom(type: .gray)
        return obj
    }()
    
    private let nameTitleLabel: UILabel = {
        let obj = UILabel()
        obj.font = .Gilroy(type: .semibold, ofSize: 16)
        obj.text = "user_name_title_text".localized
        obj.textColor = .Custom(type: .purple)
        return obj
    }()
    
    private let nameLabel: UILabel = {
        let obj = UILabel()
        obj.font = .Gilroy(type: .bold, ofSize: 16)
        obj.textColor = .Custom(type: .gray)
        return obj
    }()
    
    private let userTypeLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .Custom(type: .gray)
        obj.font = .Gilroy(type: .bold, ofSize: 16)
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layoutIfNeeded()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameTitleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(userTypeLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8.sizeW)
            make.centerY.equalToSuperview()
            make.size.equalTo(64)
        }
        
        nameTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16.sizeW)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameTitleLabel.snp.trailing).offset(4.sizeW)
            make.centerY.equalToSuperview()
        }
        
        userTypeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8.sizeW)
            make.centerY.equalToSuperview()
        }
    }
}

//MARK: Helpers
extension UsersTableViewCell {
    private func handleUI() {
        guard let model = self.model else {
            return
            
        }
        self.nameLabel.text = model.login
        self.userTypeLabel.text = model.type
        setImageAvatarFromApi(url: model.avatarURL)
        super.layoutSubviews()
    }
}

//MARK: API
extension UsersTableViewCell {
    private func setImageAvatarFromApi(url imageUrl: String) {
        UserManager.shared.downloadImage(url: imageUrl) { result in
            switch result {
            case .success(let image):
                self.avatarImageView.image = image
            case .failure(let error):
                if Connectivity.isConnectedToInternet {
                    ErrorAlert.showErrorAlert(with: error.localizedDescription)
                } else {
                    ErrorAlert.showErrorAlert(with: "error_no_internet_text".localized)
                }
            }
        }
    }
}
