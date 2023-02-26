//
//  ModalModifyDelivererViewController.swift
//  SwishBoss
//
//  Created by William Lin on 24/02/2023.
//

import UIKit

class ModalModifyDelivererViewController: UIViewController {
    weak var delegate: ModalViewControllerDelegate?
    
    @IBOutlet weak var tf_name: UITextField!
    
    @IBOutlet weak var tf_firstname: UITextField!
    
    @IBOutlet weak var tf_email: UITextField!
    
    @IBOutlet weak var tf_login: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    
    @IBOutlet weak var date_picker_birthday: UIDatePicker!
    
    @IBOutlet weak var iv_image: UIImageView!
    
    var deliverers: Deliverers!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        date_picker_birthday.locale = Locale(identifier: "fr_FR")
        date_picker_birthday.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        date_picker_birthday.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        date_picker_birthday.datePickerMode = .date
        
        self.tf_name.text = deliverers.rows[index].name
        self.tf_firstname.text = deliverers.rows[index].firstname
        self.tf_email.text = deliverers.rows[index].email
        self.tf_login.text = deliverers.rows[index].login
        let pictureString = "https://swish.ancelotow.com/api/v1/download/deliverer/"+deliverers.rows[index].uuid
        
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
                self.iv_image.image = image
            }
            
        }
        task.resume()
        
    }
    
    static func newInstance(deliverers: Deliverers, index: Int) -> ModalModifyDelivererViewController {
        let vc = ModalModifyDelivererViewController()
        vc.deliverers = deliverers
        vc.index = index
        return vc
    }
    
    
    @IBAction func btn_modify_deliverer(_ sender: Any) {
        
        guard let password: String = self.tf_password.text else{
            return
        }
        
        if (self.isValidPassword(password) == false){
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let birthday = dateFormatter.string(from: self.date_picker_birthday.date)
        
        guard let name = self.tf_name.text else{
            return
        }
        
        guard let firstname = self.tf_firstname.text else{
            return
        }
        
        guard let email = self.tf_email.text else{
            return
        }
        guard let login = self.tf_login.text else{
            return
        }
        
        DelivererWebService.modifyDeliverer(uuid: self.deliverers.rows[self.index].uuid, name: name, firstname: firstname, email: email, login: login, password: password, birthday: birthday){err, success in
            guard err == nil else {
                print(err)
                return
            }
            guard (success != nil) else {
                return
            }
            DispatchQueue.main.async {
                print("HELLO")
                //print(success)
                let messages = "Le livreur \(self.tf_name.text ?? self.deliverers.rows[self.index].name) \(self.tf_firstname.text ?? self.deliverers.rows[self.index].firstname) avec le login : \(self.tf_login.text ?? self.deliverers.rows[self.index].login) a bien été modifié."
                let dialogMessage = UIAlertController(title: "Succès", message: messages, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    self.dismiss(animated: true){
                        self.delegate?.modalViewControllerDidDismiss()
                    }
                })
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func btn_delete_deliverer(_ sender: Any) {
        DelivererWebService.deleteDeliverer(delivererUuid: self.deliverers.rows[self.index].uuid){err, success in
            guard err == nil else {
                print(err)
                return
            }
            guard (success != nil) else {
                return
            }
            DispatchQueue.main.async {
                print(success)
                let messages = "Le livreur \(self.deliverers.rows[self.index].name) \(self.deliverers.rows[self.index].firstname) avec le login : \(self.deliverers.rows[self.index].login) a bien été supprimé."
                let dialogMessage = UIAlertController(title: "Succès", message: messages, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    self.dismiss(animated: true){
                        self.delegate?.modalViewControllerDidDismiss()
                    }
                    
                  })
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
    }
    
    private func isValidPassword(_ password: String?) -> Bool {
//        guard let password2 = password else{
//            return false
//        }
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    

}


protocol ModalViewControllerDelegate: AnyObject {
    func modalViewControllerDidDismiss()
}
