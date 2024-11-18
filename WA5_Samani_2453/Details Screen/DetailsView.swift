//
//  DetailsView.swift
//  WA5_Samani_2453
//
//  Created by Hrishika Samani on 10/10/24.
//

import UIKit

class DetailsView: UIView {
    
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPhone: UILabel!
    var labelAdd: UILabel!
    var labelAddressLine: UILabel!
    var labelCityState: UILabel!
    var labelZip: UILabel!
    var ImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setting the background color...
        self.backgroundColor = .white
        
        setupLabels()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabels() {
        ImageView = UIImageView()
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.tintColor = .black
        self.addSubview(ImageView)
        
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 23)
        labelName.textAlignment = .center
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
        
        labelEmail = UILabel()
        labelEmail.textAlignment = .center
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
        
        labelPhone = UILabel()
        labelPhone.textAlignment = .center
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPhone)
        
        labelAdd = UILabel()
        labelAdd.font = UIFont.boldSystemFont(ofSize: 18)
        labelAdd.textAlignment = .center
        labelAdd.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAdd)
        
        labelAddressLine = UILabel()
        labelAddressLine.textAlignment = .center
        labelAddressLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddressLine)
        
        labelCityState = UILabel()
        labelCityState.textAlignment = .center
        labelCityState.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCityState)
        
        labelZip = UILabel()
        labelZip.textAlignment = .center
        labelZip.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelZip)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            ImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            ImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            ImageView.widthAnchor.constraint(equalToConstant: 80),
            ImageView.heightAnchor.constraint(equalToConstant: 80),
            
            labelName.topAnchor.constraint(equalTo: ImageView.bottomAnchor, constant: 20),
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 32),
            labelEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelPhone.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 16),
            labelPhone.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelAdd.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 32),
            labelAdd.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelAddressLine.topAnchor.constraint(equalTo: labelAdd.bottomAnchor, constant: 16),
            labelAddressLine.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelCityState.topAnchor.constraint(equalTo: labelAddressLine.bottomAnchor, constant: 8),
            labelCityState.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelZip.topAnchor.constraint(equalTo: labelCityState.bottomAnchor, constant: 8),
            labelZip.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            ])
    }

}
