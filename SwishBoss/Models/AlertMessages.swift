//
//  AlertMessages.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 25/02/2023.
//

import UIKit

class AlertMessages {
    class func show(message: String, parent: UIViewController) {
        let alert = UIAlertController(title: "Alerte", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Anunler", style: .cancel))
        alert.addAction(UIAlertAction(title: "Supprimer", style: .destructive))
        parent.present(alert, animated: true)
    }
}
