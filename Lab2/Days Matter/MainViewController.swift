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

        
        let fileStatus = isFileExists(plistName: kfilename)
        if fileStatus.fileExists
        {
            print("viewDidLoad() -> \(kfilename) exists")
            dates = getDataArrayFromPlist(plistNameURL: fileStatus.path)
        }
        else
        {
            print("viewDidLoad() -> \(kfilename) does NOT exists")
            print("viewDidLoad() -> default plist file will be used")
            dates = getDataArrayFromPlist(plistName: "dates")
        }
        
        for date in dates
        {
            print(date)
            let Details = date.split(separator: ";")
            let v = Memo(bodyType: String(Details[0]), name: String(Details[1]), date: String(Details[2]))
          
            typedate.dateList.append(v)
            
        }
        //application instance
        let app = UIApplication.shared
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.applicationWillResignActive(_:)), name: UIApplication.willResignActiveNotification, object: app)
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
    
    func getDataArrayFromPlist(plistName: String) -> Array<String>
    {
        print("getDateArrayFromPlist(\(plistName))")
        var dataArray = [String]()
        if let pathURL = Bundle.main.url(forResource: plistName, withExtension: "plist")
        {
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do
            {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                dataArray = try plistdecoder.decode([String].self, from: data)
            } catch
            {
                // handle error
                print(error)
            }
        }
        return dataArray
    }
    
    func getDataArrayFromPlist(plistNameURL: URL) -> Array<String>
    {
        print("getDateArrayFromPlist(\(plistNameURL.absoluteString))")
        var dataArray = [String]()
        let pathURL = plistNameURL
        //creates a property list decoder object
        let plistdecoder = PropertyListDecoder()
        do
        {
            let data = try Data(contentsOf: pathURL)
            //decodes the property list
            dataArray = try plistdecoder.decode([String].self, from: data)
        } catch
        {
            // handle error
            print(error)
            }
        return dataArray
    }
    func isFileExists(plistName: String) -> (fileExists:Bool, path: URL)
    {
        let pathURL:URL?
        //get path for data file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0] //documents directory
        print(docDir)
        
        // URL for our plist
        let dataFileURL = docDir.appendingPathComponent(plistName)
        print(dataFileURL)
        
        //if the data file exists, use it
        if FileManager.default.fileExists(atPath: dataFileURL.path)
        {
            pathURL = dataFileURL
            return (true,pathURL!)
        }
        else
        {
            pathURL = dataFileURL
            return (false, pathURL!)
        }
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
            dateC.dates = dates
            dateC.title = memoStyles[indexPath.row]
            dateC.typedate = typedate
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //called when the UIApplicationWillResignActiveNotification notification is posted
    //all notification methods take a single NSNotification instance as their argument
    @objc func applicationWillResignActive(_ notification: NSNotification)
    {
        //AlertController.showAlert(inViewController: self, title: "<#T##String#>", message: "<#T##String#>")
        //get path for data file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0] //documents directory
        print(docDir)
        
        // URL for our plist
        let dataFileURL = docDir.appendingPathComponent(kfilename)
        print(dataFileURL)
        //creates a property list decoder object
        let plistencoder = PropertyListEncoder()
        plistencoder.outputFormat = .xml
        do
        {
            print("saving dates ...")
            print("dates list is: \(typedate.toString())")
            let data = try plistencoder.encode(typedate.toString())
            try data.write(to: dataFileURL)
        } catch
        {
            // handle error
            print(error)
        }
    }


}

