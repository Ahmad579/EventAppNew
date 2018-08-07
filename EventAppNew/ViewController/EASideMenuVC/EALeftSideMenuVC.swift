//
//  EALeftSideMenuVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 12/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class EALeftSideMenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnFavourite_PRessed(_ sender: UIButton) {
        WAShareHelper.goToHomeController(vcIdentifier: "EAFavouriteVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "EALeftSideMenuVC", rightMenuIdentifier: "EARightSideMenu")

    }
    
    @IBAction func btnClub_Pressed(_ sender: UIButton) {
        WAShareHelper.goToHomeController(vcIdentifier: "WAClubVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "EALeftSideMenuVC", rightMenuIdentifier: "EARightSideMenu")

        
        
    }
    
    @IBAction func btnEvent_Pressed(_ sender: UIButton) {
        WAShareHelper.goToHomeController(vcIdentifier: "EAEventHomeVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "EALeftSideMenuVC", rightMenuIdentifier: "EARightSideMenu")
    }
    
    @IBAction func btnBlog_Pressed(_ sender: UIButton) {
        WAShareHelper.goToHomeController(vcIdentifier: "WABlogVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "EALeftSideMenuVC", rightMenuIdentifier: "EARightSideMenu")

        
    }
    
    @IBAction func btnSetting_Pressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        UserDefaults.standard.set(nil  , forKey : "email")
        UserDefaults.standard.set(nil  , forKey : "password")
        UserDefaults.standard.set(0  , forKey : "id")
        localUserData = nil
        UIApplication.shared.keyWindow?.rootViewController = vc
//        WAShareHelper.goToHomeController(vcIdentifier: "EASettingVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "EALeftSideMenuVC", rightMenuIdentifier: "EARightSideMenu")

        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
