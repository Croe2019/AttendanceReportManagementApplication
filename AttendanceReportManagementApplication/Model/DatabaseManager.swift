//
//  DatabaseManager.swift
//  AttendanceReportManagementApplication
//
//  Created by 濱田広毅 on 2023/05/17.
//

import Foundation
import SQLite3

class DatabaseManager{
    
    private var db: OpaquePointer?
    private let db_file: String = "Application.db"
    
    public func OpenDB(){
        let file_url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.db_file)
        if sqlite3_open(file_url.path, &db) != SQLITE_OK{
            print("DBファイルが見つからず、生成もできません")
        }else{
            print("DBファイルが生成できました（対象のパスにDBファイルが存在しました）")
            //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        }
    }
}
