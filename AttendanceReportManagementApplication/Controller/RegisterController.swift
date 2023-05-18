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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func registerButton(_ sender: Any) {
        
        var databaseManager = DatabaseManager()
        databaseManager.userInsert(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
        let menuController = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuController
        self.present(menuController, animated: true, completion: nil)
    }
    
}
