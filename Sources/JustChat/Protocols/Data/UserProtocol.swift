//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 5/12/22.
//

import Foundation

public protocol UserProtocol {
    var id: String { get }
    var chatsIDs: [String] { get }
    var profilePhotoURL: String { get }
    var name: String { get }
}
