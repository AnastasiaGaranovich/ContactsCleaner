//
//  ContactManager.swift
//  ContactCleaner
//
//  Created by Анастасия Гаранович on 23.06.2021.
//

import Foundation
import ContactsUI

class ContactManager {
    static func getContacts() -> Result<[CNContact], Error> {
        
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey] as [Any]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch (let error) {
            return .failure(error)
        }
        
        var results: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch (let error) {
                return .failure(error)
            }
        }
        return .success(results)
    }
    
    static func allContacts(contacts: [CNContact]) -> Int {
        return contacts.count
    }
    
    static func filterNoName(contacts: [CNContact]) -> Int {
        let noNameContacts = contacts.filter { contact in
            return contact.givenName.isEmpty
        }
        return noNameContacts.count
    }
    
    static func filterNoNumber(contacts: [CNContact]) -> Int {
        let noNumberContacts = contacts.filter { contact in
            return contact.phoneNumbers.isEmpty
        }
        return noNumberContacts.count
    }
    
    static func filterNoEmail(contacts: [CNContact]) -> Int {
        let noEmailContacts = contacts.filter { contact in
            return contact.emailAddresses.isEmpty
        }
        return noEmailContacts.count
    }
    
    static func filterDublicateNumber(contacts: [CNContact]) -> Int {
        var phoneNumbers = [String]()
        for contact in contacts {
            let stringNumbers = contact.phoneNumbers.map { phoneNumber in
                return phoneNumber.value.stringValue
            }
            phoneNumbers += stringNumbers
        }
        return phoneNumbers.duplicates().count
    }
    
    static func filterDublicateName(contacts: [CNContact]) -> Int {
        let names = contacts.map { contact in
            return contact.givenName
        }
        return names.duplicates().count
    }
}
