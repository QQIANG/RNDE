//
//  FolderViewController.swift
//  TTing
//
//  Created by JNYJ on 14-10-29.
//  Copyright (c) 2014年 JNYJ. All rights reserved.
//

import UIKit
import CoreData

var int_numberofrows : Int = 10

class FolderViewController: UITableViewController {

	override func awakeFromNib() {
		super.awakeFromNib()
		if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
		    self.clearsSelectionOnViewWillAppear = false
		    self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "event_right")
		self.navigationItem.rightBarButtonItem = addButton
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	// MARK: - Table View
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return int_numberofrows
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
		self.configureCell(cell, atIndexPath: indexPath)
		return cell
	}
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			int_numberofrows -= 1
			self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
		}
	}

	//MARKS: - Configures
	func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
		cell.textLabel.text = "Cell-Name-\(int_numberofrows-indexPath.row)"
	}

	//MARKS: - Events
	func event_right(){
		int_numberofrows += 1
		self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
	}
}












