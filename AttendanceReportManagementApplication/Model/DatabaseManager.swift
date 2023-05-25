//
//  DatabaseManager.swift
//  AttendanceReportManagementApplication
//
//  Created by 濱田広毅 on 2023/05/17.
//

import Foundation
import GRDB

class DatabaseManager{
    
    let databaseFile: String!
    
    
    init(){
        databaseFile = NSHomeDirectory() + "/Documents/" + "Application.sqlite"
        print(databaseFile)
    }
    
    /*
     データベースファイルをコピーする処理
     マスターデータファイルをアプリ実行時のディレクトリにコピーする
     */
    public func createDatabase(){
        let fileManager = FileManager.default
        guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let finalDatabaseURL = documentsUrl.appendingPathComponent("Application.sqlite")
        do {
            if !fileManager.fileExists(atPath: finalDatabaseURL.path) {
                print("DB does not exist in documents folder")
                if let dbFilePath = Bundle.main.path(forResource: "Application", ofType: "sqlite") {
                    try fileManager.copyItem(atPath: dbFilePath, toPath: finalDatabaseURL.path)
                } else {
                    print("Uh oh - foo.db is not in the app bundle")
                }
            } else {
                print("Database file found at path: \(finalDatabaseURL.path)")
            }
        } catch {
            print("Unable to copy foo.db: \(error)")
        }
    }
    
    private func migration(){
        
        let queue = try! DatabaseQueue(path: self.databaseFile)
        var migrator = DatabaseMigrator()
        migrator.registerMigration("v1"){ (db) in
            // usersテーブルが存在しなければテーブルを作成
            
            try db.create(table: User.databaseTableName) { t in
                t.column("id", .integer).primaryKey(onConflict: .ignore, autoincrement: true)
                t.column("name", .text).notNull()
                t.column("email", .text).notNull()
                t.column("password", .text).notNull()
            }
        }
        
       // try! migrator.migrate(queue)
    }
    
    // ユーザー登録処理
    public func userInsert(name: String, email: String, password: String){
        
        let queue = try! DatabaseQueue(path: self.databaseFile)
        migration()
        
        
        try! queue.write{(db) in
            do{
                var user = try User(name: name, email: email, password: password)
                // ここから再開
                try! user.insert(db)
                print(user.id)
                print("登録に成功しました")
            }catch{
                print("登録に失敗しました")
            }
        }
    }
    
}
