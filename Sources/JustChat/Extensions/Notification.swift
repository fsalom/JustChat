//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 13/12/22.
//

import UIKit

extension Notification {

    var getKeyBoardHeight: CGFloat {
        let userInfo: NSDictionary = self.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        return keyboardRectangle.height
    }
}
