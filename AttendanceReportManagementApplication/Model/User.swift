//
//  User.swift
//  AttendanceReportManagementApplication
//
//  Created by 濱田広毅 on 2023/05/17.
//

import Foundation
import GRDB

class User: Record{
    
    var id: Int64?
    var name: String
    var email: String
    var password: String
    
    // テーブル名
    override static var databaseTableName: String{
        return "users"
    }
    
    enum Columns{
        static let id = Column("id")
        static let name = Column("name")
        static let email = Column("email")
        static let password = Column("password")
    }
    
    init(name: String, email: String, password: String){
        self.name = name
        self.email = email
        self.password = password
        super.init()
    }
    
    required init(row: Row){
        self.id = row["id"]
        self.name = row["name"]
        self.email = row["email"]
        self.password = row["password"]
        try! super.init(row: row)
    }
    
    override func encode(to container: inout PersistenceContainer) {
        container["id"] = self.id
        container["name"] = self.name
        container["email"] = self.email
        container["password"] = self.password
    }

    func didInsert(with rowID: Int64, for column: String?){
        self.id = rowID
    }
    
}
