//
//  SettingsViewController.swift
//  SocialMediaApp
//
//  Created by Anıl Karacan on 5.05.2025.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
       
        do {
          try Auth.auth().signOut()
            let loginVC = LoginViewController()
                    let window = UIApplication.shared.windows.first { $0.isKeyWindow }
                    window?.rootViewController = loginVC
                    window?.makeKeyAndVisible()
            UIView.transition(with: window!,
                                      duration: 0.3,
                                      options: .transitionFlipFromLeft,
                                      animations: nil,
                                      completion: nil)
            //performSegue(withIdentifier: "LogOutSegue", sender: nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


