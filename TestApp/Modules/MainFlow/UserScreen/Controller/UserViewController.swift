//
//  UserViewController.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit
import Alamofire

class UserViewController: UIViewController {
    private let mainView = UserView()
    
    private var model: UserInformationModel? = nil {
        didSet {
            mainView.model = model
        }
    }
    
    private var userLogin: String
    
    init(login: String){
        self.userLogin = login
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.informationTableView.delegate = self
        mainView.informationTableView.dataSource = self
        mainView.informationTableView.registerReusableCell(СharacteristicTableViewCell.self)
        initViewController()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if size.width > size.height {
            mainView.setImageSize(type: .small)
        } else {
            mainView.setImageSize(type: .general)
        }
        
        coordinator.animate(alongsideTransition: { (context) in
            self.view.frame.size = size
            self.view.invalidateIntrinsicContentSize()
        })
    }
    
    private func initViewController() {
        mainView.closeButton.addTarget(self, action: #selector(didCloseButtonTapped), for: .touchUpInside)
        loadUserInformationFromApiToModel(login: self.userLogin)
    }
    
    @objc private func didCloseButtonTapped() {
        returnPreviousController()
    }
}

//MARK: Navigation
extension UserViewController {
    private func returnPreviousController() {
        let userTransitionDelegate = UserTransitionDelegate()
        transitioningDelegate = userTransitionDelegate
        modalPresentationStyle = .custom
        dismiss(animated: true, completion: nil)
    }
}

//MARK: Table Delegate
extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInformationType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let model = UserInformationType.allCases[row]
        let cell: СharacteristicTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.model = model
        cell.value = getValueByType(type: model)
        return cell
    }

}

//MARK: Api
extension UserViewController {
    private func loadUserInformationFromApiToModel(login: String) {
        Loader.showProgressView()
        UserManager.shared.fetchUserByLogin(login: login, completion: { result in
            switch result {
            case .success(let user):
                self.model = user
                self.mainView.informationTableView.reloadData()
                Loader.hideProgressView()
            case .failure(let error):
                if Connectivity.isConnectedToInternet {
                    ErrorAlert.showErrorAlert(with: error.localizedDescription)
                } else {
                    ErrorAlert.showErrorAlert(with: "error_no_internet_text".localized)
                }
                self.returnPreviousController()
                Loader.hideProgressView()
            }
        })
    }
}

//MARK: Helpers
extension UserViewController {
    private func getValueByType(type: UserInformationType) -> String? {
        guard let model = model else {
            return nil
        }
        switch type {
        case .login:
            return model.login
        case .name:
            return model.name
        case .type:
            return model.type
        case .company:
            return model.company
        case .email:
            return model.email
        case .bio:
            return model.bio
        case .createDate:
            return model.createdAt.shortDate()
        }
    }
}

//MARK: Enum
enum UserInformationType: CaseIterable {
    case login
    case name
    case type
    case company
    case email
    case bio
    case createDate
    
    var title: String {
        switch self {
        case .login:
            return "user_login_title".localized
        case .name:
            return "user_name_title".localized
        case .type:
            return "user_type_title".localized
        case .company:
            return "user_company_title".localized
        case .email:
            return "user_email_title".localized
        case .bio:
            return "user_bio_title".localized
        case .createDate:
            return "user_create_date_title".localized
        }
    }
}
