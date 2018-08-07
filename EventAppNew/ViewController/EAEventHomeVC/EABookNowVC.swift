//
//  EABookNowVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class EABookNowVC: UIViewController {

    @IBOutlet weak var imgOfEvent: UIImageView!
    @IBOutlet weak var lblTotalCost: UILabel!
    @IBOutlet weak var lblEventNme: UILabel!
    @IBOutlet weak var txtTicketHolderName: UITextField!
    
    @IBOutlet weak var lblNumberOfTicket: UILabel!
    var totalPriceOfItem : String?
    var countOfTicket = 0

    var eventObj : EventObjectDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageUrl = self.eventObj?.picture
        WAShareHelper.loadImage(urlstring: (imageUrl!) , imageView: self.imgOfEvent, placeHolder: "placeholder")

        // Do any additional setup after loading the view.
    }

    @IBAction func btnIncrease_Ticket(_ sender: UIButton) {
        
        let priceOfTicket = self.lblTotalCost.text?.replacingOccurrences(of: "$", with: "")
        countOfTicket += 1
        self.lblNumberOfTicket.text = "\(countOfTicket)"
        totalPriceOfItem = eventObj?.price_ticket
        let price : Int = Int(priceOfTicket!)! + Int(totalPriceOfItem!)!
        self.lblTotalCost.text = "$\(price)"

    }
    
    @IBAction func btnDecrease_Ticket(_ sender: UIButton) {
        
        let priceOfTicket = self.lblTotalCost.text?.replacingOccurrences(of: "$", with: "")
        
        let checkTheTicketPrice = Int(priceOfTicket!)
        if checkTheTicketPrice == 0 {
            
        } else {
            countOfTicket -= 1
            self.lblNumberOfTicket.text = "\(countOfTicket)"
            
            totalPriceOfItem = eventObj?.price_ticket
            let price : Int = Int(priceOfTicket!)! - Int(totalPriceOfItem!)!
            self.lblTotalCost.text = "$\(price)"
        }
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBookNow_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EABookingConfirmVC") as? EABookingConfirmVC
        
        let priceOfTicket = self.lblTotalCost.text?.replacingOccurrences(of: "$", with: "")
        
        let checkTheTicketPrice = Int(priceOfTicket!)
        if checkTheTicketPrice == 0 {
            self.showAlert(title: "Event", message: "You must select the Ticket", controller: self)
        } else {
            if txtTicketHolderName.text?.count == 0 {
                self.showAlert(title: "Event", message: "Please enter the ticket holder name", controller: self)

            } else {
                let totalTicket = self.lblNumberOfTicket.text
                vc?.ticketHolderName = self.txtTicketHolderName.text!
                vc?.totalCost = priceOfTicket
                vc?.totalTicket = totalTicket
                vc?.eventDetailObj = self.eventObj
                self.navigationController?.pushViewController(vc!, animated: true)
            }
           
        }

       
        
    }

}
