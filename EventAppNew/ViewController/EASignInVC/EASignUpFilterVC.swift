//
//  EASignUpFilterVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 06/08/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import RangeSeekSlider
import DatePickerDialog
import NVActivityIndicatorView

class EASignUpFilterVC: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet weak var collectionViewCell: UICollectionView!
    let size = CGSize(width: 60, height: 60)
    
    let barArray = ["POP", "HIPHOP", "EDM"]
    let imageArray = ["img1", "img2", "img3"]

    var itemSelect : String?
    var selectIsFeatureOrView : String?
    @IBOutlet fileprivate weak var selectRadius: RangeSeekSlider!
    @IBOutlet fileprivate weak var selectCost: RangeSeekSlider!
    @IBOutlet weak var btnFeaturePressed: UIButton!
    
    @IBOutlet weak var btnMostView: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    
    @IBOutlet weak var filterButton : UIButton!
    var isDateSelect : String?

    var radius : Int?
    var costRange : Int?
    var responseObj: UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewCell.delegate = self
        collectionViewCell.dataSource = self
        collectionViewCell.reloadData()
        radius = 0
        costRange = 0

        filterButton.layer.shadowOpacity = 0.5
        filterButton.layer.shadowOffset = CGSize(width: 2.0, height: 5.0)
        filterButton.layer.shadowRadius = 3.0
        filterButton.layer.shadowColor = UIColor.black.cgColor
        
        
        selectRadius.delegate = self
        selectCost.delegate = self
        
        //        selectRadius.addTarget(self, action: #selector(EARightSideMenu.changeTheSliderRadius), for: .valueChanged)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSelectDate_Pressed(_ sender: UIButton) {
        datePickerTapped()
    }
    
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func datePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = 1970
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: .black,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("DatePickerDialog",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                let dateValue = formatter.string(from: dt)
                                self.btnDate.setTitle(dateValue, for: .normal)
                                self.isDateSelect = dateValue
                                
                            }
        }
    }
    
    
    @IBAction func btnFeature_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnMostView.isSelected = false
        btnFeaturePressed.isSelected = true
        btnFeaturePressed.backgroundColor = UIColor(red: 39/255.0, green: 29/255.0, blue: 94/255.0, alpha: 1.0)
        btnMostView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        selectIsFeatureOrView = "is_featured"
    }
    
    @IBAction func btnMostViewed_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnMostView.isSelected = true
        btnFeaturePressed.isSelected = false
        btnMostView.backgroundColor = UIColor(red: 39/255.0, green: 29/255.0, blue: 94/255.0, alpha: 1.0)
        btnFeaturePressed.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        selectIsFeatureOrView = "views"
        
        
    }

    @IBAction func btnFilter_Pressed(_ sender: UIButton) {
        
        if itemSelect == nil {
            self.showAlert(title: "Event App", message: "Please Select the Event Type", controller: self)
        }
        else if self.isDateSelect == nil {
            self.showAlert(title: "Event App", message: "Please Select the Date", controller: self)
            
        }
        else if self.radius == 0 {
            self.showAlert(title: "Event App", message: "Please Select the Radius", controller: self)
            
        }
        else if self.costRange == 0 {
            self.showAlert(title: "Event App", message: "Please Select the Cost Range", controller: self)
            
        }
        else if self.selectIsFeatureOrView == nil {
            self.showAlert(title: "Event App", message: "Please Select the Sort Result", controller: self)
            
        }
        
        else {
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        let dateSelect = self.btnDate.titleLabel?.text!
        let loginParam =  [ "latitude"        : "\(DEVICE_LAT)",
            "longitude"                       : "\(DEVICE_LONG)" ,
            "type"                            :  itemSelect! ,
            "date"                            :  dateSelect! ,
            "radius"                          : "\(radius!)" ,
            "costupto"                        : "\(costRange!)" ,
            "view_by"                         :  selectIsFeatureOrView!
            ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: APPLYFILTER, isLoaderShow: true, serviceType: "Verify Code", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            self.stopAnimating()
            
            if self.responseObj?.success == true {
                
               UserDefaults.standard.set(self.itemSelect! , forKey: "type")
               UserDefaults.standard.set(dateSelect , forKey: "date")
               UserDefaults.standard.set(self.radius , forKey: "radius")
               UserDefaults.standard.set(self.costRange , forKey: "costupto")
               UserDefaults.standard.set(self.selectIsFeatureOrView , forKey: "view_by")
                WAShareHelper.goToHomeController(vcIdentifier: "EAEventHomeVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "EALeftSideMenuVC", rightMenuIdentifier: "EARightSideMenu")
                
            } else {
                self.showAlert(title: "Event App", message: (self.responseObj?.message)!, controller: self)
                
                
            }
            
        }, fail: { (error) in
            self.stopAnimating()
            self.showAlert(title: "Event App", message: error.description, controller: self)
        }, showHUD: true)
        
        }
        //
    }

}


extension EASignUpFilterVC : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        let barTitle = self.barArray[indexPath.row]
        let imageName = self.imageArray[indexPath.row]
        cell.lblTitle.text = barTitle

        cell.imgOfFilterEvent.image = UIImage(named: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelect = self.barArray[indexPath.row]
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.collectionViewCell.frame.size.width/3 - 5
        //        let heightOfCell = self.collectionViewCell.frame.size.height/6
        
        return CGSize(width: sizeOfCell, height: 82)
    }
    
    
}


extension EASignUpFilterVC: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === selectRadius {
            radius = Int(maxValue)
            
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        } else if slider === selectCost {
            costRange = Int(maxValue)
            
            print("Currency slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        }
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}
