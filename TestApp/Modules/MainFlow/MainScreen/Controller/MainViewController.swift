//
//  MainViewController.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    private let mainView = MainView()
    var refreshControl = UIRefreshControl()
    private var models: [UserModel] = []
    
    var hasMoreData = true
        
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        initTableView()
        firstloadUsersFromApiToModels()
    }
    
    private func initTableView() {
        mainView.usersTableView.delegate = self
        mainView.usersTableView.dataSource = self
        mainView.usersTableView.registerReusableCell(UsersTableViewCell.self)
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        mainView.usersTableView.refreshControl = refreshControl
    }
}

//MARK: Navigation
extension MainViewController {
    private func openUserViewController(userLogin: String, tableViewCellFrame: CGRect) {
        let userTransitionDelegate = UserTransitionDelegate(sourceFrame: tableViewCellFrame)
        let userViewController = UserViewController(login: userLogin)
        userViewController.transitioningDelegate = userTransitionDelegate
        userViewController.modalPresentationStyle = .custom
        present(userViewController, animated: true, completion: nil)
    }
}

//MARK: Table View
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let model = models[row]
        let cell: UsersTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let model = models[row]
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? UsersTableViewCell else {
            return
        }
        let cellFrameInScreen = selectedCell.convert(selectedCell.bounds, to: nil)
        openUserViewController(userLogin: model.login, tableViewCellFrame: cellFrameInScreen)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if section ==  lastSectionIndex && row == lastRowIndex {
            loadMoreUsersFromApiToModels(lastUserId: indexPath.row )
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    private func handleTableView() {
        let newIndexPathes = getNewIndexPathes()
        mainView.usersTableView.beginUpdates()
        mainView.usersTableView.insertRows(at: newIndexPathes, with: .fade)
        mainView.usersTableView.endUpdates()
    }
}

//MARK: Bottom spinner for loading data to table view
extension MainViewController {
    private func showBottomSpinner() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: mainView.usersTableView.bounds.width, height: CGFloat(44))

        self.mainView.usersTableView.tableFooterView = spinner
    }
    
    private func hideBottomSpinner() {
        self.mainView.usersTableView.tableFooterView?.isHidden = false
    }
}

//MARK: Helpers
extension MainViewController {
    @objc func refreshTableView() {
        firstloadUsersFromApiToModels(withLoader: false)
        refreshControl.endRefreshing()
    }
    
    private func reloadTableView() {
        mainView.usersTableView.reloadData()
    }
    
    private func getNewIndexPathes() -> [IndexPath]{
        var newIndexPaths: [IndexPath] = []
        let countModels = models.count
        for i in countModels - APIConstants.countOfElementsForOneLoad..<countModels {
            newIndexPaths.append(IndexPath(row: i, section: 0))
        }
        return newIndexPaths
    }
}

//MARK: Api
extension MainViewController {
    private func firstloadUsersFromApiToModels(withLoader: Bool = true) {
        if withLoader {
            Loader.showProgressView()
        }
        UserManager.shared.fetchUsers(lastUserId: 0) { result in
            switch result {
            case .success(let users):
                Loader.hideProgressView()
                self.models = users
                self.reloadTableView()
            case .failure(let error):
                Loader.hideProgressView()
                if Connectivity.isConnectedToInternet {
                    ErrorAlert.showErrorAlert(with: error.localizedDescription)
                } else {
                    ErrorAlert.showErrorAlert(with: "error_no_internet_text".localized)
                }
            }
        }
    }
    
    private func loadMoreUsersFromApiToModels(lastUserId: Int) {
        showBottomSpinner()
        UserManager.shared.fetchUsers(lastUserId: lastUserId) { result in
            switch result {
            case .success(let users):
                self.hideBottomSpinner()
                self.models.append(contentsOf: users)
                self.handleTableView()
            case .failure(let error):
                self.hideBottomSpinner()
                if Connectivity.isConnectedToInternet {
                    ErrorAlert.showErrorAlert(with: error.localizedDescription)
                } else {
                    ErrorAlert.showErrorAlert(with: "error_no_internet_text".localized)
                }
            }
        }
    }
}

