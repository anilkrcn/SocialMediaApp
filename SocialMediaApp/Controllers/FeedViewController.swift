//
//  FeedViewController.swift
//  SocialMediaApp
//
//  Created by Anıl Karacan on 5.05.2025.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {

    var posts: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func fetchPosts() {
        let db = Firestore.firestore()
        db.collection("posts").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching posts: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap { doc in
                let data = doc.data()
                guard let imageURL = data["imageURL"] as? String,
                      let likes = data["likes"] as? Int,
                      let usermail = data["usermail"] as? String,
                      let captionText = data["captionText"] as? String else { return nil }
                
                return Post(docID: doc.documentID, usermail: usermail, imageURL: imageURL, captionText: captionText, likes: likes)
            }
            
        }
    }


}
