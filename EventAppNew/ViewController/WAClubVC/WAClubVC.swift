//
//  WAClubVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WAClubVC: UIViewController , NVActivityIndicatorViewable , UISearchBarDelegate{
   
    @IBOutlet var searchBar: UISearchBar!
    var searchActive : Bool = false
    var filters: [ClubObject]?

    @IBOutlet var tblView: UITableView!
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "ClubCell", bundle: nil), forCellReuseIdentifier: "ClubCell")
        tblView.tableFooterView = UIView()
        getALLClub()
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
    
    
    @IBAction func btnLeft_MenuPressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }
    
    private func getALLClub() {
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        let userID = localUserData.user_id!
        let loginParam =  [ "latitude"                   : "\(DEVICE_LAT)",
            "longitude"                                  : "\(DEVICE_LONG)" ,
            "user_id"                                    : "\(userID)"
            ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: GETALLBAR, isLoaderShow: true, serviceType: "All Bar", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            self.stopAnimating()
            
            if self.responseObj?.success == true {
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
                
            } else {
                self.showAlert(title: "Event App", message: (self.responseObj?.message!)!, controller: self)
                
                
            }
            
        }, fail: { (error) in
            self.stopAnimating()
            self.showAlert(title: "PFG", message: error.description, controller: self)
        }, showHUD: true)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.tblView.reloadData()
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBar.showsCancelButton = true
        searchActive = true
        filters = self.responseObj?.clubList?.filter { ($0.bar_name?.lowercased().contains(searchText.lowercased()))! }
        //        filterSchedule = filters
        self.tblView.reloadData()
        
    }

    
}

extension WAClubVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        
        if searchActive == true {
            if  self.filters?.isEmpty == false {
                numOfSections = 1
                tblView.backgroundView = nil
            }
            else {
                let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
                noDataLabel.numberOfLines = 10
                if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                    noDataLabel.font = aSize
                }
                noDataLabel.text = "There are currently no Club."
                noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
                noDataLabel.textAlignment = .center
                tblView.backgroundView = noDataLabel
                tblView.separatorStyle = .none
            }
            return numOfSections
        } else {
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
        
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searchActive == true {
            return (self.filters?.count)!
        }else {
            return (self.responseObj?.clubList?.count)!

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell", for: indexPath) as? ClubCell
        
        if searchActive == true {
            let imageUrl = filters![indexPath.row].picture
            WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: (cell?.imgOfBar)!, placeHolder: "placeholder")
            cell?.lblClubName.text = filters![indexPath.row].bar_name
            let openTime = filters![indexPath.row].open_time
            let closeTime = filters![indexPath.row].close_time
            cell?.lblTime.text = "\(openTime!) \(closeTime!)"
            let count = indexPath.row + 1
            cell?.lblNumberOfClib.text = "\(count)"
            cell?.delegate = self
            cell?.index = indexPath
            let isTrueOrNot = filters![indexPath.row].IsFavorite
            if isTrueOrNot == true {
                cell?.btnFav.isSelected = true
            } else {
                cell?.btnFav.isSelected = false
            }
        } else {
            let imageUrl = self.responseObj?.clubList![indexPath.row].picture
            WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: (cell?.imgOfBar)!, placeHolder: "placeholder")
            cell?.lblClubName.text = self.responseObj?.clubList![indexPath.row].bar_name
            let openTime = self.responseObj?.clubList![indexPath.row].open_time
            let closeTime = self.responseObj?.clubList![indexPath.row].close_time
            cell?.lblTime.text = "\(openTime!) \(closeTime!)"
            let count = indexPath.row + 1
            cell?.lblNumberOfClib.text = "\(count)"
            cell?.delegate = self
            cell?.index = indexPath
            let isTrueOrNot = self.responseObj?.clubList![indexPath.row].IsFavorite
            if isTrueOrNot == true {
                cell?.btnFav.isSelected = true
            } else {
                cell?.btnFav.isSelected = false
            }
        }
      
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EAContainerVC") as? EAContainerVC
//        vc?.club = self.responseObj?.clubList![indexPath.row]
     
        if searchActive == true {
            vc?.club = filters![indexPath.row]

        } else {
            vc?.club = self.responseObj?.clubList![indexPath.row]

        }
       
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  256.0
    }
}

extension WAClubVC : AddToFavOrUnFav {
    
    func ClubAddToFavourite(cell: ClubCell, index: IndexPath) {
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        let userID = localUserData.user_id!
        let clubId : String?
        if searchActive == true {
            clubId = filters![index.row].bar_id!
        } else {
            clubId = self.responseObj?.clubList![index.row].bar_id!
        }
        let loginParam =  [ "club_id"                    : "\(clubId!)",
                            "user_id"                    : "\(userID)"
            ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: FAVBAR, isLoaderShow: true, serviceType: "All Bar", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            self.stopAnimating()
            
            if self.responseObj?.success == true {
                cell.btnFav.isSelected = true
                
            } else {
                self.showAlert(title: "Event App", message: (self.responseObj?.message!)!, controller: self)
                
                
            }
            
        }, fail: { (error) in
            self.stopAnimating()
            self.showAlert(title: "PFG", message: error.description, controller: self)
        }, showHUD: true)
    }
}


