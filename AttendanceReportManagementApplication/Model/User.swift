//
//  User.swift
//  AttendanceReportManagementApplication
//
//  Created by 濱田広毅 on 2023/05/17.
//

import Foundation
import SQLite3
import UIKit
import FirebaseStorage
import FirebaseFirestore

class User{
    
    private var db: OpaquePointer?
    private var image_path = String()
    private let db_file: String = "Application.db"
    
    public func CreateUsersTable(){
        OpenDB()
        let create_table = "CREATE TABLE User (id integer primary key autoincrement, name string, email string, password string, image_path string)"
        
        if sqlite3_exec(db, create_table, nil, nil, nil) != SQLITE_OK{
            print("テーブルの作成に失敗しました")
        }else{
            print("テーブルが作成されました")
        }
    }
    
    private func OpenDB(){
        
        let file_url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.db_file)
        
        if sqlite3_open(file_url.path, &db) != SQLITE_OK{
            print("DBファイルが見つからず、生成もできません")
        }else{
            print("DBファイルが生成できました(対象のパスにDBファイルが存在しました。)")
            print(file_url.path)
        }
    }
        
    func insert(name: String, email: String, password: String){
        OpenDB()
        let default_image = UIImage(named: "default_image")
        let date = NSDate()
        let currentTimeStampInSecond = UInt64(floor(date.timeIntervalSince1970 * 1000))
        let storageRef = Storage.storage().reference().child("default_image").child("\(currentTimeStampInSecond).jpg")
        let metaData = StorageMetadata()
        var stmt: OpaquePointer?
        
        metaData.contentType = "default_image/jpg"
        if let uploadData = default_image?.jpegData(compressionQuality: 0.01){
            storageRef.putData(uploadData, metadata: metaData){(metaData, error) in
                if error != nil{
                    
                    print("error: \(error?.localizedDescription)")
                }
                storageRef.downloadURL(completion: {(url, error) in
                    if error != nil{
                        print("error: \(error?.localizedDescription)")
                    }
                    self.image_path = url!.absoluteString
                    print("url: \(url!.absoluteString)")
                    
                    let query_string = "INSERT INTO User (name, email, password ,image_path) VALUES('\(name)', '\(email)', '\(password)', '\(self.image_path)')"
                    // クリエの準備をする
                    if sqlite3_prepare(self.db, query_string, -1, &stmt, nil) != SQLITE_OK{
                        let error_message = String(cString: sqlite3_errmsg(self.db)!)
                        print("error preparing insert: \(error_message)")
                        return
                    }
                    
                    // クリエを実行する
                    if sqlite3_step(stmt) != SQLITE_DONE{
                        let error_message = String(cString: sqlite3_errmsg(self.db)!)
                        print("failure inserting hero: \(error_message)")
                        return
                    }
                    
                    print("データが登録されました")
                    
                })
            }
        }
    }
}
