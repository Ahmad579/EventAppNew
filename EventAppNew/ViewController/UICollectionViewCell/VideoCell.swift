//
//  VideoCell.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
protocol PlayVideo {
    func playYoutubeVideo(cell : VideoCell , index : IndexPath)
}
class VideoCell: UICollectionViewCell {
    @IBOutlet weak var thumbNailOfClubImage: UIImageView!
    
    var delegate : PlayVideo?
    var index : IndexPath?

    
    
    @IBAction func btnPlayVideo(_ sender: UIButton) {
        self.delegate?.playYoutubeVideo(cell: self, index: index!)
    }
    
}
