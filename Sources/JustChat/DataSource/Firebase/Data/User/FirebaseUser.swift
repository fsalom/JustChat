//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 28/11/22.
//

import Foundation

class FirebaseUser: UserProtocol {
    init(id: String, chatsIDs: [String], profilePhotoURL: String, name: String) {
        self.id = id
        self.chatsIDs = chatsIDs
        self.profilePhotoURL = profilePhotoURL
        self.name = name
    }
    let id: String
    let chatsIDs: [String]
    let profilePhotoURL: String
    let name: String
}
