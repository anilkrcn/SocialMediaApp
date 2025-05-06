//
//  UploadViewController.swift
//  SocialMediaApp
//
//  Created by Anıl Karacan on 5.05.2025.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var uploadTextField: UITextField!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true // Kullanıcı düzenleme yapabilir
            present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.editedImage] as? UIImage {
                imageView.image = selectedImage
                imageButton.isHidden = true
            } else if let originalImage = info[.originalImage] as? UIImage {
                imageView.image = originalImage
                imageButton.isHidden = true
            }
            dismiss(animated: true, completion: nil)
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        print("Your post has been shared!")
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
