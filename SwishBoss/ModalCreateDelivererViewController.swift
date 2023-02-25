//
//  ModalCreateDelivererViewController.swift
//  SwishBoss
//
//  Created by William Lin on 24/02/2023.
//

import UIKit

class ModalCreateDelivererViewController: UIViewController{
    weak var delegate: ModalViewControllerDelegate?

    @IBOutlet weak var tf_name: UITextField!
    
    @IBOutlet weak var tf_firstname: UITextField!
    
    @IBOutlet weak var tf_email: UITextField!
    
    @IBOutlet weak var tf_login: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    
    @IBOutlet weak var date_picker_birthday: UIDatePicker!
    
    @IBOutlet weak var iv_image: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date_picker_birthday.locale = Locale(identifier: "fr_FR")
        date_picker_birthday.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        date_picker_birthday.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        date_picker_birthday.datePickerMode = .date
    }

    
    @IBAction func btn_create_deliverer(_ sender: Any) {
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
        guard let password = self.tf_password.text else{
            return
        }
        if (self.isValidPassword(password) == false){
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let birthday = dateFormatter.string(from: self.date_picker_birthday.date)
        
        guard let image = self.iv_image.image else{
            return
        }
        
        guard let imageData = image.pngData() else {
                return
        }
        
        
                
        let urlPhoto = "https://res.cloudinary.com/dystym6wg/image/upload/v1657645756/upload_upoll/user/default_user_g6rfhq.jpg"
        
        DelivererWebService.createDeliverer(name: name, firstname: firstname, email: email, login: login, password: password, birthday: birthday, urlPhoto: imageData){err, success in
            guard err == nil else {
                print(err)
                return
            }
            guard (success != nil) else {
                return
            }
            DispatchQueue.main.async {
                print(success)
                // Create a new alert
                let messages = "Le livreur \(name) \(firstname) avec le login : \(login) a bien été créé."
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
    
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    

    @IBAction func btn_image_picker(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension  ModalCreateDelivererViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        iv_image.image = image
        dismiss(animated: true)
    }
}
