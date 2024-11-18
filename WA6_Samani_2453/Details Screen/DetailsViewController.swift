//
//  DetailsViewController.swift
//  WA6_Samani_2453
//
//  Created by Hrishika Samani on 10/21/24.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {
    
    let displayDetailsView = DetailsView()
    var receiveDetails: Contact!
    var contactIndex: Int = 0
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = displayDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayDetailsView.buttonEdit.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        displayDetailsView.buttonDelete.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        if let unwrappedName = receiveDetails?.name, !unwrappedName.isEmpty {
            displayDetailsView.labelName.text = unwrappedName
        }
        
        if let unwrappedEmail = receiveDetails?.email, !unwrappedEmail.isEmpty {
            displayDetailsView.labelEmail.text = "Email: \(unwrappedEmail)"
        }
        
        if let unwrappedPhone = receiveDetails?.phone, !unwrappedPhone.isEmpty {
            displayDetailsView.labelPhone.text = "Phone: \(unwrappedPhone)"
        }
        notificationCenter.addObserver(
            self,
            selector: #selector(handleContactEdited(_:)),
            name: Notification.Name("contactEdited"),
            object: nil)
    }
    
    @objc func handleContactEdited(_ notification: Notification) {
        if let newContact = notification.object as? Contact {
            displayDetailsView.labelName.text = newContact.name
            displayDetailsView.labelEmail.text = "Email: \(newContact.email)"
            displayDetailsView.labelPhone.text = "Phone: \(newContact.phone)"
        }
    }
    
    @objc func editButtonTapped() {
        let editDetailsVC = EditDetailsViewController()
        editDetailsVC.contact = receiveDetails
        navigationController?.pushViewController(editDetailsVC, animated: true)
    }
    
    @objc func deleteButtonTapped() {
        let alertController = UIAlertController(
            title: "Delete Contact",
            message: "Are you sure you want to delete this contact?",
            preferredStyle: .alert
        )
        
        //Add the "Delete" action
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            if let url = URL(string: APIConfigs.baseURL + "delete") {
                AF.request(url, method: .get, parameters:
                            [
                                "name": self.receiveDetails?.name ?? "",
                                "email": self.receiveDetails.email,
                                "phone": self.receiveDetails.phone
                            ])
                .response(completionHandler: {response in
                    let status = response.response?.statusCode
                    
                    switch response.result {
                    case .success(_):
                        
                        if let uwStatusCode = status{
                            switch uwStatusCode {
                            case 200...299:
                                let userInfo: [String: Any] = [
                                    "contact": self.receiveDetails as Any,
                                    "index": self.contactIndex
                                ]
                                NotificationCenter.default.post(name: Notification.Name("contactDeleted"), object: nil, userInfo: userInfo)
                                self.navigationController?.popViewController(animated: true)
                                break
                                
                            case 400...499:
                                self.showAlert(message: "Error deleting contact")
                                break
                                
                            default:
                                self.showAlert(message: "Error deleting contact")
                                break
                            }
                        }
                        break
                    case.failure(_):
                        self.showAlert(message: "Error deleting contact")
                        break
                    }
                })
            }
        }

        // Add the "Cancel" action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Add actions to the alert controller
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

