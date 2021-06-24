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
    
    let contactInfo = [
        ContactInfo(label: "All contacts", icon: #imageLiteral(resourceName: "group"), countMethod: ContactManager.allContacts),
        ContactInfo(label: "Dublicate names", icon: #imageLiteral(resourceName: "people"), countMethod: ContactManager.filterDublicateName),
        ContactInfo(label: "Dublicate numbers", icon: #imageLiteral(resourceName: "call"), countMethod: ContactManager.filterDublicateNumber),
        ContactInfo(label: "No names", icon: #imageLiteral(resourceName: "delete-friend"), countMethod: ContactManager.filterNoName),
        ContactInfo(label: "No numbers", icon: #imageLiteral(resourceName: "missed-call"), countMethod: ContactManager.filterNoNumber),
        ContactInfo(label: "No emails", icon: #imageLiteral(resourceName: "email"), countMethod: ContactManager.filterNoEmail)
    ]
    
    var contacts = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getContacts()
    }
    
    private func getContacts() {
        switch ContactManager.getContacts() {
        case .success(let contacts):
            self.contacts = contacts
            tableView.reloadData()
        case .failure(let error):
            settingsAlert(message: error.localizedDescription)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.icon.image = contactInfo[indexPath.row].icon
        cell.descriptionLabel.text = contactInfo[indexPath.row].label
        cell.countLabel.text = String(contactInfo[indexPath.row].countMethod(contacts))
        return cell
    }
}
