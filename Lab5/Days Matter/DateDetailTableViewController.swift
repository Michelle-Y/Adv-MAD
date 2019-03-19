//
//  DateDetailTableViewController.swift
//  Days Matter
//
//  Created by mac on 2019/2/17.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit

class DateDetailTableViewController: UITableViewController {

    var name = String()
    var date = String()
    
    @IBOutlet weak var vdate: UILabel!
    @IBOutlet weak var vname: UILabel!
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        vdate.text = date
        vname.text = name
    }
}
