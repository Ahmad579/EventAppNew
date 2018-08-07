//
//  EAFavouriteVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EAFavouriteVC: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet var tblView: UITableView!
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "ClubCell", bundle: nil), forCellReuseIdentifier: "ClubCell")
        getALlFavourite()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func getALlFavourite() {
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        let userId = localUserData.user_id
        let loginParam =  [ "user_id"                   : "\(userId!)",
            
            ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: GETALLFAVOURITE, isLoaderShow: true, serviceType: "All Bar", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            self.stopAnimating()
            
            if self.responseObj?.success == true {
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
                
            } else {
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
                
            }
            
        }, fail: { (error) in
            self.stopAnimating()
//            self.showAlert(title: "PFG", message: error.description, controller: self)
        }, showHUD: true)
        
    }
    
    @IBAction func btnLeft_MenuPressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }

}

extension EAFavouriteVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  self.responseObj?.clubList?.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Favourite ."
            noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.responseObj?.clubList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell", for: indexPath) as? ClubCell
        
        let imageUrl = self.responseObj?.clubList![indexPath.row].picture
        WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: (cell?.imgOfBar)!, placeHolder: "placeholder")
        cell?.lblClubName.text = self.responseObj?.clubList![indexPath.row].bar_name
        let openTime = self.responseObj?.clubList![indexPath.row].open_time
        let closeTime = self.responseObj?.clubList![indexPath.row].close_time
        cell?.lblTime.text = "\(openTime!) \(closeTime!)"
//        let count = indexPath.row + 1
//        cell?.lblNumberOfClib.text = "\(count)"
//        cell?.delegate = self
//        cell?.index = indexPath
        let isTrueOrNot = self.responseObj?.clubList![indexPath.row].IsFavorite
        if isTrueOrNot == true {
            cell?.btnFav.isSelected = true
        } else {
            cell?.btnFav.isSelected = false
        }
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  256.0
    }
}
