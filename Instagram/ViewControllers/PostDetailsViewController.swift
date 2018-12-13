//
//  PostDetailsViewController.swift
//  Instagram
//
//  Created by Stephon Fonrose on 12/12/18.
//  Copyright © 2018 Stephon Fonrose. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController {
    
    var post: Post?
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post {
            let image = post.media
            image.getDataInBackground(block: {(data, error) in
                if (error != nil) {
                    print(error!.localizedDescription)
                } else {
                    print("Image was found!")
                    self.postImage.image = UIImage(data: data!)
                }
            })
            postCaption.text = post.caption
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM d, yyyy h:mm a"
            postDate.text = dateFormatterPrint.string(from: post.createdAt!)
            
            
        }

    }

}
