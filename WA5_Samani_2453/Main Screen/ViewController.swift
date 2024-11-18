//
//  ViewController.swift
//  WA5_Samani_2453
//
//  Created by Hrishika Samani on 10/10/24.
//

import UIKit

class ViewController: UIViewController {

    
    let mainScreen = MainScreenView()
    var contacts = [Contact]()
    var editIndex = 0
    
    override func loadView() {
        view = mainScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Contacts"
    
        mainScreen.tableViewContact.delegate = self
        mainScreen.tableViewContact.dataSource = self
        mainScreen.tableViewContact.separatorStyle = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
                    barButtonSystemItem: .add, target: self,
                    action: #selector(onAddBarButtonTapped)
        )
//        contacts.append(Contact(name: "Hrishika", email: "hrii@gmail.com", phone: "8573985277", phoneType: "Cell", address: "45b smith", cityState: "Boston,MA", zip: "02120"))
//        contacts.append(Contact(name: "Dharmil", email: "karia@neu.cs", phone: "8573848427", phoneType: "Work", address: "123 Washington", cityState: "Boston,MA", zip: "02122"))
    }
    
    func delegateOnAddContact(contact: Contact){
        contacts.append(contact)
        mainScreen.tableViewContact.reloadData()
    }
    func delegateOnEditDetails(contact: Contact){
        contacts[editIndex] = contact
        mainScreen.tableViewContact.reloadData()
    }
    @objc func onAddBarButtonTapped(){
        let addContactController = AddContactViewController()
        addContactController.delegate = self
        navigationController?.pushViewController(addContactController, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath) as! TableViewContactCell
        cell.labelName.text = contacts[indexPath.row].name
        if let uwEmail = contacts[indexPath.row].email{
            cell.labelEmail.text = "\(uwEmail)"
        }
        if let uwPhone = contacts[indexPath.row].phone, let uwPhoneType = contacts[indexPath.row].phoneType
        {
            cell.labelPhone.text = "\(uwPhone) (\(uwPhoneType))"
        }
        if let uwImage = contacts[indexPath.row].image{
            cell.imageReceipt.image = uwImage
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editIndex = indexPath.row
        let detailsViewController = DetailsViewController()
        detailsViewController.delegate = self
        detailsViewController.receiveDetails = contacts[indexPath.row]
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
