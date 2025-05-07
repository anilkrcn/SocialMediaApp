//
//  FeedViewController.swift
//  SocialMediaApp
//
//  Created by Anıl Karacan on 5.05.2025.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        loadPosts()
        tableView.rowHeight = 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Veri sayısı: \(posts.count)")
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
            /*let url = URL(string: post.imageURL)
            URLSession.shared.dataTask(with: url!) { [weak self] data, response, error in
                    // Hata kontrolü
                    if let error = error {
                        print("Görsel yükleme hatası: \(error.localizedDescription)")
                        return
                    }
                    // Verinin varlığını ve geçerli bir görsel olup olmadığını kontrol et
                    guard let data = data, let image = UIImage(data: data) else {
                        print("Görsel verisi geçersiz.")
                        return
                    }

                    // 3. Ana iş parçacığında (main thread) görseli yükle
                    DispatchQueue.main.async {
                        cell.postImage.image = image
                    }
                }.resume()*/
        if let fileURL = URL(string: post.imageURL) {
            do {
                let data = try Data(contentsOf: fileURL)
                if let image = UIImage(data: data) {
                    cell.postImage.image = image
                }
            } catch {
                print("Görsel yüklenemedi: \(error)")
            }
        }
        
        cell.captionLabel.text = post.captionText
        cell.usermailLabel.text = post.usermail
        cell.likeCount.text = String(post.likes)
        
        return cell
    }
    
    func loadPosts(){
        let db = Firestore.firestore()
        db.collection("posts")
            .addSnapshotListener{ querySnapshot, error in
                self.posts = []
            
            if let e = error{
                print("Firestore couldnt get the data, \(e)")
            }else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let imageURL = data["imageURL"] as? String,
                           let likes = data["likes"] as? Int,
                           let usermail = data["usermail"] as? String,
                           let captionText = data["captionText"] as? String{
                            
                            let newPost = Post(docID: doc.documentID, usermail: usermail, imageURL: imageURL, captionText: captionText, likes: likes)
                            self.posts.append(newPost)
                            print(self.posts[0].imageURL)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }


}
