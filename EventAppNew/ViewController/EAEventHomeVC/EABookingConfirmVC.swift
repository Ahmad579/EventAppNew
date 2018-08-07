//
//  EABookingConfirmVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EABookingConfirmVC: UIViewController , NVActivityIndicatorViewable {

    var ticketHolderName : String?
    var totalTicket : String?
    var totalCost : String?
    
    @IBOutlet weak var countOfTicket: UILabel!
    @IBOutlet weak var txtTicketHolderName: UITextField!
    
    @IBOutlet weak var totalCostOfTicket: UILabel!
    var eventDetailObj : EventObjectDetail?
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTicketHolderName.text = ticketHolderName
        countOfTicket.text = totalTicket
        totalCostOfTicket.text = totalCost

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

    @IBAction func btnDone_Pressed(_ sender: UIButton) {
        
        let event_id = self.eventDetailObj?.eventid
        let loginParam =  [ "event_id"         : "\(event_id!)" ,
                            "name"             :   ticketHolderName! ,
                            "tickets"          :   totalTicket! ,
                            "cost"             :   totalCost!

                            
            ] as [String : Any]
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: TICKETBOOKING, isLoaderShow: true, serviceType: "Product Detail", modelType: UserResponse.self, success: { (response) in
            self.responseObj = (response as! UserResponse)
            self.stopAnimating()
            
            if self.responseObj?.success == true {
                self.showAlertViewWithTitle(title: "Event App", message: (self.responseObj?.message!)!, dismissCompletion: {
                    self.navigationController?.popToRootViewController(animated: true)

                })
               
                
                
            }
            else {
                self.showAlert(title: "", message: (self.responseObj?.message!)!, controller: self)
            }
        }, fail: { (error) in
            self.stopAnimating()
            
        }, showHUD: true)
    }

}
