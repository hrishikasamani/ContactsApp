//
//  ViewController.swift
//  WA6_Samani_2453
//
//  Created by Hrishika Samani on 10/21/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    let mainScreen = MainScreenView()
    let notificationCenter = NotificationCenter.default
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
        //contacts.append(Contact(name: "Hrishika", email: "hrii@gmail.com", phone: "8573985277"))
        //contacts.append(Contact(name: "Dharmil", email: "karia@neu.cs", phone: "8573848427"))
        
        getAllContacts()
        
        // Observing notifications for adding and editing contacts
        notificationCenter.addObserver(
            self,
            selector: #selector(handleContactAdded(notification:)),
            name: Notification.Name("contactAdded"),
            object: nil)
        notificationCenter.addObserver(
            self,
            selector: #selector(handleContactEdited(_:)),
            name: Notification.Name("contactEdited"),
            object: nil)
        notificationCenter.addObserver(
            self,
            selector: #selector(handleContactDeleted(_:)),
            name: Notification.Name("contactDeleted"),
            object: nil)
    }
    
    //MARK: get all contacts...
    func getAllContacts(){
        
        if let url = URL(string: APIConfigs.baseURL + "getall"){
            
            AF.request(url, method: .get).responseString(completionHandler: { response in
                //MARK: retrieving the status code...
                let status = response.response?.statusCode
                switch response.result{
                case .success(let data):
                    
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            
                            case 200...299:
                            
                            // Clear the existing array before adding new contacts
                            self.contacts.removeAll()
                            
                            // Split the response data by newline to get individual contact entries
                            let contactLines = data.components(separatedBy: "\n")
                            
                            for line in contactLines where !line.isEmpty {
                                let contactDetails = line.components(separatedBy: ",")
                                for c in contactDetails{
                                    if let url = URL(string: APIConfigs.baseURL+"details"){
                                        AF.request(url, method:.get,
                                                   parameters: ["name":c],
                                                   encoding: URLEncoding.queryString)
                                            .responseString(completionHandler: { response in
                                            let status = response.response?.statusCode
                                            switch response.result{
                                            case .success(let data):
                                                
                                                if let uwStatusCode = status{
                                                    //print(data)
                                                    let data_separated = data.components(separatedBy: ",")
                                                    print(data_separated)
                                                    
                                                    switch uwStatusCode{
                                                    case 200...299:
                                                            let contact = Contact(
                                                                name: data_separated[0].trimmingCharacters(in: .whitespacesAndNewlines),
                                                                email: data_separated[1].trimmingCharacters(in: .whitespacesAndNewlines),
                                                                phone: data_separated[2].trimmingCharacters(in: .whitespacesAndNewlines)
                                                            )
                                                            
                                                            // Add the contact to the contacts array (data source)
                                                            self.contacts.append(contact)
                                                            self.mainScreen.tableViewContact.reloadData()
                                                            
                                                        case 400...499:
                                                            self.showAlert(message: "Error. Try again!")
                                                            break
                                                        
                                                        default:
                                                            self.showAlert(message: "Error. Try again!")
                                                            break
                                                        }
                                                } else {
                                                    self.showAlert(message: "Error. Try again!")
                                                }
                                                break
                                                
                                            case .failure(let error):
                                                self.showAlert(message: "Network issue")
                                                break
                                            }
                                        })
                                    }
                                }
                            }
                   
                            case 400...499:
                                self.showAlert(message: "Error. Try again!")
                                break
                    
                            default:
                                self.showAlert(message: "Error. Try again!")
                                break
                        }
                    }
                    break
                    
                case .failure(let error):
                    self.showAlert(message: "Error. Try again!")
                    break
                }
            })
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handleContactAdded(notification: Notification) {
            getAllContacts()
    }
    
    @objc func handleContactEdited(_ notification: Notification) {
        getAllContacts()
    }

    
    @objc func handleContactDeleted(_ notification: Notification){
            getAllContacts()
    }
    
    @objc func onAddBarButtonTapped(){
        let addContactController = AddContactViewController()
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
        cell.labelEmail.text = contacts[indexPath.row].email
        cell.labelPhone.text = "\(contacts[indexPath.row].phone)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = contacts[indexPath.row]
                getContactDetails(name: selectedContact.name, index: indexPath.row)
    }
    
    func getContactDetails(name: String, index: Int){
        let parameters = ["name":name]
        if let url = URL(string: APIConfigs.baseURL+"details"){
            AF.request(url, method:.get,
                       parameters: ["name":name],
                       encoding: URLEncoding.queryString)
            .responseString(completionHandler: { response in
                
                //MARK: retrieving the status code...
                let status = response.response?.statusCode
                switch response.result{
                case .success(let data):
                    //MARK: there was no network error...
                    
                    //MARK: status code is Optional, so unwrapping it...
                    if let uwStatusCode = status{
                        
                        let data_separated = data.components(separatedBy: ",")
                        switch uwStatusCode{
                            
                        case 200...299:
                                let contact = Contact(
                                    name: data_separated[0],
                                    email: data_separated[1].trimmingCharacters(in: .whitespacesAndNewlines),
                                    phone: data_separated[2].trimmingCharacters(in: .whitespacesAndNewlines)
                                )
                                let detailsViewController = DetailsViewController()
                                detailsViewController.receiveDetails = contact
                                detailsViewController.contactIndex = index
                                self.navigationController?.pushViewController(detailsViewController, animated: true)
                            
                        case 400...499:
                            self.showAlert(message: "Error. Try again!")
                        default:
                            self.showAlert(message: "Error. Try again!")
                        }
                    }
                case .failure(let error):
                    self.showAlert(message: "Error. Try again!")
                }
            })
        }
    }
}
