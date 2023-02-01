//
//  UserView.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

class UserView: UIView {
    
    var model: UserInformationModel? {
        didSet {
            handleUI(model: model)
        }
    }
    
    let closeButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.backgroundColor = .clear
        obj.setImage(UIImage(systemName: "xmark"), for: .normal)
        obj.tintColor = .Custom(type: .purple)
        obj.layer.borderColor = UIColor.Custom(type: .purple).cgColor
        obj.layer.borderWidth = 1
        return obj
    }()
    
    let avatarImageView: UIImageView = {
        let obj = UIImageView()
        obj.clipsToBounds = true
        obj.backgroundColor = .Custom(type: .gray)
        return obj
    }()
    
    let loginLabel: UILabel = {
        let obj = UILabel()
        obj.font = .Gilroy(type: .bold, ofSize: 32)
        obj.textColor = .Custom(type: .purple)
        return obj
    }()
    
    let topDividingLineView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .Custom(type: .purple)
        return obj
    }()
    
    let informationTableView: UITableView = {
        let obj = UITableView()
        obj.showsVerticalScrollIndicator = false
        obj.backgroundColor = .clear
        obj.bounces = false
        return obj
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        closeButton.layer.cornerRadius = closeButton.bounds.height / 2
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
    private func setup() {
        backgroundColor = .Custom(type: .blueGray)
        
        addSubview(closeButton)
        addSubview(avatarImageView)
        addSubview(loginLabel)
        addSubview(topDividingLineView)
        addSubview(informationTableView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16.sizeH)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16.sizeW)
            make.size.equalTo(40)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(40.sizeH)
            make.centerX.equalToSuperview()
            make.size.equalTo(160)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(8.sizeH)
            make.centerX.equalToSuperview()
        }
        
        topDividingLineView.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(12.sizeH)
            make.height.equalTo(1)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16.sizeW)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16.sizeW)
        }
        
        informationTableView.snp.makeConstraints { make in
            make.top.equalTo(topDividingLineView.snp.bottom)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(16.sizeW)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16.sizeW)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

//MARK: Helpers
extension UserView {
    private func handleUI(model: UserInformationModel?) {
        guard let model = model else {
            return
        }
        setImageAvatarFromApi(url: model.avatarURL ?? "")
        loginLabel.text = model.login
    }
    
    func setImageSize(type: ImageType) {
        avatarImageView.snp.updateConstraints { make in
            make.size.equalTo(type.size)
        }
    }
}

//MARK: API
extension UserView {
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

enum ImageType {
    case general
    case small
    
    var size: Int {
        switch self {
        case .general:
            return 160
        case .small:
            return 100
        }
    }
}
