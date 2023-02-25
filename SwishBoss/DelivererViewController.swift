//
//  DelivererViewController.swift
//  SwishBoss
//
//  Created by William Lin on 18/02/2023.
//

import UIKit

class DelivererViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ModalViewControllerDelegate{
    func modalViewControllerDidDismiss() {
        DelivererWebService.getItems(){err, success in
            guard err == nil else {
                print(err)
                return
            }
            guard (success != nil) else {
                return
            }
            DispatchQueue.main.async {
                //print(success)
                self.deliverers = success
                self.cvDeliverer.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deliverers.rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let modalModify = ModalModifyDelivererViewController.newInstance(deliverers: deliverers, index: indexPath.row)
        modalModify.delegate = self
        present(modalModify, animated: true, completion: nil)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.cvDeliverer.dequeueReusableCell(withReuseIdentifier: "DelivererCollectionViewCell", for: indexPath) as! DelivererCollectionViewCell
        
        guard let pictureString = deliverers.rows[indexPath.row].urlphoto else{
            return cell
        }
        
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
        
        let name = deliverers.rows[indexPath.row].name
        cell.setLabelName(name: name)
        
        let firstname = deliverers.rows[indexPath.row].firstname
        cell.setLabelFirstname(firstname: firstname)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: 150, height: 200)
//        }
    
    var deliverers : Deliverers!

    
    @IBOutlet weak var cvDeliverer: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cvDeliverer.backgroundColor = UIColor(red: 145.0/255, green: 183.0/255, blue: 225.0/255, alpha: 1)
        self.cvDeliverer.dataSource = self
        self.cvDeliverer.delegate = self
        self.registerCollectionViewCells(identifier: "DelivererCollectionViewCell",uiCollection: self.cvDeliverer)

       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAddDeliverer(_ sender: Any) {
        let modalVC = ModalCreateDelivererViewController(nibName: "ModalCreateDelivererViewController", bundle: nil)
        modalVC.delegate = self
            present(modalVC, animated: true, completion: nil)
        
    }
    

    public class func newInstance(deliverers: Deliverers) -> DelivererViewController{
        let dvc = DelivererViewController()
        dvc.deliverers = deliverers
        return dvc
    }
    
    private func registerCollectionViewCells(identifier :String, uiCollection : UICollectionView){
        let textFieldCell = UINib(nibName: identifier, bundle: nil)
        
        uiCollection.register(textFieldCell, forCellWithReuseIdentifier: identifier)
    }

}
