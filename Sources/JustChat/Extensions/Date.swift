//
//  Date.swift
//  
//
//  Created by Pablo Ceacero on 22/11/22.
//

import Foundation

extension Date {
    func toString(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
