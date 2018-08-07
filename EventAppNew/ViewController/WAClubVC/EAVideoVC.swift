//
//  EAVideoVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EAVideoVC: UIViewController, NVActivityIndicatorViewable {
    var index: Int?
    @IBOutlet weak var collectionViewCell: UICollectionView!
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    var clubVideo: ClubObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewCell.delegate = self
        collectionViewCell.dataSource = self
        collectionViewCell.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getYoutubeId(youtubeUrl: String) -> String? {
        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
    

}

extension EAVideoVC : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
        if  self.clubVideo?.clubVideo?.isEmpty == false {
            numOfSections = 1
            collectionViewCell.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionViewCell.bounds.size.width, height: collectionViewCell.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Videos in this Club."
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = .center
            collectionViewCell.backgroundView = noDataLabel
            //            collectionViewCell.separatorStyle = .none
        }
        return numOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.clubVideo?.clubVideo?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.delegate = self
        cell.index = indexPath
        let imageUrl = clubVideo?.clubVideo![indexPath.row].thumbNail
       
        WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: (cell.thumbNailOfClubImage)!, placeHolder: "placeholder")

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.collectionViewCell.frame.size.width/2 - 1
        //        let heightOfCell = self.collectionViewCell.frame.size.height/6
        
        return CGSize(width: sizeOfCell, height: 140.0)
    }
    
    
}
extension EAVideoVC : PlayVideo {
    func playYoutubeVideo(cell: VideoCell, index: IndexPath) {
        let videoUrl = clubVideo?.clubVideo![index.row].image
        let  videoId = getYoutubeId(youtubeUrl: videoUrl!)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EAVideoPlayVC") as? EAVideoPlayVC
        vc?.idOfVideo = videoId
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
