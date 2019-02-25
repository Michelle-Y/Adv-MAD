//
//  NewVehicleViewController.swift
//  Days Matter
//
//  Created by mac on 2019/2/17.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit

class NewDateViewController: UIViewController
{

    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var dateTxt: UITextField!
    @IBOutlet weak var bodyStyleTxt: UITextField!
    
    var addDate = Memo()
    var bodyStyle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyStyleTxt.text = bodyStyle
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTapGestureRecognized(_ sender: Any)
    {
        nameTxt.resignFirstResponder()
        dateTxt.resignFirstResponder()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "saveSegue"
        {
            guard let name = nameTxt.text,
            name != "",
            let date = dateTxt.text,
            date != ""
            else
            {

                return
            }
                
            addDate = Memo(bodyType: bodyStyle, name: name, date: date)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
