//
//  SecondViewController.swift
//  Lab1
//
//  Created by mac on 2019/2/4.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func launchWebsite(_ sender: Any) {
        if(UIApplication.shared.canOpenURL(URL(string: "safari://")!)){
            UIApplication.shared.open(URL(string: "https://www.chinahighlights.com/travelguide/festivals/red-envelop.htm")!, options: [:], completionHandler: nil)
        }else {
            if(UIApplication.shared.canOpenURL(URL(string: "googlechrome://")!)){
                UIApplication.shared.open(URL(string: "https://www.chinahighlights.com/travelguide/festivals/red-envelop.htm")!, options: [:], completionHandler: nil)
        } else {
                UIApplication.shared.open(URL(string: "https://www.chinahighlights.com/travelguide/festivals/red-envelop.htm")!, options: [:], completionHandler: nil)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

