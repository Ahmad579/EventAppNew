//
//  WACommentVC.swift
//  EventAppNew
//
//  Created by Ahmed Durrani on 20/07/2018.
//  Copyright © 2018 Tech Ease Solution. All rights reserved.
//

import UIKit

class WACommentVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    var  commentBlog : BlogObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        tblView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WACommentVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  self.commentBlog?.comment?.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Club."
            noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.commentBlog?.comment?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell
        cell?.nameOfUser.text = self.commentBlog?.comment![indexPath.row].fullname
        cell?.commentOfUser.text = self.commentBlog?.comment![indexPath.row].comment
        cell?.lblTime.text = self.commentBlog?.comment![indexPath.row].created_at
        return cell!
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EAContainerVC") as? EAContainerVC
//        //        vc?.club = self.responseObj?.clubList![indexPath.row]
//        vc?.club = self.responseObj?.clubList![indexPath.row]
//
//
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
}
