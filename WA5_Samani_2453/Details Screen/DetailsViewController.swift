//
//  DetailsViewController.swift
//  WA5_Samani_2453
//
//  Created by Hrishika Samani on 10/10/24.
//

import UIKit


class DetailsViewController: UIViewController {
    var delegate: ViewController!
    
    let displayDetailsView = DetailsView()
    var receiveDetails: Contact = Contact()
    
    override func loadView() {
        view = displayDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit, target: self,
            action: #selector(editButtonTapped)
        )
        
        if let contactImage = receiveDetails.image {
            displayDetailsView.ImageView.image = contactImage // Set the image
        } else {
            displayDetailsView.ImageView.image = UIImage(systemName: "person.fill")
        }
        
        if let unwrappedName = receiveDetails.name {
            if !unwrappedName.isEmpty{
                displayDetailsView.labelName.text = "\(unwrappedName)"
            }
        }
        
        if let unwrappedEmail = receiveDetails.email {
            if !unwrappedEmail.isEmpty{
                displayDetailsView.labelEmail.text = "Email: \(unwrappedEmail)"
            }
        }
        
        if let unwrappedPhone = receiveDetails.phone, let unwrappedType = receiveDetails.phoneType  {
            if !unwrappedPhone.isEmpty{
                displayDetailsView.labelPhone.text = "Phone: \(unwrappedPhone)(\(unwrappedType))"
            }
        }
        displayDetailsView.labelAdd.text = "Address:"
        
        if let unwrappedAddress = receiveDetails.address {
            if !unwrappedAddress.isEmpty{
                displayDetailsView.labelAddressLine.text = "\(unwrappedAddress)"
            }
        }
        
        if let unwrappedCityState = receiveDetails.cityState {
            if !unwrappedCityState.isEmpty{
                displayDetailsView.labelCityState.text = "\(unwrappedCityState)"
            }
        }
        
        if let unwrappedZip = receiveDetails.zip {
            if !unwrappedZip.isEmpty{
                displayDetailsView.labelZip.text = "\(unwrappedZip)"
            }
        }
    }
    
    @objc func editButtonTapped() {
        let editDetailsVC = EditDetailsViewController()
        editDetailsVC.contact = receiveDetails
        editDetailsVC.delegate = delegate
        editDetailsVC.DetailsDelegate = self
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(editDetailsVC, animated: true)
    }
}
