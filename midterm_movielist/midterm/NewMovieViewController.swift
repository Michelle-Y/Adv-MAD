//
//  NewRestaurantViewController.swift
//  midterm
//
//  Created by Ziyang Yang on 3/14/19.
//  Copyright © 2019 Ziyang Yang. All rights reserved.
//

import UIKit
import os.log

class NewMovieViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var movieName: UITextField!
	@IBOutlet weak var movieURL: UITextField!
	@IBOutlet weak var saveButton: UIBarButtonItem!
	
	var restaurant: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
		super.prepare(for: segue, sender: sender)
		
		// Configure the destination view controller only when the save button is pressed.
		guard let button = sender as? UIBarButtonItem, button === saveButton else {
			os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
			return
		}
		
		restaurant = Movie(name: movieName.text!, url: movieURL.text!)
    }

}
