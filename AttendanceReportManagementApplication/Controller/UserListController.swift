//
//  UserListController.swift
//  AttendanceReportManagementApplication
//
//  Created by 濱田広毅 on 2023/05/25.
//

import UIKit

class UserListController: UIViewController{
    
    
    @IBOutlet weak var userListTableView: UITableView!
    
    var nameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return nameArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        // セルに表示する値を設定する
//        cell.textLabel!.text = nameArray[indexPath.row]
//        return cell
//    }
}
