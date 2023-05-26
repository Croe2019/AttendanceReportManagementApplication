//
//  LoginController.swift
//  AttendanceReportManagementApplication
//
//  Created by 濱田広毅 on 2023/05/17.
//

import UIKit
import SQLite3

class LoginController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    fileprivate var db:OpaquePointer?
    fileprivate var login_data: [(loginName: String, loginPassword: String)] = []
    fileprivate let db_file: String = "Application.db"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GetUserData()
    }
    
    // このコントローラーはログイン処理だけなのでそのまま記述
    @IBAction func loginButton(_ sender: Any) {
       
        if nameTextField.text == "" || passwordTextField.text == ""{
            print("メールアドレス、パスワードのいずれかが入力されていません")
            return
        }
        
        login_data.forEach{ value in
            if(nameTextField.text == value.loginName && passwordTextField.text == value.loginPassword){
                print("ログインボタンを押しました")
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeController
                vc.loginName = nameTextField.text!
                self.present(vc, animated: true, completion: nil)
            }else{
                
                return
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeController" {
            
        }
    }
}

// ログインの処理はこのファイルだけで行う 後でクラス化する
extension LoginController{
    private func OpenDB(){
        let file_url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.db_file)
        if sqlite3_open(file_url.path, &db) != SQLITE_OK{
            print("DBファイルが見つからず、生成もできません")
        }else{
            print("DBファイルが生成できました（対象のパスにDBファイルが存在しました）")
            print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        }
    }
    
    // ここから再開
    public func GetUserData(){
        // DBにのファイルを開く
        OpenDB()
        let sql = "select * from User"
        var stmt:OpaquePointer?
        
        // クリエを準備
        if sqlite3_prepare(db, sql, -1, &stmt, nil) != SQLITE_OK{
            let error_message = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(error_message)")
            return
        }
        
        // クリエを実行し、取得したレコードをループする
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let password = String(cString: sqlite3_column_text(stmt, 3))
            login_data.append((name, password))
        }
    }
}
