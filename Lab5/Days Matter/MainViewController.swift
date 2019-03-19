//
//  ViewController.swift
//  Days Matter
//
//  Created by mac on 2019/2/17.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    var dates = [String]()
    var memoStyles = ["Work", "Life", "Anniversary", "Future"]
    var typedate = DateMemo()
    let kfilename = "datasave.plist"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return memoStyles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = memoStyles[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("prepare for segue ...")

        if segue.identifier == "toDatesTableSegue"
        {
            print("got to DatesTableSegue")
            // get the index for tapped cell
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            print("indexPath = ", indexPath.row)
            
            let dateC = segue.destination as! TypeTableViewController
            dateC.bodyStyle = memoStyles[indexPath.row]
           
            dateC.title = memoStyles[indexPath.row]
            dateC.typedate = typedate
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
