//
//  ViewController.swift
//  test_task_usplash
//
//  Created by Vasyl Senyshyn on 17.12.2020.
//

import UIKit

class ViewController: UIViewController {

    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.fetchNews()
        
    }


}

