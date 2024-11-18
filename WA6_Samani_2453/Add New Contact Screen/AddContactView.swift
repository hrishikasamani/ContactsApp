//
//  AddContactView.swift
//  WA6_Samani_2453
//
//  Created by Hrishika Samani on 10/21/24.
//

import UIKit

class AddContactView: UIView {
    
    var contactWrapper: UIScrollView!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var phoneTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        setupContactWrapper()
        setupNameTextField()
        setupEmailTextField()
        setupPhoneTextField()
        initConstraints()
    }
    
    func setupContactWrapper() {
        contactWrapper = UIScrollView()
        contactWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contactWrapper)
    }
    
    func setupNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameTextField)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailTextField)
    }
    
    func setupPhoneTextField() {
        phoneTextField = UITextField()
        phoneTextField.placeholder = "Phone number"
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.keyboardType = .phonePad
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneTextField)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            contactWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contactWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contactWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            contactWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: contactWrapper.topAnchor, constant: 64),
            nameTextField.centerXAnchor.constraint(equalTo: contactWrapper.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: contactWrapper.leadingAnchor, constant: 60),
            nameTextField.trailingAnchor.constraint(equalTo: contactWrapper.trailingAnchor, constant: -60),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            emailTextField.centerXAnchor.constraint(equalTo: contactWrapper.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: contactWrapper.leadingAnchor, constant: 60),
            emailTextField.trailingAnchor.constraint(equalTo: contactWrapper.trailingAnchor, constant: -60),
            
            phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            phoneTextField.centerXAnchor.constraint(equalTo: contactWrapper.centerXAnchor),
            phoneTextField.leadingAnchor.constraint(equalTo: contactWrapper.leadingAnchor, constant: 60),
            phoneTextField.trailingAnchor.constraint(equalTo: contactWrapper.trailingAnchor, constant: -60),
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
