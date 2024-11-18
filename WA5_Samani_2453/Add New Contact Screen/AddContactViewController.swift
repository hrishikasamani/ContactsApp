//
//  AddContactViewController.swift
//  WA5_Samani_2453
//
//  Created by Hrishika Samani on 10/10/24.
//

import UIKit
import PhotosUI

class AddContactViewController: UIViewController {
    
    var delegate:ViewController!
    var pickedImage:UIImage?

    let addContactScreen = AddContactView()
    var selectedType = "Home"
    
    override func loadView() {
        view = addContactScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add a New Contact"
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        addContactScreen.buttonTakePhoto.menu = getMenuImagePicker()
        addContactScreen.phoneTypeButton.menu = getMenuTypes()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self,
            action: #selector(onSaveButtonTapped)
        )
    }
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    func getMenuTypes() -> UIMenu{
        var menuItems = [UIAction]()
        for type in Utilities.types{
            let menuItem = UIAction(title: type,handler: {(_) in
                self.selectedType = type
                self.addContactScreen.phoneTypeButton.setTitle(self.selectedType, for: .normal)
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
    
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
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
        if addContactScreen.addressTextField.text?.isEmpty == true{
            showAlert(message: "Please enter an address")
            return false
        }
        
        if let cityState = addContactScreen.cityStateTextField.text, !isValidCityState(cityState: cityState){
            showAlert(message: "Please enter a valid City, State.")
            return false
        }
        if let zip = addContactScreen.zipCodeTextField.text, !isValidZipCode(zip) == true{
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
    
    @objc func onSaveButtonTapped(){
        if !validateInputFields() {
            return
        }
        let contactDetails = Contact(
            name: addContactScreen.nameTextField.text,
            email: addContactScreen.emailTextField.text,
            phone: addContactScreen.phoneTextField.text,
            phoneType: selectedType,
            address: addContactScreen.addressTextField.text,
            cityState: addContactScreen.cityStateTextField.text,
            zip: addContactScreen.zipCodeTextField.text,
            image: pickedImage ?? UIImage(systemName: "person.fill")!
        )
            delegate.delegateOnAddContact(contact: contactDetails)
            navigationController?.popViewController(animated: true)
    }

}

//MARK: adopting required protocols for PHPicker...
extension AddContactViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.addContactScreen.buttonTakePhoto.setImage(
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
extension AddContactViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.addContactScreen.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            showAlert(message: "Error selecting image. Try again.")
        }
    }
}

