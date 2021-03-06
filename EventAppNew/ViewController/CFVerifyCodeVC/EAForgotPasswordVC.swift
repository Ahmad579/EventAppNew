//
//  EAForgotPasswordVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 20/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EAForgotPasswordVC: UIViewController  , NVActivityIndicatorViewable {
    @IBOutlet weak var txtEmail :UITextField!
    let size = CGSize(width: 60, height: 60)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnForgotPass_Pressed(_ sender: UIButton) {
        
        let loginParam =  [ "email"                      : txtEmail.text!,
            ] as [String : Any]
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: FORGOTPASSWORD, isLoaderShow: true, serviceType: "Forgot Password", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            self.stopAnimating()
            
            if responseObj.success == true {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CFVerifyCodeVC") as? CFVerifyCodeVC
                vc?.email = self.txtEmail.text!
                self.navigationController?.pushViewController(vc!, animated: true)
            } else {
                //
                self.showAlert(title: "", message: responseObj.message! , controller: self)
                
                
            }
            
        }, fail: { (error) in
            self.stopAnimating()
            self.showAlert(title: "PFG", message: error.description, controller: self)
        }, showHUD: true)
        
    }

}
