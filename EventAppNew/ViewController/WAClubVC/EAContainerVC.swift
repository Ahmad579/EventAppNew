//
//  EAContainerVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EAContainerVC: UIViewController , NVActivityIndicatorViewable {
  
    @IBOutlet var viewOfBio: UIView!
    @IBOutlet var viewOfPhoto: UIView!
    @IBOutlet var viewOFVideo: UIView!
    var pageVC: UIPageViewController?
    var showingIndex: Int = 0
//    var club : ClubObject?
    @IBOutlet weak var imgOfBar: UIImageView!
    let size = CGSize(width: 60, height: 60)
    var club: ClubObject?

    @IBOutlet var viewBottom: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewOfBio.isHidden = false
        viewOfPhoto.isHidden = true
        viewOFVideo.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.setPager()
        self.view.bringSubview(toFront: self.viewBottom)
        let imageUrl = club?.picture
        WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: (self.imgOfBar)!, placeHolder: "placeholder")

//        getALLDetailClub()
        

        // Do any additional setup after loading the view.
    }

//    private func getALLDetailClub() {
//
//        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
//        let clubId = club?.bar_id
//        let loginParam =  [
//                        "club_id"                                    : "\(4)"
//            ] as [String : Any]
//
//        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: GETALLBARDETAIL, isLoaderShow: true, serviceType: "All Bar Detail", modelType: UserResponse.self, success: { (response) in
//            self.responseObj = (response as! UserResponse)
//            self.stopAnimating()
//
//            if self.responseObj?.success == true {
//
//
//
//            } else {
//                self.showAlert(title: "Event App", message: (self.responseObj?.message!)!, controller: self)
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
    
    //MARK: custom methods
    func setPager() {
        pageVC = storyboard?.instantiateViewController(withIdentifier: "PageMenuDetail") as! UIPageViewController?
        //        pageVC?.dataSource = self
        //        pageVC?.delegate = self
        
        
        let startVC = viewControllerAtIndex(tempIndex: 0)
        _ = startVC.view
        //        imageOfBottomAccount.isHidden = true
        //        lblAccount.textColor = UIColor(red: 195/255, green: 195/255, blue: 195/255, alpha: 1.0)
        
        self.revealController.recognizesPanningOnFrontView = false
        
        pageVC?.setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        pageVC?.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEGHT)
        self.addChildViewController(pageVC!)
        self.view.addSubview((pageVC?.view)!)
        self.pageVC?.didMove(toParentViewController: self)
        
    }
    @IBAction func btnPhoneCall_Pressed(_ sender: UIButton) {
        let phoneNumber = self.club?.clunInfo?.contact_number
        guard let number = URL(string: "tel://" + phoneNumber!) else { return }
        UIApplication.shared.open(number)

        
    }
    
    @IBAction func btnEmail_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnWebSite_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnShare_Pressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFavourite_Pressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func bottomBarPressed(_ sender: UIButton) {
        if showingIndex != sender.tag {
            if sender.tag == 0
            {
                viewOfBio.isHidden = false
                viewOfPhoto.isHidden = true
                viewOFVideo.isHidden = true
            }
            else if sender.tag == 1
            {
                
                viewOfBio.isHidden = true
                viewOfPhoto.isHidden = false
                viewOFVideo.isHidden = true
                
                
            }  else if sender.tag == 2 {
                
                viewOfBio.isHidden = true
                viewOfPhoto.isHidden = true
                viewOFVideo.isHidden = false
                
                
                
            }
            showingIndex = sender.tag
            let startVC = viewControllerAtIndex(tempIndex: sender.tag)
            _ = startVC.view
            pageVC?.setViewControllers([startVC], direction:(showingIndex == 3) ? .reverse : .forward, animated: true, completion: nil)
        }
    }

    func viewControllerAtIndex(tempIndex: Int) -> UIViewController {
        
        if tempIndex == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EAInfoVC") as! EAInfoVC
            vc.clubInfo = self.club
            vc.index = 0
            return vc
        }else if tempIndex == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EAPhotoVC" ) as! EAPhotoVC
            vc.clubPhoto = self.club
            vc.index = 1
            return vc
        }
       else  {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EAVideoVC" ) as! EAVideoVC
            vc.index = 2
            vc.clubVideo = self.club

            return vc
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
