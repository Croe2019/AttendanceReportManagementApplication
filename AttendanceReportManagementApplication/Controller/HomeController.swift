//
//  HomeController.swift
//  AttendanceReportManagementApplication
//
//  Created by 濱田広毅 on 2023/05/18.
//

import UIKit
import SQLite3

class HomeController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    fileprivate var db:OpaquePointer?
    fileprivate let db_file: String = "Application.db"
    fileprivate var loginId = [Int]()
    fileprivate var userName = [String]()
    fileprivate var checkName = [String]()
    fileprivate var userEmail = [String]()
    fileprivate var checkEmail = [String]()
    
    public var loginName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       GetUserId()
        
        for i in 0..<loginId.count{
            
            if userName[i] == loginName{
                nameLabel.text = userName[i]
                emailLabel.text = userEmail[i]
            }else{
                // 新規登録の際は画面に初めましての画面を表示させる
            }
        }
    }
    
}

extension HomeController{
    
    private func OpenDB(){
        let file_url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.db_file)
        if sqlite3_open(file_url.path, &db) != SQLITE_OK{
            print("DBファイルが見つからず、生成もできません")
        }else{
            print("DBファイルが生成できました（対象のパスにDBファイルが存在しました）")
            print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        }
    }
    
    public func GetUserId(){
        
        // DBにのファイルを開く
        OpenDB()
        let sql = "select * from User where name = '\(loginName)'"
        var stmt:OpaquePointer?
        
        // クリエを準備
        if sqlite3_prepare(db, sql, -1, &stmt, nil) != SQLITE_OK{
            let error_message = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(error_message)")
            return
        }
        
        // クリエを実行し、取得したレコードをループする
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = Int(bitPattern: sqlite3_column_text(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let email = String(cString: sqlite3_column_text(stmt, 2))
            loginId.append((id))
            userName.append(name)
            checkName.append(name)
            userEmail.append(email)
            checkEmail.append(email)
        }
    }
}
