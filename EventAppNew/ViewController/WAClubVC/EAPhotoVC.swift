//
//  EAPhotoVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EAPhotoVC: UIViewController , NVActivityIndicatorViewable {
    var index: Int?
    @IBOutlet weak var collectionViewCell: UICollectionView!
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    var clubPhoto : ClubObject?

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
    
//    private func getALLBARImages() {
//        
//        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
//           let loginParam =  [ "club_id"                   : "\(DEVICE_LAT)",
//            
//            ] as [String : Any]
//        
//        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: GETALLBARIMAGES, isLoaderShow: true, serviceType: "All Bar", modelType: UserResponse.self, success: { (response) in
//            self.responseObj = (response as! UserResponse)
//            self.stopAnimating()
//            
//            if self.responseObj?.success == true {
//                
//                
//            } else {
//                
//                
//            }
//            
//        }, fail: { (error) in
//            self.stopAnimating()
//            self.showAlert(title: "PFG", message: error.description, controller: self)
//        }, showHUD: true)
//        
//    }
  

}
extension EAPhotoVC : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
        if  self.clubPhoto?.clubPhoto?.isEmpty == false {
            numOfSections = 1
            collectionViewCell.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionViewCell.bounds.size.width, height: collectionViewCell.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Photo in this Club."
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = .center
            collectionViewCell.backgroundView = noDataLabel
//            collectionViewCell.separatorStyle = .none
        }
        return numOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (clubPhoto?.clubPhoto?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
//        @IBOutlet weak var imgOfClubs: UIImageView!
        let imageUrl = clubPhoto?.clubPhoto![indexPath.row].image
        WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: (cell.imgOfClubs)!, placeHolder: "placeholder")

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.collectionViewCell.frame.size.width/3 - 1
        //        let heightOfCell = self.collectionViewCell.frame.size.height/6
        
        return CGSize(width: sizeOfCell, height: 114)
    }
    
    
}
