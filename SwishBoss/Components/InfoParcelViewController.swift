//
//  InfoParcelViewController.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 24/02/2023.
//

import UIKit

class InfoParcelViewController: UIViewController {
    
    @IBOutlet weak var backgroundLayer: UIView!
    @IBOutlet weak var proofImageView: UIImageView!
    @IBOutlet weak var noProofLabel: UILabel!
    @IBOutlet weak var idParcelLabel: UILabel!
    @IBOutlet weak var dateDeliveredLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var parcel : Parcel!
    
    static func newInstance(parcel: Parcel) -> InfoParcelViewController {
        let controller = InfoParcelViewController()
        controller.parcel = parcel
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 34)!]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        
        showParcelInofrmation()
    }
    
    func showParcelInofrmation() {
        let getFormatter = DateFormatter()
        getFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.000Z'"
        let printFormatter = DateFormatter()
        printFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        
        if parcel.isDelivered {
            self.statusLabel.text = "Livré"
            self.idParcelLabel.text = "\(parcel.uuid)"
            if let date = getFormatter.date(from: parcel.dateDelivered) {
                dateDeliveredLabel.text = printFormatter.string(from: date)
            }
            // self.proofImageView.image = UIImage(data: <#T##Data#>)
        } else {
            self.statusLabel.text = "En cours de livraison"
            self.dateDeliveredLabel.text = "xx/xx/xx xx:xx:xx"
        }
        self.addressLabel.text = "\(parcel.addressStreet), \(parcel.zipCode) \(parcel.town)"
        
        
    }
    
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
}
