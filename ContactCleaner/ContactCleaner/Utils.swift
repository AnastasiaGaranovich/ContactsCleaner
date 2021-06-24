//
//  Utils.swift
//  ContactCleaner
//
//  Created by Анастасия Гаранович on 23.06.2021.
//

import UIKit

extension UIViewController {
    func settingsAlert(message: String) {
        let dialogMessage = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        let settings = UIAlertAction(title: "Settings", style: .default, handler: { (action) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                print("Failed to get settigs url")
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        })
        dialogMessage.addAction(settings)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

extension Array where Element: Hashable {
    func duplicates() -> Array {
        let groups = Dictionary(grouping: self, by: {$0})
        let duplicateGroups = groups.filter {$1.count > 1}
        let duplicates = Array(duplicateGroups.keys)
        return duplicates
    }
}
