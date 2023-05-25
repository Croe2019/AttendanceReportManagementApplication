//
//  GetUserData.swift
//  AttendanceReportManagementApplication
//
//  Created by 濱田広毅 on 2023/05/24.
//

import Foundation
import GRDB

class GetUserData{
    
    public func getUserData(userName: inout String, userEmail: inout String){
        
        let databaseFile: String!
        databaseFile = NSHomeDirectory() + "/Documents/" + "Application.sqlite"
        print(databaseFile)
        let quere = try! DatabaseQueue(path: databaseFile)
        
        try! quere.inDatabase{(db) in
            let allData = try! User.fetchAll(db)
            let allId = try! User.select(User.Columns.id)
                .asRequest(of: Int.self)
                .fetchAll(db)
            // 一度すべてのユーザーを取得
            let name = try! User.select(User.Columns.name)
                .asRequest(of: String.self)
                .fetchAll(db)
            let email = try! User.select(User.Columns.email)
                .asRequest(of: String.self)
                .fetchAll(db)
            
            for i in 0..<allData.count{
                
                // とりあえず開発を楽にするためこのように記述 後で任意のユーザーidを取れるようにする
                let id = try! User.select(User.Columns.id)
                    .asRequest(of: Int.self)
                    .fetchOne(db)
                if id == allId[i]{
                    // ログインしているユーザーidが一致していればユーザー情報を表示
                    userName = name[i]
                    userEmail = email[i]
                    print("取得したid: \(id)")
                }
            }
        }
    }
}
