//
//  EditDetailsViewController.swift
//  WA5_Samani_2453
//
//  Created by Hrishika Samani on 10/12/24.
//

import UIKit
import PhotosUI

class EditDetailsViewController: UIViewController {
    
    var editDetailsScreen = AddContactView()
    
    var delegate : ViewController!
    var DetailsDelegate: DetailsViewController!
    
    var contact: Contact = Contact()
    
    var pickedImage:UIImage?
    var selectedType = "Home"
    
    override func loadView() {
        // Set the view to be AddContactView
        editDetailsScreen = AddContactView(frame: .zero)
        view = editDetailsScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Details"
        view.backgroundColor = .white
        
        editDetailsScreen.phoneTypeButton.menu = getMenuTypes()
        editDetailsScreen.buttonTakePhoto.menu = getMenuImagePicker()
        //editDetailsScreen.buttonTakePhoto.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
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
    func getMenuTypes() -> UIMenu{
        var menuItems = [UIAction]()
        for type in Utilities.types{
            let menuItem = UIAction(title: type,handler: {(_) in
                self.selectedType = type
                self.editDetailsScreen.phoneTypeButton.setTitle(self.selectedType, for: .normal)
            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select type", children: menuItems)
    }
    
    func getMenuImagePicker() -> UIMenu{
        var menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    
    
    private func populateFields() {
        // Populate AddContactView's text fields with current contact data
        editDetailsScreen.nameTextField.text = contact.name
        if let uwImage = contact.image{
            self.editDetailsScreen.buttonTakePhoto.setImage(
                uwImage.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            pickedImage = uwImage
        }
        editDetailsScreen.emailTextField.text = contact.email
        editDetailsScreen.phoneTextField.text = contact.phone
        editDetailsScreen.addressTextField.text = contact.address
        editDetailsScreen.cityStateTextField.text = contact.cityState
        editDetailsScreen.zipCodeTextField.text = contact.zip
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
        if editDetailsScreen.addressTextField.text?.isEmpty == true{
            showAlert(message: "Please enter an address")
            return false
        }
        
        if let cityState = editDetailsScreen.cityStateTextField.text, !isValidCityState(cityState: cityState){
            showAlert(message: "Please enter a valid City, State.")
            return false
        }
        if let zip = editDetailsScreen.zipCodeTextField.text, !isValidZipCode(zip) == true{
            showAlert(message: "Please enter a valid zip code (5 digits)")
            return false
        }
        return true
    }
    func isValidCityState(cityState: String) -> Bool {
        let components = cityState.split(separator: ",")
        
        if components.count == 2 {
            let city = components[0].trimmingCharacters(in: .whitespaces)
            let state = components[1].trimmingCharacters(in: .whitespaces)
            
            let isCityValid = city.count > 1
            let isStateValid = state.count == 2
            
            return isCityValid && isStateValid
        }
        
        return false
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func isValidZipCode(_ zipCode: String) -> Bool {
        if zipCode.count == 5, let zipNumber = Int(zipCode) {
            return zipNumber >= 1 && zipNumber <= 99950
        }
        return false
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
    
    
    @objc private func saveButtonTapped() {
        
        if validateInputFields() {
            let updatedProfile = Contact(
                name: editDetailsScreen.nameTextField.text,
                email: editDetailsScreen.emailTextField.text,
                phone: editDetailsScreen.phoneTextField.text,
                phoneType: selectedType,
                address: editDetailsScreen.addressTextField.text,
                cityState: editDetailsScreen.cityStateTextField.text,
                zip: editDetailsScreen.zipCodeTextField.text,
                image: pickedImage ?? UIImage(systemName: "person.fill")!)
            
            delegate.delegateOnEditDetails(contact: updatedProfile)
            
            let detailsView = DetailsViewController()
            
            detailsView.receiveDetails = updatedProfile
            
            navigationController?.popViewController(animated: true)
            navigationController?.pushViewController(detailsView, animated: true)
            
        }
        else {
            return
        }
    }
}

extension EditDetailsViewController:PHPickerViewControllerDelegate{
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            dismiss(animated: true)
            
            print(results)
            
            let itemprovider = results.map(\.itemProvider)
            
            for item in itemprovider{
                if item.canLoadObject(ofClass: UIImage.self){
                    item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                        DispatchQueue.main.async{
                            if let uwImage = image as? UIImage{
                                self.editDetailsScreen.buttonTakePhoto.setImage(
                                    uwImage.withRenderingMode(.alwaysOriginal),
                                    for: .normal
                                )
                                self.pickedImage = uwImage
                            }
                        }
                    })
                }
            }
        }
}
        //MARK: adopting required protocols for UIImagePicker...
extension EditDetailsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                picker.dismiss(animated: true)
                
        if let image = info[.editedImage] as? UIImage{
            self.editDetailsScreen.buttonTakePhoto.setImage(
                        image.withRenderingMode(.alwaysOriginal),
                        for: .normal
            )
                self.pickedImage = image
        }else{
            showAlert(message: "Error selecting image. Try again.")
        }
    }
            
}

