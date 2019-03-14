//
//  MasterViewController.swift
//  midterm
//
//  Created by Ziyang Yang on 3/14/19.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//


import UIKit

class MasterViewController: UITableViewController {

	var detailViewController: DetailViewController? = nil
	var movies = [Movie]()


	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// URL for our plist
		if let pathURL = Bundle.main.url(forResource: "movies", withExtension: "plist"){
			//creates a property list decoder object
			let plistdecoder = PropertyListDecoder()
			do {
				let data = try Data(contentsOf: pathURL)
				//decodes the property list
				var tmpList = [[String : String]]()
				tmpList = try plistdecoder.decode([[String:String]].self, from: data)
				for r in tmpList {
					let tmpRestaurant: Movie = Movie(name: r["name"]!, url: r["url"]!)!
					movies.append(tmpRestaurant)
				}
			} catch {
				// handle error
				print(error)
			}
		}
		
		convertFormListToMovies()
		
		/*
		navigationItem.leftBarButtonItem = editButtonItem
		*/
		
		/*
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
		navigationItem.rightBarButtonItem = addButton
		*/


		if let split = splitViewController {
		    let controllers = split.viewControllers
		    detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
		super.viewWillAppear(animated)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*
	@objc
	func insertNewObject(_ sender: Any) {
		restaurants.insert(NSDate(), at: 0)
		let indexPath = IndexPath(row: 0, section: 0)
		tableView.insertRows(at: [indexPath], with: .automatic)
	}
	*/

	// MARK: - Segues

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
		    if let indexPath = tableView.indexPathForSelectedRow {
		        let movie = movies[indexPath.row]
				let url = movie.url
				let name = movie.name
		        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
		        controller.detailItem = url as AnyObject?
				controller.title = name
		        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
		        controller.navigationItem.leftItemsSupplementBackButton = true
		    }
		}
	}
	

	// MARK: - Table View

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return movies.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		let movie = movies[indexPath.row]
		cell.textLabel!.text = movie.name
		return cell
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
		    movies.remove(at: indexPath.row)
			convertMovieToArrayAndSave()
		    tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
		    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
		}
	}
	
	
	// MARK: Actions
	
	@IBAction func unwindToRestaurantList(sender: UIStoryboardSegue) {
		if let sourceViewController = sender.source as? NewMovieViewController, let restaurant = sourceViewController.restaurant {
			//let newIndexPath = IndexPath(row: restaurants.count, section: 0)
			movies.append(restaurant)
			
			convertMovieToArrayAndSave()
			
			tableView.reloadData()
		}
	}
	
	func convertMovieToArrayAndSave() {
		var MovieList = [[String]]()
		for r in movies {
			MovieList.append([r.name, r.url])
		}
		UserDefaults.standard.set(MovieList, forKey: "midtermRestaurants")
	}
	
	func convertFormListToMovies() {
		if let tmp: [[String]] = UserDefaults.standard.object(forKey: "midtermRestaurants") as? [[String]] {
			// Successfully loaded
			print("good")
			var tmpmovies = [Movie]()
			for item in tmp {
				tmpmovies.append(Movie(name: item[0], url: item[1])!)
			}
			movies = tmpmovies
		} else {
			// Didn't load
			print("error")
		}
	}


}

