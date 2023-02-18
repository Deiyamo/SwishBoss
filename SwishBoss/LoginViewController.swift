//
//  LoginViewController.swift
//  SwishBoss
//
//  Created by William Lin on 16/02/2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginLable: UIView!
    @IBAction func loginButton(_ sender: Any) {
        Token.token = "hello"
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("NO")
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
