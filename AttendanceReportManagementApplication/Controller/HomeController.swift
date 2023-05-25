//
//  HomeController.swift
//  AttendanceReportManagementApplication
//
//  Created by 濱田広毅 on 2023/05/18.
//

import UIKit
import GRDB

class HomeController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    private var userData = GetUserData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userData.getUserData(userName: &nameLabel.text!, userEmail: &emailLabel.text!)
    }
    

}
