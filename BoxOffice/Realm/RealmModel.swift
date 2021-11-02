//
//  RealmModel.swift
//  BoxOffice
//
//  Created by Kanghos on 2021/11/03.
//

import Foundation
import RealmSwift

class BoxOfficeModel: Object {
    @Persisted var title: String
    @Persisted var rank: Int
    @Persisted var releaseDate = Date()
    @Persisted(primaryKey: true) var targetDt:String
    convenience init(title:String, rank:Int, releaseDate:Date, targetDt:String){
        
        self.init()
        
        self.title = title
        self.rank = rank
        self.releaseDate = releaseDate
        self.targetDt = targetDt
    }
}
