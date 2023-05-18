//
//  LoginController.swift
//  AttendanceReportManagementApplication
//
//  Created by 濱田広毅 on 2023/05/17.
//

import UIKit
import GRDB

class LoginController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // このコントローラーはログイン処理だけなのでそのまま記述
    @IBAction func loginButton(_ sender: Any) {
        
        let databaseFile: String!
        databaseFile = NSHomeDirectory() + "/Documents/" + "Application.sqlite"
        print(databaseFile)
        let quere = try! DatabaseQueue(path: databaseFile)
        
        try! quere.inDatabase{(db) in
            let allData = try! User.fetchAll(db)
            // 一度すべてのユーザーを取得
            let name = try! User.select(User.Columns.name)
                .asRequest(of: String.self)
                .fetchAll(db)
            let password = try! User.select(User.Columns.password)
                .asRequest(of: String.self)
                .fetchAll(db)
            
            for i in 0..<allData.count{
                if nameTextField.text! == name[i] && passwordTextField.text! == password[i]{
                    let menuController = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuController
                    self.present(menuController, animated: true, completion: nil)
                }
            }
        }
    }
}
