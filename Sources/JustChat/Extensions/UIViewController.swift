//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 18/10/22.
//

import UIKit

public extension UIViewController {
    static func getStoryboardVC() -> UIViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle.module)
        return storyboard.instantiateInitialViewController()!
    }
}
