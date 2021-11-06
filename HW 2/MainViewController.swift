//
//  MainViewController.swift
//  HW 2
//
//  Created by Андрей Соболев on 05.11.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import UIKit

protocol SettingViewControllerDelegate {
    func setProtoColor(_ color: UIColor)
}

class MainViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingViewController
        else { return }
        
        settingVC.delegate = self
        settingVC.sendColor = view.backgroundColor
    }
}

extension MainViewController: SettingViewControllerDelegate {
    func setProtoColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
