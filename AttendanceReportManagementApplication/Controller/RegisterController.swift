//
//  RegisterController.swift
//  AttendanceReportManagementApplication
//
//  Created by 濱田広毅 on 2023/05/17.
//

import UIKit

class RegisterController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var database = DatabaseManager()
    var users_table = User()
    var uuid = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        database.OpenDB()
        users_table.CreateUsersTable()
    }
    
    
    @IBAction func registerButton(_ sender: Any) {
        
        do{
            users_table.insert(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeController
            vc.loginName = nameTextField.text!
            self.present(vc, animated: true, completion: nil)
            print("登録できました")
        }catch{
            print("登録できませんでした")
        }
    }
    
}
