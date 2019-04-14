//
//  TypeTableViewController.swift
//  Days Matter
//
//  Created by mac on 2019/2/17.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit

class TypeTableViewController: UITableViewController {

    
//    var bodyStyle: String = ""
    var usedfor = [String]()
    var typedate = DateMemo()
    var memos = [Memo]()
    var filtermemotype = [Memo]()  //filtered type
    var filteredMemo = [Memo]()   //filtered search result
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewWillAppear(_ animated: Bool)
    {
        memos = typedate.dateList
        filterMemoByBodyStyle()
        for v in memos
        {
            print(v.usedfor)
        }
    }
    
    func filterMemoByBodyStyle()
    {
        print("filterMemoByBodyStyle()")
        filtermemotype = [Memo]()
        for v in memos
        {
//            if String(v.bodyType) == bodyStyle
//            {
                print("adding \(v.password) \(v.usedfor) to the filtered list (filtermemotype) ")
                filtermemotype.append(v)
//            }
        }
        
    }
    func getDates() {
//        var i = 0
        for datede in usedfor
        {
            
            print("current place : ",datede)
//            let DateDetails = datede.split(separator: ";")
            
//            if String(DateDetails[0]) != bodyStyle
//            {
//                print("remove \(DateDetails[1]) because it's not in\(bodyStyle)")
//                print("i = " , i)
//                usedfor.remove(at: i)
//            }
//            i = i + 1
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Welcome viewDidLoad()")

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
         searchController.searchBar.placeholder = "Search for password related infomation"
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        
        //navigationItem.searchController = searchController
        tableView.tableHeaderView = searchController.searchBar
       
        definesPresentationContext = true
        
    }

    @IBAction func unwingSegue(_ segue: UIStoryboardSegue)
    {
        if segue.identifier == "saveSegue"
        {
            let addDateinfo = segue.source as! NewDateViewController
            
            if addDateinfo.addDate.password != ""
            {
                let newAddDate = addDateinfo.addDate
                typedate.dateList.append(newAddDate)
                filtermemotype.append(newAddDate)
                tableView.reloadData()
                let newDateStr = newAddDate.toString()
                print("newDateStr === ", newDateStr)
                usedfor.append(newDateStr)
                
                for datede in usedfor
                {
                    print("============== ",datede)
                }
                
                for cv in filtermemotype
                {
                    print("$$$$$$$$$$$$$$ ",cv)
                }
            
            }
            else
            {

                print("unwingSegue() -> filtermemotype.count ",filtermemotype.count)
            }
        
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isFiltering()
        {
            return filteredMemo.count
        }
        return filtermemotype.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let v : Memo
        
        if isFiltering()
        {
            v = filteredMemo[indexPath.row]
        }
        else
        {
            v = filtermemotype[indexPath.row]
            print("type size is ", filtermemotype.count)

        }
        print("index path = ", indexPath.row)

        cell.textLabel?.text = v.password
        cell.detailTextLabel?.text = v.usedfor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let dateToDelete = filtermemotype[indexPath.row]
            let dateToDeleteIndex = typedate.getIndex(memo: dateToDelete)
            print("commit editingStyle() -> dateToDelete ", dateToDelete.toString())
            print("commit editingStyle() -> typedate.getIndex(memo: dateToDelete) ", typedate.getIndex(memo: dateToDelete))
            print("commit editingStyle() -> indexPath.row ",indexPath.row)
            
            filtermemotype.remove(at: indexPath.row)
            memos.remove(at: dateToDeleteIndex)
            typedate.dateList.remove(at: dateToDeleteIndex)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert
        {
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toDateInfo"
        {
            
            let DateInfo = segue.destination as! DateDetailTableViewController
            // get the index for tapped cell
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            print("password =", filtermemotype[indexPath.row].password)
            print("usedfor =", filtermemotype[indexPath.row].usedfor)
            DateInfo.password = filtermemotype[indexPath.row].password
            DateInfo.usedfor = filtermemotype[indexPath.row].usedfor

        }
        else if segue.identifier == "toAddNewDateSegue"
        {
            let destinationNavigationController = segue.destination as! UINavigationController
//            let newPassVC = destinationNavigationController.topViewController as! NewDateViewController
            
//            newPassVC.bodyStyle = self.title!
        }
        
    }
    
    func searchBarIsEmpty() -> Bool
    {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All")
    {
        filteredMemo = filtermemotype.filter({ (v : Memo) -> Bool in
            return v.password.lowercased().contains(searchText.lowercased())
                || v.usedfor.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }
    
    func isFiltering() -> Bool
    {
        return searchController.isActive && !searchBarIsEmpty()
    }

}

extension TypeTableViewController : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        searchController.searchResultsController?.view.isHidden = false
        filterContentForSearchText(searchController.searchBar.text!)
    }
    

}

