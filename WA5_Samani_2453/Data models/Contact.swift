//
//  Contact.swift
//  WA5_Samani_2453
//
//  Created by Hrishika Samani on 10/10/24.
//

import Foundation
import UIKit

struct Contact{
    var name: String?
    var email: String?
    var phone: String?
    var phoneType: String?
    var address: String?
    var cityState: String?
    var zip: String?
    var image: UIImage?
    
    init(name: String? = nil, email: String? = nil, phone: String? = nil, phoneType: String? = nil, address: String? = nil, cityState: String? = nil, zip: String? = nil, image: UIImage? = nil) {
        self.name = name
        self.email = email
        self.phone = phone
        self.phoneType = phoneType
        self.address = address
        self.cityState = cityState
        self.zip = zip
        self.image = image
    }
    
}
