//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 18/10/22.
//

import UIKit

public extension UIViewController {
    static func getStoryboardVC<T: UIViewController>(_ type: T.Type) -> T {
        let storyboard = UIStoryboard(name: String(describing: type), bundle: Bundle.module)
        return storyboard.instantiateInitialViewController()!
    }
}
