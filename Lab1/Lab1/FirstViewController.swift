//
//  FirstViewController.swift
//  Lab1
//
//  Created by mac on 2019/2/4.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var colors:[String:[Int]] = [String:[Int]]()
    var indexReds:[(String,[Int])] = [(String,[Int])]()
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var currentColor: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.keys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentColor.text = indexReds[row].0
        let rgb:[Int] = indexReds[row].1
        let color:UIColor = UIColor(red: CGFloat(rgb[0])/255, green: CGFloat(rgb[1])/255, blue: CGFloat(rgb[2])/255, alpha: 1.0)
        self.view.backgroundColor = color
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return indexReds[row].0
    }
    
    func loadPlist() -> Void {
        if let url = Bundle.main.url(forResource: "colorbox", withExtension: "plist"){
            let decoder:PropertyListDecoder = PropertyListDecoder()
            do{
                let data:Data = try Data(contentsOf: url)
                //Decode the plist of green colors and store it into the dictionary
                colors = try decoder.decode([String:[Int]].self, from: data)
                for (key, value) in colors {
                    indexReds.append((key, value))
                }
            }catch{
                print(error)
            }
        }
    }
    
    func setDelegates() -> Void {
        //Set the pickerView delegate and datasource to the first view controller
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        //Call the picker's didSelectRow delegate method on the first load to initially set the background color
        self.pickerView.delegate?.pickerView!(self.pickerView, didSelectRow: 0, inComponent: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPlist()
        self.setDelegates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

