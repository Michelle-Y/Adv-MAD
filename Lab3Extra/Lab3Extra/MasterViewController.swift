//
//  MasterViewController.swift
//  Lab3Extra
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
	
	var detailViewController: DetailViewController? = nil
	var cats = [[String : String]]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		/*
		self.navigationItem.leftBarButtonItem = self.editButtonItem()
		let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
		self.navigationItem.rightBarButtonItem = addButton
		*/
		
		// URL for our plist
		if let pathURL = Bundle.main.url(forResource: "cats", withExtension: "plist"){
			//creates a property list decoder object
			let plistdecoder = PropertyListDecoder()
			do {
				let data = try Data(contentsOf: pathURL)
				//decodes the property list
				cats = try plistdecoder.decode([[String:String]].self, from: data)
			} catch {
				// handle error
				print(error)
			}
		}
		
		if let split = self.splitViewController {
			let controllers = split.viewControllers
			self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
		super.viewWillAppear(animated)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
			if let indexPath = self.tableView.indexPathForSelectedRow {
				let cat = cats[indexPath.row]
				let url = cat["url"]!
				let breed = cat["breed"]!
				let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
				controller.detailItem = url as AnyObject?
				controller.title = breed
				controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
				controller.navigationItem.leftItemsSupplementBackButton = true
			}
		}
	}
	
	// MARK: - Table View
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cats.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let cat = cats[indexPath.row]
		cell.textLabel!.text = cat["breed"]!
		return cell
	}
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return false
	}
	
	
}

