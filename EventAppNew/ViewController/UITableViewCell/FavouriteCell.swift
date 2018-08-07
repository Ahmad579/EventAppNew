//
//  FavouriteCell.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {

    @IBOutlet weak var imgOfFavourite: UIImageView!
    
    @IBOutlet weak var lblClubName: UILabel!
    @IBOutlet weak var lblClubLocation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
