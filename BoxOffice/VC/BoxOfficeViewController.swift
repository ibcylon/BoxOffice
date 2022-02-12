//
//  ViewController.swift
//  BoxOffice
//
//  Created by Kanghos on 2021/11/02.
//

import UIKit
import RealmSwift
import SwiftUI

class BoxOfficeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter.MyFormatter()
    //Realm 객체
    let localRealm = try! Realm()
    var tasks : Results<BoxOfficeModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tasks = localRealm.objects(BoxOfficeModel.self)
        
        setDatePicker()
        
        searchTextField.inputView = datePicker
    }
    
    func setDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker){
        
        searchTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        //boxOfficeDate가 입력값과 동일하면 API 안타게 체크
        searchButton.addTarget(self, action: #selector(retrieveBoxOffice), for: .touchUpInside)
    }
    
    @objc func retrieveBoxOffice(){
        var inputDate: String
        
        guard let text = searchTextField.text else { return }
        
        if text.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            guard let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else { return }
            inputDate = dateFormatter.string(from: lastWeek)
        } else {
            inputDate = text
        }
        
        MovieAPIManager.shared.fetchBoxOfficeData(targetDt: inputDate) { code, json in
           
            switch code {
            case 200:
                try! self.localRealm.write {
                    self.localRealm.deleteAll()
                }
                
                print(json)
                
                let movieList = json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue
                
                for movie in movieList {
                    
                    let rank = movie["rank"].stringValue
                    let title = movie["movieNm"].stringValue
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let releaseDate:Date = dateFormatter.date(from: movie["openDt"].stringValue)!
                    
                    print(rank, title)
                    let task = BoxOfficeModel(title: title, rank: Int(rank)!, releaseDate: releaseDate, targetDt: self.searchTextField.text!)

                    try! self.localRealm.write {
                        self.localRealm.add(task)
                        self.tableView.reloadData()
                    }
                }
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

