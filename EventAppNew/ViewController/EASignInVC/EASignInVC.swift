//
//  EASignInVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol Routable {
    associatedtype StoryboardIdentifier: RawRepresentable
}


class EASignInVC: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    private var testPrivate : Int = 0
    fileprivate var testFilePrivate : Int = 0

    let size = CGSize(width: 60, height: 60)
      private var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.setLeftPaddingPoints(10)
        txtPass.setLeftPaddingPoints(10)
//        txtEmail.text = "ahmaddurranitrg@gmail.com"
//        txtPass.text = "123456789"
        print(testPrivate)
        print(testFilePrivate)


    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRegister_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EASignUpVC") as? EASignUpVC
        self.navigationController?.pushViewController(vc!, animated: true)

//        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "EASignUpVC") as? EASignUpVC  else
//        {
//            return assertionFailure("Invalid controller for storyboard \(storyboard!).")
//
//        }
//        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func btnForgetPassword_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EAForgotPasswordVC") as? EAForgotPasswordVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    @IBAction func btnLogin_Pressed(_ sender: UIButton) {
        if isViewPassedSignValidation() {
            let loginParam =    [ "email"         : txtEmail.text!,
                                  "password"      : txtPass.text! ,
                                ] as [String : Any]

        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)

        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: LOGIN, isLoaderShow: true, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            
            self.stopAnimating()

            if responseObj.success == true {
                localUserData = responseObj.data
                UserDefaults.standard.set(self.txtEmail.text! , forKey: "email")
                UserDefaults.standard.set(self.txtPass.text! , forKey: "password")
                UserDefaults.standard.set(localUserData.user_id , forKey: "id")


                WAShareHelper.goToHomeController(vcIdentifier: "EAEventHomeVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "EALeftSideMenuVC", rightMenuIdentifier: "EARightSideMenu")

            }
            else {
                self.showAlert(title: "Event", message: responseObj.message!, controller: self)
            }
        }, fail: { (error) in
            self.stopAnimating()

        }, showHUD: true)
        
        }
        
        
    }

    func isViewPassedSignValidation() -> Bool
    {
        
        var validInput = true
        if self.txtEmail.text!.count < kUserNameRequiredLength {
            validInput = false
            self.txtEmail.becomeFirstResponder()
            self.showAlert(title: "Event", message: kValidationMessageMissingInput, controller: self)
            
        }
            
        else  if !WAShareHelper.isValidEmail(email: txtEmail.text!) {
            validInput = false
            
            self.txtEmail.becomeFirstResponder()
            
            self.showAlert(title: "Event", message: kValidationEmailInvalidInput, controller: self)
            
            
        }
            
            
        else if   self.txtPass.text!.count ==  0 {
            validInput = false
            self.showAlert(title: "Event", message: KValidationPassword, controller: self)
            
        }
        else if   self.txtPass.text!.count < kPasswordRequiredLength {
            validInput = false
            self.txtPass.becomeFirstResponder()
            self.showAlert(title: "Event", message: KValidationPassword, controller: self)
            
        }
        return validInput
    }

    
}

protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}


extension Routable where Self: UIViewController, StoryboardIdentifier.RawValue == String {
    
    func show(storyboard: StoryboardIdentifier) {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        
        guard let controller = storyboard.instantiateInitialViewController()else
        {
            return assertionFailure("Invalid controller for storyboard \(storyboard).")
            
        }
        
        show(controller, sender: self)
    }
}

extension EASignInVC : Routable {
    
    enum StoryboardIdentifier: String {
        case register = "EASignUpVC"
        case home = "More"
        case forgot = "EAForgotPasswordVC"
    }
}

