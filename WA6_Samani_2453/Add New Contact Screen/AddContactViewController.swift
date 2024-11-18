//
//  AddContactViewController.swift
//  WA6_Samani_2453
//
//  Created by Hrishika Samani on 10/21/24.
//

import UIKit
import Alamofire

class AddContactViewController: UIViewController {

    let addContactScreen = AddContactView()
    var mainScreenViewController: ViewController?
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = addContactScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add a New Contact"
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self,
            action: #selector(onSaveButtonTapped)
        )
    }
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    func validateInputFields() -> Bool{
        if addContactScreen.nameTextField.text?.isEmpty == true{
            showAlert(message: "Please enter a name")
            return false
        }
        if let email = addContactScreen.emailTextField.text, !isValidEmail(email) {
            showAlert(message: "Please enter a valid email")
            return false
        }
        if let phone = addContactScreen.phoneTextField.text, !isValidPhone(phone) {
            showAlert(message: "Please enter a valid phone number")
            return false
        }
        return true
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func isValidPhone(_ phone: String) -> Bool {
        return phone.count == 10 && phone.allSatisfy { $0.isNumber }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func onSaveButtonTapped(){
        if !validateInputFields() {
            return
        }
        
        if let name = addContactScreen.nameTextField.text,
           let email = addContactScreen.emailTextField.text,
           let phone = addContactScreen.phoneTextField.text{
            
            if !phone.isEmpty && phone.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
                let contact = Contact(name: name, email: email, phone: phone)
                
                addNewContact(contact: contact)
            }else{
                showAlert(message: "Error adding new contact")
            }
        }
        else{
            showAlert(message: "Error adding new contact")
        }
    }
    
    //MARK: add a new contact call: add endpoint...
    func addNewContact(contact: Contact){
        if let url = URL(string: APIConfigs.baseURL+"add"){
            print("Making a request to: \(url)")
            print("Parameters: name = \(contact.name), email = \(contact.email), phone = \(contact.phone)")
                    
            AF.request(url, method:.post, parameters:
                        [
                            "name": contact.name,
                            "email": contact.email,
                            "phone": contact.phone
                        ])
                .responseString(completionHandler: { response in
                    let status = response.response?.statusCode
                    
                    switch response.result{
                    case .success(let data):
                        
                        if let uwStatusCode = status{
                            switch uwStatusCode{
                                
                                case 200...299:
                                self.clearAddViewFields()
                                print("Contact added successfully.")
                                NotificationCenter.default.post(name: Notification.Name("contactAdded"), object: contact)
                                self.navigationController?.popViewController(animated: true)
                                break
                        
                                case 400...499:
                                self.showAlert(message: "Error adding new contact")
                                break
                        
                                default:
                                self.showAlert(message: "Error adding new contact")
                                break
                            }
                        }
                        else {
                            self.showAlert(message: "Error adding new contact")
                        }
                        break
                        
                    case .failure(let error):
                        self.showAlert(message: "Network issue!")
                        break
                    }
                })
        }else{
            showAlert(message: "Invalid URL")
        }
    }
    
    func clearAddViewFields(){
        addContactScreen.nameTextField.text = ""
        addContactScreen.emailTextField.text = ""
        addContactScreen.phoneTextField.text = ""
    }

}

