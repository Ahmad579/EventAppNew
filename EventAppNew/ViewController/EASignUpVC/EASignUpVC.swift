//
//  EASignUpVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EASignUpVC: UIViewController  , NVActivityIndicatorViewable {
    @IBOutlet weak var txtUserName: UITextField!

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    let size = CGSize(width: 60, height: 60)

    override func viewDidLoad() {
        super.viewDidLoad()
        txtUserName.setLeftPaddingPoints(10)
        txtEmail.setLeftPaddingPoints(10)
        txtPass.setLeftPaddingPoints(10)
        
//        txtUserName.text = "Ahmad"
//        txtEmail.text = "ahmaddurranitrg@gmail.com"
//        txtPass.text = "123456789"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnLogin_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRegister_Pressed(_ sender: UIButton) {
        let errorMessage = validateRegisterFields()
        
        if errorMessage == "" {

        let loginParam =   [ "email"         : txtEmail.text!,
                            "password"      : txtPass.text! ,
                            "fullname"      : txtUserName.text!,
                            "device"        : "ios" ,
                            "device_id"     : "923023293290322332"
                            ] as [String : Any]

        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)

        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: SIGNUP, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            self.stopAnimating()

            if responseObj.success == true {
                localUserData = responseObj.data
//                WAShareHelper.goToHomeController(vcIdentifier: "EAEventHomeVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "EALeftSideMenuVC", rightMenuIdentifier: "EARightSideMenu")
                UserDefaults.standard.set(self.txtEmail.text! , forKey: "email")
                UserDefaults.standard.set(self.txtPass.text! , forKey: "password")
                UserDefaults.standard.set(localUserData.user_id , forKey: "id")

                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "EASignUpFilterVC") as? EASignUpFilterVC
               self.navigationController?.pushViewController(vc!, animated: true)


            }
            else {
                self.showAlert(title: "Event App", message: responseObj.message!, controller: self)
            }
        }, fail: { (error) in
            self.stopAnimating()

        }, showHUD: true)
        } else {

            self.showAlert(title: "Event App", message: errorMessage, controller: self)

        }
        
        
        
    }
    
    func isValidName(name: String) -> Bool {
        let decimalCharacters = NSCharacterSet.decimalDigits
        let decimalRange = name.rangeOfCharacter(from: decimalCharacters, options: String.CompareOptions.numeric, range: nil)
        
        if decimalRange != nil {
            return false
        }
        return true
    }
    
    //MARK: fields validation methods
    private func validateRegisterFields() -> String {
        

        let fullName = txtUserName.text!
        let userEmail = txtEmail.text!
        let userPassword = txtPass.text!
        
        var message = ""
        
        //        let str = userEmail
        if (fullName != "") {
            if (isValidName(name: fullName) == false) {
                message = "Full Name must be alphabet characters.\n"
            }
        } else {
            message += "Enter Full Name.\n"
        }
        
        if WAShareHelper.isValidEmail(email: userEmail) == false {
            message += "Enter valid email address.\n"
        }
        
        
        if ((userPassword.count) >= kPasswordRequiredLength) {
            if userPassword.contains(" ") == true {
                message += "Password cannot contain spaces.\n"
            }
        } else {
            message += "Use a password that is 5 characters long or more.\n"
        }
        
        
       
        
        return message
    }

    
}
