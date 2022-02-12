//
//  TranslatedAPIManager.swift
//  Network sessac
//
//  Created by Kanghos on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

final class MovieAPIManager {
    
    //싱글톤 패턴
    static let shared = MovieAPIManager()
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func fetchBoxOfficeData(targetDt:String, result: @escaping CompletionHandler ) {
        
        let parameter = [
            "key":APIKey.MOVIE,
            "targetDt":targetDt
        ]
        AF.request(Endpoint.movieURL, method: .get, parameters: parameter).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
               
                print("JSON: \(json["boxOfficeResult"]["dailyBoxOfficeList"])")
                
                let code = response.response?.statusCode ?? 500
                result(code, json)
                
                // self.targetTextView.text = json["message"]["result"]["translatedText"].stringValue
            case .failure(let error):
                print(error)
            }
        }
    }
}
