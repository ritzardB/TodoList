//
//  ViewController.swift
//  ToDoIt
//
//  Created by Richard Balabarcon on 9/24/19.
//  Copyright © 2019 Richard Balabarcon. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ToDoListViewController: SwipeTableViewController {
    
    var todoItems: Results<Item>?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
    didSet{
       loadItems()
    }
}


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let colourHex = selectedCategory?.colour {
            
            title = selectedCategory!.name
            
            guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
            
            if let navBarColour = UIColor(hexString: colourHex) {
                
                navBar.backgroundColor = navBarColour
                
                navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
                
                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
                
                searchBar.backgroundColor = UIColor(hexString: colourHex)
            }
            
            
        }
    }
    
    // MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
        
            cell.textLabel?.text = item.title
            
            if let colour = UIColor(hexString: selectedCategory!.colour)?.darken(byPercentage:CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
                cell.backgroundColor = colour
                        cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
                }
        
        //Ternary operation ==>
        // Value = condition ? ValueItem : value False
    
        cell.accessoryType = item.done ? .checkmark : .none
            
        } else  {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
        
    }
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                item.done = !item.done
                }
            } catch {
                    print("Error saving done status, \(error)")
                }
        }
            tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK - Add New item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title:  "Add New ToDoList Item", message: "", preferredStyle: .alert)
        
       
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            
            // what will happen once the user add another idem alert
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData() 
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

}

    //MARK - Model Manupulation Method

    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()

        }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                realm.delete(item)
            }
            } catch {
                print("Error deleting item, \(error)")
            }
        }
    }
}

// MARK - SearchBar extension class method

extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
      
        
    }
 

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0 {

           loadItems()

            DispatchQueue.main.async {

            searchBar.resignFirstResponder()
        }
        }

    }

}
