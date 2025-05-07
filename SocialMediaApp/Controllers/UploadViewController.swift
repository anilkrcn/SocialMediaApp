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
    var imageURL : URL?
    
    let db = Firestore.firestore()
    //var posts: [Post] = []
    
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
        if let selectedImage = info[.editedImage] as? UIImage, let selectedImageURL = info[.imageURL] as? URL{
                imageView.image = selectedImage
                imageButton.isHidden = true
                imageURL = selectedImageURL
                //print(imageURL)
        } else if let originalImage = info[.originalImage] as? UIImage, let originalImageURL = info[.imageURL] as? URL {
                imageView.image = originalImage
                imageButton.isHidden = true
                imageURL = originalImageURL
            }
            dismiss(animated: true, completion: nil)
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        if let publisher = Auth.auth().currentUser?.email {
            db.collection("posts").addDocument(data: [
                "imageURL": imageURL!.absoluteString,
                "usermail": publisher,
                "likes": 0,
                "captionText": uploadTextField.text ?? ""
            ]){(error) in
                if let e = error{
                    print("There was an issue saving data to firestore, \(e)")
                }else{
                    print("Succesfully saved data")
                    DispatchQueue.main.async {
                        self.imageButton.isHidden = false
                        self.imageView.image = nil
                    }
                }
            }
        }
    }
    
    func saveImageToDocumentsDirectory(imageURL: URL) -> URL? {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectory.appendingPathComponent(imageURL.lastPathComponent)

        do {
            if !fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.copyItem(at: imageURL, to: destinationURL)
            }
            return destinationURL
        } catch {
            print("Görsel kopyalanamadı: \(error)")
            return nil
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

}
