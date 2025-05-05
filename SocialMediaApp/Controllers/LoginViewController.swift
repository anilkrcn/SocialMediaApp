//
//  ViewController.swift
//  SocialMediaApp
//
//  Created by Anıl Karacan on 5.05.2025.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    override func viewDidLoad() {
        alertLabel.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                    self.alertLabel.isHidden = false
                    self.alertLabel.text = e.localizedDescription
                }else{
                    print("Kullanıcı girişi başarılı")
                }
            }
        }
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                    self.alertLabel.isHidden = false
                    self.alertLabel.text = e.localizedDescription
                }else{
                    print("Kullanıcı kaydı başarılı")
                }
            }
        }
    }
    
    
    
    

}

