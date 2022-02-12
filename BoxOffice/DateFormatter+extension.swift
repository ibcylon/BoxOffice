//
//  DateFormatter+extension.swift
//  BoxOffice
//
//  Created by Kanghos on 2022/02/12.
//

import Foundation


extension DateFormatter {
    static func MyFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter
    }
}
