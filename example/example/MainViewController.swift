//
//  ViewController.swift
//  example
//
//  Created by Fernando Salom Carratala on 10/10/22.
//

import UIKit
import JustChat

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: Any) {
        let justChatVC = JustChatViewController.getStoryboardVC() as! JustChatViewController

        navigationController?.pushViewController(justChatVC, animated: true)
    }
}
