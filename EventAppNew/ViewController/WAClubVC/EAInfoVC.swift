//
//  EAInfoVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import MapKit
class EAInfoVC: UIViewController {
    var index: Int?
    @IBOutlet var tblView: UITableView!
    var responseObj: UserResponse?
    var clubInfo: ClubObject?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        tblView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func settingMap(cell: InfoCell) {
        
        let lat = self.clubInfo?.latitude
        let lng = self.clubInfo?.longitude

        let center = CLLocationCoordinate2D(latitude:Double(lat!)! , longitude: Double(lng!)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9))
        
       cell.viewOfMAp.setRegion(region, animated: true)

//        let latitudes = [Double]()
//        let longitudes = [Double]()
//        let names = [String]()
//
//        let coordinates = zip(latitudes, longitudes).map(CLLocationCoordinate2D.init)
//
//        let annotations = zip(coordinates, names)
//            .map { (coordinate, name) -> MKPointAnnotation in
//                let annotation = MKPointAnnotation()
//
//                annotation.coordinate = coordinate
//                annotation.title = name
//
//                return annotation
//        }
//
//        map.addAnnotations(annotations)
//        map.showAnnotations(annotations, animated: true)
        
//        let camera = GMSCameraPosition.camera(withLatitude: (self.parseObject?.data?.Business?.lat == nil) ? Double(DEVICE_LAT) : Double((self.parseObject?.data?.Business?.lat)!)! , longitude: (self.parseObject?.data?.Business?.lng == nil) ? Double(DEVICE_LONG) : Double((self.parseObject?.data?.Business?.lng)!)!, zoom: 17.0)
//        cell.viewMap.camera = camera
//        cell.viewMap.clear()
//        let marker = GMSMarker()
//        WAShareHelper.loadImageWithCompletion(urlstring: (self.parseObject?.data?.Business?.category_logo)!, showLoader: false, imageView: imgView) { (image) in
//            marker.icon = self.imgView.image
//        }
//        marker.position = camera.target
//        //marker.accessibilityLabel = "\(scheduleInfo)"
//        marker.position = CLLocationCoordinate2D(latitude:Double((self.parseObject?.data?.Business?.lat!)!)!, longitude:Double((self.parseObject?.data?.Business?.lng!)!)!)
//        self.bounds = self.bounds.includingCoordinate(marker.position)
//        marker.map = cell.viewMap
        
        
        
        
    }
}

extension EAInfoVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        //        var numOfSections: Int = 0
        //            if  self.responseObj?.listOfRestaurant?.isEmpty == false {
        //                numOfSections = 1
        //                tblView.backgroundView = nil
        //            }
        //            else {
        //                let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
        //                noDataLabel.numberOfLines = 10
        //                if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
        //                    noDataLabel.font = aSize
        //                }
        //                noDataLabel.text = "There are currently no Restaurant."
        //                noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
        //                noDataLabel.textAlignment = .center
        //                tblView.backgroundView = noDataLabel
        //                tblView.separatorStyle = .none
        //            }
        //            return numOfSections
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else {
            return (self.clubInfo?.clubTeam?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell
            cell?.lblAddress.text = self.clubInfo?.bar_name
            let openTime = self.clubInfo?.open_time!
            let closeTime = self.clubInfo?.close_time!
            
            cell?.lblLocation.text = "\(openTime!) \(closeTime!)"
            settingMap(cell: cell!)

            return cell!

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell
            cell?.lblTitleOfUser.text = self.clubInfo?.clubTeam![indexPath.row].title
            cell?.lblDesignation.text = self.clubInfo?.clubTeam![indexPath.row].designation
            
            return cell!

        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EABlogDetailVC") as? EABlogDetailVC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return  221.0

        } else {
            return  56.0

        }
    }
}
