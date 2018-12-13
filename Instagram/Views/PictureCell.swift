//
//  PictureCell.swift
//  Instagram
//
//  Created by Stephon Fonrose on 12/10/18.
//  Copyright © 2018 Stephon Fonrose. All rights reserved.
//

import UIKit
import Parse

class PictureCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
