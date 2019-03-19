//
//  TypeTableViewController.swift
//  Days Matter
//
//  Created by mac on 2019/2/17.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit
import RealmSwift
class TypeTableViewController: UITableViewController {

    
    var bodyStyle: String = ""
//    var dates = [String]()
    var dates: Results<Memo>!
    var typedate = DateMemo()
    var filtermemotype = [Memo]()
    var filteredMemo = [Memo]()
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewWillAppear(_ animated: Bool)
    {
        let realm = RealmService.share.realm
        dates = realm.objects(Memo.self)
        filterMemoByBodyStyle()
        for v in dates
        {
            print(v.date)
        }
    }
    
    func filterMemoByBodyStyle()
    {
        print("filterMemoByBodyStyle()")
        filtermemotype = [Memo]()
        for v in self.dates
        {
            if String(v.bodyType) == bodyStyle
            {
                print("adding \(v.name) \(v.date) to the filtered list (filtermemotype) ")
                filtermemotype.append(v)
            }
        }
        
    }
//    func getDates() {
//        var i = 0
//        for datede in dates
//        {
//
//            print("current car : ",datede)
//            let DateDetails = datede.split(separator: ";")
//
//            if String(DateDetails[0]) != bodyStyle
//            {
//                print("remove \(DateDetails[1]) because it's not in\(bodyStyle)")
//                print("i = " , i)
//                dates.remove(at: i)
//            }
//            i = i + 1
//        }
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Important event ", bodyStyle)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
         searchController.searchBar.placeholder = "Search a Event Name or a Date"
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
            
            if addDateinfo.addDate.name != ""
            {
                let newAddDate = addDateinfo.addDate
               RealmService.share.save(memo: newAddDate)
                print("Reloading the table view")
                self.viewWillAppear(true)
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
            print("flitermemotype size is ", filtermemotype.count)
        }
        print("index path = ", indexPath.row)
        cell.textLabel?.text = v.name + " " + v.date
        cell.detailTextLabel?.text = v.bodyType
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
            filtermemotype.remove(at: indexPath.row)
            RealmService.share.delete(memo: dateToDelete)
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
            print("name =", filtermemotype[indexPath.row].name)
            print("date =", filtermemotype[indexPath.row].date)
            DateInfo.name = filtermemotype[indexPath.row].name
            DateInfo.date = filtermemotype[indexPath.row].date

        }
        else if segue.identifier == "toAddNewDateSegue"
        {
            let destinationNavigationController = segue.destination as! UINavigationController
            let newVehicleVC = destinationNavigationController.topViewController as! NewDateViewController
            
            newVehicleVC.bodyStyle = self.title!
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
            return v.name.lowercased().contains(searchText.lowercased())
                || v.date.lowercased().contains(searchText.lowercased())
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
