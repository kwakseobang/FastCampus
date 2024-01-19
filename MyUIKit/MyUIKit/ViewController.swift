//
//  ViewController.swift
//  MyUIKit
//
//  Created by 곽서방 on 1/17/24.
//

import UIKit

protocol AdminDelegate {  //위임자
    func doTask()
}

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    let cellData = ["HI","my","name is","kwakmunsu"]
    var admin: Admin?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.backgroundColor = .cyan
        myTableView.delegate = self //위임을 받은것.
        myTableView.dataSource = self
        admin?.delegate = self
        admin?.delegate?.doTask()
    }


}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = self.cellData[indexPath.row]
        return cell
    }
    
    
}
extension ViewController: UITableViewDelegate {
    
}

extension ViewController: AdminDelegate {
    func doTask() {
        print("나 지금 델리게이트 배우고 있어....")
    }
    
}
struct Admin {
    var delegate: AdminDelegate?
}
