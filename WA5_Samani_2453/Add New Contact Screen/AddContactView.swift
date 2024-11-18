//
//  AddContactView.swift
//  WA5_Samani_2453
//
//  Created by Hrishika Samani on 10/10/24.
//

import UIKit
import PhotosUI

class AddContactView: UIView {

    var nameTextField: UITextField!
    var imageLabel: UILabel!
    var emailTextField: UITextField!
    var phoneTextField: UITextField!
    var phoneTypeButton: UIButton!
    var buttonTakePhoto: UIButton!
    var imageView: UIImageView!
    var addressTextField: UITextField!
    var cityStateTextField: UITextField!
    var zipCodeTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
      //setupLabelAppName()
        setupNameTextField()
        setupImageLabel()
        setupEmailTextField()
        setupPhoneTextField()
        setupPhoneTypeButton()
        setupbuttonTakePhoto()
        setupAddressTextField()
        setupCityStateTextField()
        setupZipCodeTextField()
        initConstraints()
    }
    func setupImageLabel() {
        imageLabel = UILabel()
        imageLabel.text = "Photo"
        imageLabel.textColor = .gray
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageLabel)
    }
    func setupNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameTextField)
    }

    func setupbuttonTakePhoto(){
        
        buttonTakePhoto = UIButton(type: .system)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular, scale: .large)
        let largeImage = UIImage(systemName: "person.fill", withConfiguration: largeConfig)
        buttonTakePhoto.setImage(largeImage, for: .normal)
        buttonTakePhoto.tintColor = .black
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.imageView? .contentMode = .scaleAspectFit
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
    }

    func setupPhoneTypeButton(){
        phoneTypeButton = UIButton(type: .system)
        phoneTypeButton.setTitle("Home", for: .normal)
        phoneTypeButton.showsMenuAsPrimaryAction = true
        phoneTypeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneTypeButton)
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
    
    func setupAddressTextField() {
        addressTextField = UITextField()
        addressTextField.placeholder = "Address"
        addressTextField.borderStyle = .roundedRect
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addressTextField)
    }
    
    func setupCityStateTextField() {
        cityStateTextField = UITextField()
        cityStateTextField.placeholder = "City, State"
        cityStateTextField.borderStyle = .roundedRect
        cityStateTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cityStateTextField)
    }
    
    func setupZipCodeTextField() {
        zipCodeTextField = UITextField()
        zipCodeTextField.placeholder = "Enter zip code"
        zipCodeTextField.borderStyle = .roundedRect
        zipCodeTextField.keyboardType = .numberPad
        zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(zipCodeTextField)
    }
    
    func configureTitleAppearance(navigationController: UINavigationController?) {
                navigationController?.navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)
                ]
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            
            nameTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            nameTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            buttonTakePhoto.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 32),
            buttonTakePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            //buttonTakePhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 80),
            
            imageLabel.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 6),
            imageLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 32),
            emailTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            phoneTextField.centerYAnchor.constraint(equalTo: phoneTypeButton.centerYAnchor),
            phoneTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor.constraint(equalTo: self.phoneTypeButton.leadingAnchor, constant: -20),
            phoneTextField.widthAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.widthAnchor),
            
            phoneTypeButton.topAnchor.constraint(equalTo: phoneTextField.topAnchor),
            phoneTypeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            phoneTypeButton.heightAnchor.constraint(equalTo: phoneTextField.heightAnchor),
            
            addressTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 16),
            addressTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addressTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addressTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            cityStateTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 16),
            cityStateTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            cityStateTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            cityStateTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            zipCodeTextField.topAnchor.constraint(equalTo: cityStateTextField.bottomAnchor, constant: 16),
            zipCodeTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            zipCodeTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            zipCodeTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
