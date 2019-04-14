//
//  AlertController.swift
//
//
//  Created by mac on 2019/2/17.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit

class AlertController
{
    static func showAlert(inViewController: UIViewController, title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
        
    }
}
