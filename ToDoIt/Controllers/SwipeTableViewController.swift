//
//  SwipeTableViewController.swift
//  ToDoIt
//
//  Created by Richard Balabarcon on 9/24/20.
//  Copyright © 2020 Richard Balabarcon. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 90.0
    }
    
    // TableView DataSource Methods

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
                
        cell.delegate = self

        return cell
                      
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            // handle action by updating model with deletion
            
            self.updateModel(at: indexPath)
        
        }
        

        // customize the action appearance
        deleteAction.image = UIImage(named: "thrash")

        return [deleteAction]
      }
        
        func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var options = SwipeOptions()
            options.expansionStyle = .destructive
            options.transitionStyle = .reveal
            return options
        }
    
    func updateModel(at indexPath: IndexPath) {
        // Update our data model
        
        print("Item successfully deleted from Category")
    }
}



