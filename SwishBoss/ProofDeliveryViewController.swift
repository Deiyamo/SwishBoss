//
//  ProofDeliveryViewController.swift
//  SwishBoss
//
//  Created by William Lin on 25/02/2023.
//

import UIKit

class ProofDeliveryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var parcels : [Parcel]!
    @IBOutlet weak var cvProofDelivery: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cvProofDelivery.backgroundColor =  UIColor(red: 31.0/255, green: 39.0/255, blue: 49.0/255, alpha: 1)
        self.cvProofDelivery.dataSource = self
        self.cvProofDelivery.delegate = self
        let proofCells = UINib(nibName: "ProofDeliveryCollectionViewCell", bundle: nil)
        cvProofDelivery.register(proofCells, forCellWithReuseIdentifier: "cellID")
        // Do any additional setup after loading the view.
    }

    public class func newInstance(parcels: [Parcel]) -> ProofDeliveryViewController{
        let pdvc = ProofDeliveryViewController()
        pdvc.parcels = parcels
        return pdvc
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Set the width and height of the cell
        let width: CGFloat = 250
        let height: CGFloat = 500
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parcels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.cvProofDelivery.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! ProofDeliveryCollectionViewCell
        
        //guard let defaultImage = UIImage(named: "default_user_g6rfhq") else{
        //    return cell
        //}
        //cell.setIvPhoto(image: defaultImage)
        
        let pictureString = "https://swish.ancelotow.com/api/v1/download/parcel/"+parcels[indexPath.row].uuid.uuidString
        print(parcels[indexPath.row].uuid.uuidString)
        
        guard let pictureURL = URL(string: pictureString ) else {
            return cell
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
                cell.setIvPhoto(image: image)
            }
            
        }
        task.resume()
        
        let uuid = parcels[indexPath.row].uuid.uuidString
        cell.setLabelUuid(uuid: uuid)
        
        guard var dateDelivered = parcels[indexPath.row].dateDelivered else{
            return cell
        }
        
        let getFormatter = DateFormatter()
        getFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.000Z'"
        let printFormatter = DateFormatter()
        printFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = getFormatter.date(from: dateDelivered) {
            dateDelivered = printFormatter.string(from: date)
        }
        
        cell.setLabelDateDelivered(date: dateDelivered)
        return cell
    }
    


}
