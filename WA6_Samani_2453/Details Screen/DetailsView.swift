//
//  DetailsView.swift
//  WA6_Samani_2453
//
//  Created by Hrishika Samani on 10/21/24.
//

import UIKit

class DetailsView: UIView {
    
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPhone: UILabel!
    var buttonEdit: UIButton!
    var buttonDelete: UIButton!
    var detailWrapper: UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Setting the background color...
        self.backgroundColor = .white
        setupDetailWrapper()
        setupLabels()
        setupbuttonEdit()
        setupbuttonDelete()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDetailWrapper() {
        detailWrapper = UIScrollView()
        detailWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailWrapper)
    }
    
    func setupLabels() {
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
    }
    
    func setupbuttonEdit() {
        buttonEdit = UIButton()
        buttonEdit.setTitle("Edit", for: .normal)
        buttonEdit.setTitleColor(.white, for: .normal)
        buttonEdit.backgroundColor = .blue
        buttonEdit.layer.cornerRadius = 10
        buttonEdit.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonEdit)
    }
    
    func setupbuttonDelete() {
        buttonDelete = UIButton()
        buttonDelete.setTitle("Delete", for: .normal)
        buttonDelete.setTitleColor(.white, for: .normal)
        buttonDelete.backgroundColor = .red
        buttonDelete.layer.cornerRadius = 10
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonDelete)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            detailWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            detailWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            detailWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            detailWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),

            labelName.topAnchor.constraint(equalTo: detailWrapper.topAnchor, constant: 50),
            labelName.centerXAnchor.constraint(equalTo: detailWrapper.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 16),
            labelEmail.centerXAnchor.constraint(equalTo: detailWrapper.centerXAnchor),
            
            labelPhone.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 16),
            labelPhone.centerXAnchor.constraint(equalTo: detailWrapper.centerXAnchor),
            
            buttonEdit.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 32),
            buttonEdit.centerXAnchor.constraint(equalTo: detailWrapper.centerXAnchor, constant: -75),
            buttonEdit.widthAnchor.constraint(equalToConstant: 100),
            
            buttonDelete.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 32),
            buttonDelete.centerXAnchor.constraint(equalTo: detailWrapper.centerXAnchor, constant: 75),
            buttonDelete.widthAnchor.constraint(equalToConstant: 100),
            ])
    }

}
