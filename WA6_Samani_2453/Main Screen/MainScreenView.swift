//
//  MainScreenView.swift
//  WA6_Samani_2453
//
//  Created by Hrishika Samani on 10/21/24.
//

import UIKit

class MainScreenView: UIView {

    var tableViewContact: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        //MARK: initializing a TableView...
        setupTableViewContact()
        initConstraints()
    }
    
    func setupTableViewContact(){
        tableViewContact = UITableView()
        tableViewContact.register(TableViewContactCell.self, forCellReuseIdentifier: "contacts")
        tableViewContact.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewContact)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewContact.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewContact.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewContact.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewContact.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
