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
            if let date = getFormatter.date(from: parcel.dateDelivered!) {
                dateDeliveredLabel.text = printFormatter.string(from: date)
            }
            
            
            let pictureString = "https://swish.ancelotow.com/api/v1/download/parcel/\(parcel.uuid)"
            
            guard let pictureURL = URL(string: pictureString ) else {
                return
            }
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: pictureURL) { (data, response, error) in
                guard let imageData = data else {
                    print("No image data received")
                    return
                }
                
                guard let image = UIImage(data: imageData) else {
                    print("Invalid image data")
                    return
                }
                
                // Set the image property of the UIImageView to the downloaded image
                DispatchQueue.main.async {
                    self.proofImageView.image = image
                    self.noProofLabel.isHidden = true
                }
                
            }
            task.resume()
            
            
            
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
