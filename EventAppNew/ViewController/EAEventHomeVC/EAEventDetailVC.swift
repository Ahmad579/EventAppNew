//
//  EAEventDetailVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EAEventDetailVC: UIViewController  , NVActivityIndicatorViewable{

    @IBOutlet weak var imgOfEvent: UIImageView!
    
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblCalender: UILabel!

    @IBOutlet weak var lblDesciption: UILabel!
    
    @IBOutlet weak var lblNumberOfTicketAvailable: UILabel!
    @IBOutlet weak var lblPriceOfTicket: UILabel!
    let size = CGSize(width: 60, height: 60)

    var event : EventObjectDetail?
    var responseObj: UserResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTheUI()
        viewByUser()
        // Do any additional setup after loading the view.
    }
    
    
    
    private func viewByUser() {
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        let eventId = event?.eventid
        let loginParam =  [ "event_id"                        : "\(eventId!)"
                          ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: EVENTVIEVED, isLoaderShow: true, serviceType: "Verify Code", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            self.stopAnimating()
            
            if self.responseObj?.success == true {
           
            } else {

                
            }
            
        }, fail: { (error) in
            self.stopAnimating()
            self.showAlert(title: "PFG", message: error.description, controller: self)
        }, showHUD: true)
        
    }
    
    
    private func updateTheUI(){
        let imageUrl = self.event?.picture
        WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: self.imgOfEvent, placeHolder: "placeholder")
        self.lblEventName.text =  self.event?.event_name
        self.lblLocation.text =  self.event?.location
        self.lblCalender.text =  self.event?.date
        self.lblDesciption.text = self.event?.about
        self.lblNumberOfTicketAvailable.text =  self.event?.total_tickets
        self.lblPriceOfTicket.text = self.event?.price_ticket

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnBack_Pressed(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBook_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EABookNowVC") as? EABookNowVC
        vc?.eventObj = event
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }


}
