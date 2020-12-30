//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Sabyrzhan Tynybayev on 12/29/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit
import RealmSwift

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
    }
    
    // MARK: - TableViewController methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - SwipeTableViewCell methods
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateModel(at: indexPath)
        }
        
        deleteAction.image = UIImage(named: "trash-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    // MARK: - Data manipulation methods
    func updateModel(at indexPath: IndexPath) {
        
    }
}
