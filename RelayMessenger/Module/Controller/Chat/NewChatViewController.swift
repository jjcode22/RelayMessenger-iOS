//
//  NewChatViewController.swift
//  RelayMessenger
//
//  Created by JJ on 21/03/24.
//

import UIKit


class NewChatViewController: UIViewController{
    //MARK: - properties
    private let tableView = UITableView()
    private let reuseIdentifier = "UserCell"
    
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    //MARK: - helpers
    private func configureUI(){
        view.backgroundColor = .white
        title = "Search"
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 15,paddingRight: 15 )
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 64
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        
    }
}

//MARK: - Table View

extension NewChatViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        return cell
    }
    
    
}
