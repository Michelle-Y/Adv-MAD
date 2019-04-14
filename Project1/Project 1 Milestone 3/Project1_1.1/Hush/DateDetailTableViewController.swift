//
//  DateDetailTableViewController.swift
//  Days Matter
//
//  Created by mac on 2019/2/17.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit

class DateDetailTableViewController: UITableViewController {

    @IBOutlet weak var output: UITextView!
    @IBOutlet weak var keycompare: UITextField!
    var cipher = CaesarCipher()
    var message = ""
    var password = String()
    var usedfor = String()

    
    @IBOutlet weak var vusedfor: UILabel!
    @IBOutlet weak var vpass: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBAction func shiftAction(_ sender: UITextField) {
        self.message = vpass.text!
        if (sender.text == "") {
            return
        }
//        else if (keycompare.text == Memo.key){
        else{
        let characterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz")
        if let _ = sender.text!.rangeOfCharacter(from: characterSet, options: .caseInsensitive) {
            return
        }
        let val:Int? = Int(sender.text!)!
        cipher.setShift(val!)
        print("setShiftkey", val);
        }
    }
    @IBAction func buttonAction(_ sender: UIButton) {
        if(self.message == "") {
            return;
            
        }
        else{
        var res = "";
            res = cipher.Decrypt(self.message);
        output.text = res;
            print("output is ",res);
        }
    }
    
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
        vusedfor.text = usedfor
        vpass.text = password
//        decryptLabel.text = result
    }
}
