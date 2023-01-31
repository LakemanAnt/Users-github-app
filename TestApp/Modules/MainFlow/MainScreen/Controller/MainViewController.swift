//
//  MainViewController.swift
//  TestApp
//
//  Created by Anton on 31.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    private let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        mainView.usersTableView.delegate = self
        mainView.usersTableView.dataSource = self
        mainView.usersTableView.registerReusableCell(UsersTableViewCell.self)
    }
}

//MARK: Table View delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UsersTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        return cell
    }
}
