//
//  ClubCell.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

protocol AddToFavOrUnFav {
    func ClubAddToFavourite(cell :ClubCell , index : IndexPath )
}

class ClubCell: UITableViewCell {

    @IBOutlet weak var imgOfBar: UIImageView!
    
    @IBOutlet weak var lblClubName: UILabel!
    
    @IBOutlet weak var lblClubLocation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var btnFav: UIButton!
    var delegate : AddToFavOrUnFav?
    var index : IndexPath?
    @IBOutlet weak var lblNumberOfClib: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAddToFav(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        self.delegate?.ClubAddToFavourite(cell: self, index: index!)
        
    }
    
    
}
