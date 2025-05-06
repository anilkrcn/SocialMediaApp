//
//  FeedCell.swift
//  SocialMediaApp
//
//  Created by Anıl Karacan on 6.05.2025.
//

import UIKit
import FirebaseFirestore

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var usermailLabel: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    let db = Firestore.firestore()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        let fireStoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeCount.text!) {
            
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            
            fireStoreDatabase.collection("posts").document().setData(likeStore, merge: true)
            
        }
        
    }
}
