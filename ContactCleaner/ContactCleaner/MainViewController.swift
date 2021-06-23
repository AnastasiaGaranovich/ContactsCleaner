//
//  ViewController.swift
//  ContactCleaner
//
//  Created by Анастасия Гаранович on 23.06.2021.
//

import UIKit
import ContactsUI

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let cellLabels = ["All contacts", "Dublicate names", "Dublicate numbers", "No names", "No numbers", "No emails"]
    let cellIcons = [#imageLiteral(resourceName: "group"), #imageLiteral(resourceName: "people"), #imageLiteral(resourceName: "call"), #imageLiteral(resourceName: "delete-friend"), #imageLiteral(resourceName: "missed-call"), #imageLiteral(resourceName: "email")]
    
    let contacts = ContactManager.getContacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        for contact in contacts {
            print(contact.givenName)
            print(contact.phoneNumbers)
            print(contact.emailAddresses)
        }
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.icon.image = cellIcons[indexPath.row]
        cell.descriptionLabel.text = cellLabels[indexPath.row]
        cell.countLabel.text = String(0)
        return cell
    }
    
}
