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
    @Persisted var releaseDate: Date
    
    convenience init(title:String, rank:Int, releaseDate:Date){
        
        self.init()
        
        self.title = title
        self.rank = rank
        self.releaseDate = releaseDate
    }
}
