//
//  EAEventHomeVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EAEventHomeVC: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet weak var collectionViewCell: UICollectionView!
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        
        getAllEvent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getAllEvent() {
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        let itemSelect = UserDefaults.standard.string(forKey: "type")
        let dateSelect = UserDefaults.standard.string(forKey: "date")
        let radiusRange = UserDefaults.standard.integer(forKey: "radius")
        let cost = UserDefaults.standard.integer(forKey: "costupto")
        let selectView = UserDefaults.standard.string(forKey: "view_by")
        let loginParam =  [ "latitude"                        : "\(DEVICE_LAT)",
                            "longitude"                       : "\(DEVICE_LONG)" ,
                            "type"                            :  itemSelect! ,
                            "date"                            :  dateSelect! ,
                            "radius"                          : "\(radiusRange)" ,
                            "costupto"                        : "\(cost)" ,
                            "view_by"                         :  selectView!
                         ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: APPLYFILTER, isLoaderShow: true, serviceType: "Apply Filter", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            self.stopAnimating()
            
            if self.responseObj?.success == true {
                self.collectionViewCell.delegate = self
                self.collectionViewCell.dataSource = self
                self.collectionViewCell.reloadData()
                
            } else {
                self.collectionViewCell.delegate = self
                self.collectionViewCell.dataSource = self
                self.collectionViewCell.reloadData()
                
            }
            
        }, fail: { (error) in
            self.stopAnimating()
            self.showAlert(title: "Event App", message: error.description, controller: self)
        }, showHUD: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnLeft_MenuPressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
    }
    
    @IBAction func btnRight_MenuPressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.rightViewController)
    }
}

extension EAEventHomeVC : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
        if  self.responseObj?.event?.isEmpty == false {
            numOfSections = 1
            collectionViewCell.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionViewCell.bounds.size.width, height: collectionViewCell.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Event in this Time."
            noDataLabel.textColor = UIColor.lightGray
            noDataLabel.textAlignment = .center
            collectionViewCell.backgroundView = noDataLabel
            //            collectionViewCell.separatorStyle = .none
        }
        return numOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.responseObj?.event?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCell
        let imageUrl = self.responseObj?.event![indexPath.row].picture
        WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: cell.imgOfEvent, placeHolder: "placeholder")
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.collectionViewCell.frame.size.width/2 - 1
        //        let heightOfCell = self.collectionViewCell.frame.size.height/6
        
        return CGSize(width: sizeOfCell, height: 266.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EAEventDetailVC") as? EAEventDetailVC
        vc?.event = self.responseObj?.event![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
