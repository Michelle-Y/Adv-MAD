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
    //bodystyle = type; key=input; hint & usedfor & password = copy
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usedforTxt: UITextField!
    @IBOutlet weak var keyTxt: UITextField!
    @IBOutlet weak var buttonEncrypt: UIButton!
    var addDate = Memo()
    var cipher = CaesarCipher()
    var message = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func messageAction(_ sender: UITextField) {
        self.message = sender.text!
        print(message)
    }
    @IBAction func KeyAction(_ sender: UITextField) {
        if (sender.text == "") {
            return
        }
        else{
        let characterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz")
        if let _ = sender.text!.rangeOfCharacter(from: characterSet, options: .caseInsensitive) {
            return
        }
        let val:Int? = Int(sender.text!)!
        cipher.setShift(val!)
        print("cipher shift ", val);
        }
        
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any)
    {
        passwordTxt.resignFirstResponder()
        usedforTxt.resignFirstResponder()
        keyTxt.resignFirstResponder()

    }
    @IBAction func buttonAction(_ sender: UIButton) {
        if(self.message == "") {
            print("wops")
            return;
        }
        else{
        var res = "";
            res = cipher.Encrypt(self.message);
            print("save the encrypt into keystore ", res, message);
            message = res;
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "saveSegue"
        {
            guard let usedfor = usedforTxt.text,
            usedfor != "",
            let key = keyTxt.text,
            key != ""
//            let password = keystore,
//            password != ""
            else
            {

                return
            }
            let password = message;
            addDate = Memo(password: password, usedfor: usedfor, key: Int(key)!)
        }
    }
}
