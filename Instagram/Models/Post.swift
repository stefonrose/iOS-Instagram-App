//
//  Post.swift
//  Instagram
//
//  Created by Stephon Fonrose on 12/11/18.
//  Copyright © 2018 Stephon Fonrose. All rights reserved.
//

import Foundation
import UIKit
import Parse


class Post: PFObject, PFSubclassing {
    @NSManaged var media : PFFileObject
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    
    class func parseClassName() -> String {
        return "Post"
    }
    
    /**
     * Other methods
     */
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        let post = Post()
        
        post.media = getPFFileFromImage(image: image)!
        post.author = PFUser.current()!
        if let caption = caption {
            post.caption = caption
        }
        post.likesCount = 0
        post.commentsCount = 0
        post.saveInBackground(block: completion)
        
        let vc = UIApplication.shared.keyWindow?.rootViewController?.children[0]
        if (vc?.isKind(of: HomeFeedViewController.self))! {
            
        }
        
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFileObject? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = image.pngData() {
                return PFFileObject(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
