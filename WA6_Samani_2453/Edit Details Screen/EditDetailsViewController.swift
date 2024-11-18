//
//  EditDetailsViewController.swift
//  WA6_Samani_2453
//
//  Created by Hrishika Samani on 10/21/24.
//

import UIKit
import Alamofire

class EditDetailsViewController: UIViewController {
    
    var editDetailsScreen = AddContactView()
    let notificationCenter = NotificationCenter.default
    var contact: Contact!
    var contactIndex: Int = 0
    
    override func loadView() {
        
        // Set the view to be AddContactView
        editDetailsScreen = AddContactView(frame: .zero)
        view = editDetailsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Details"
        view.backgroundColor = .white
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        // Populate the fields with the current contact's data
        populateFields()
        
        // Setup save button
        setupSaveButton()
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    private func populateFields() {
        // Populate AddContactView's text fields with current contact data
        editDetailsScreen.nameTextField.text = contact.name
        editDetailsScreen.emailTextField.text = contact.email
        editDetailsScreen.phoneTextField.text = contact.phone
    }
    
    func validateInputFields() -> Bool{
        if editDetailsScreen.nameTextField.text?.isEmpty == true{
            showAlert(message: "Please enter a name")
            return false
        }
        if let email = editDetailsScreen.emailTextField.text, !isValidEmail(email) {
            showAlert(message: "Please enter a valid email")
            return false
        }
        if let phone = editDetailsScreen.phoneTextField.text, !isValidPhone(phone) {
            showAlert(message: "Please enter a valid phone number")
            return false
        }
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailFormat).evaluate(with: email)
    }
    
    func isValidPhone(_ phone: String) -> Bool {
        return phone.count == 10 && phone.allSatisfy { $0.isNumber }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupSaveButton() {
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    @objc func saveButtonTapped(){
        
        //Validate fields before allowing save
        if !validateInputFields() {
            return
        }
        
        if let name = editDetailsScreen.nameTextField.text,
           let email = editDetailsScreen.emailTextField.text,
           let phone = editDetailsScreen.phoneTextField.text{
            if !phone.isEmpty && phone.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
                let updatedContact = Contact(name: name, email: email, phone: phone)
                
                //Delete the older version of the contact
                deleteOldContact(updatedContact: updatedContact)
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func deleteOldContact(updatedContact: Contact){
        if let url = URL(string: APIConfigs.baseURL + "delete") {
            AF.request(url, method: .get, parameters:
                        [
                            "name": self.contact.name,
                            "email": self.contact.email,
                            "phone": self.contact.phone
                        ])
            .response(completionHandler: {response in
                let status = response.response?.statusCode
                
                switch response.result {
                case .success(_):
                    
                    if let uwStatusCode = status{
                        switch uwStatusCode {
                            case 200...299:
                                self.addNewContact(contact: updatedContact)
                                break
                            
                            case 400...499:
                                self.showAlert(message: "Error editing contact")
                            break
                            
                            default:
                                self.showAlert(message: "Error editing contact")
                                break
                        }
                    }
                    break
                    
                case.failure(_):
                    self.showAlert(message: "Error. Try again!")
                    break
                }
                      })
        } else {
            self.showAlert(message: "Error. Try again!")
        }
    }
        
    //MARK: add a new contact call: add endpoint...
    func addNewContact(contact: Contact){
        if let url = URL(string: APIConfigs.baseURL+"add"){
            AF.request(url, method:.post, parameters:
                        [
                            "name": contact.name,
                            "email": contact.email,
                            "phone": contact.phone
                        ])
                .responseString(completionHandler: { response in
                    let status = response.response?.statusCode
                    
                    switch response.result{
                    case .success(_):

                        if let uwStatusCode = status{
                            switch uwStatusCode{
                                case 200...299:
                                    NotificationCenter.default.post(name: Notification.Name("contactEdited"), object: contact)
                                    self.clearAddViewFields()
                                    break
                        
                                case 400...499:
                                    self.showAlert(message: "Error editing contact")
                                    break
                        
                                default:
                                    self.showAlert(message: "Error editing contact")
                                    break
                        
                            }
                        }
                        break
                        
                    case .failure(let error):
                        self.showAlert(message: "Error editing contact")
                        break
                    }
                })
        }else{
            self.showAlert(message: "Error. Try again!")
        }
    }
    
    func clearAddViewFields(){
        editDetailsScreen.nameTextField.text = ""
        editDetailsScreen.emailTextField.text = ""
        editDetailsScreen.phoneTextField.text = ""
    }
        
}
