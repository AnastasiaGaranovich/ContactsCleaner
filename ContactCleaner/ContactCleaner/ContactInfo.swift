//
//  ContactInfo.swift
//  ContactCleaner
//
//  Created by Анастасия Гаранович on 23.06.2021.
//

import UIKit
import ContactsUI

class ContactInfo {
    
    typealias CountMethod = ([CNContact]) -> (Int)
    
    var label: String
    var icon: UIImage
    var countMethod: CountMethod
    
    init(label: String, icon: UIImage, countMethod: @escaping CountMethod) {
        self.label = label
        self.icon = icon
        self.countMethod = countMethod
    }
}
