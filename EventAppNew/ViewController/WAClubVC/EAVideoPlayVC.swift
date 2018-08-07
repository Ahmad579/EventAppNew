//
//  EAVideoPlayVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 19/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EAVideoPlayVC: UIViewController , UIWebViewDelegate , NVActivityIndicatorViewable {
    var idOfVideo : String?
    var linkOfVide : String?
    @IBOutlet weak var myWebView: UIWebView!
    let size = CGSize(width: 60, height: 60)

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.youtube.com/watch?v=\(idOfVideo!)")
        myWebView.delegate = self
        myWebView.loadRequest(URLRequest(url: url!))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)

    }
  
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.stopAnimating()

    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.stopAnimating()

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
