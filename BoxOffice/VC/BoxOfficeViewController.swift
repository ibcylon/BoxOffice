//
//  ViewController.swift
//  BoxOffice
//
//  Created by Kanghos on 2021/11/02.
//

import UIKit
import RealmSwift

class BoxOfficeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    //Realm 객체
    let localRealm = try! Realm()
    var tasks : Results<BoxOfficeModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tasks = localRealm.objects(BoxOfficeModel.self)
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        searchButton.addTarget(self, action: #selector(retrieveBoxOffice), for: .touchUpInside)
    }
    
    @objc func retrieveBoxOffice(){
        
        MovieAPIManager.shared.fetchBoxOfficeData(targetDt: "20210401") { code, json in
           
            switch code {
            case 200:
                print(json)
               // for i in json[]
               // self.translateText = json["message"]["result"]["translatedText"].stringValue
            case 400:
                print(json)
               // self.translateText = json["errorMessage"].stringValue
            default :
                print("ERROR")
            }
        }
        
    }

}

extension BoxOfficeViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tasks[indexPath.row]
        cell.releaseDate.text = "\(row.releaseDate)"
        cell.titleLabel.text = row.title
        cell.rankLabel.text = "\(row.rank)"
        
        return cell
    }
    
    
}

