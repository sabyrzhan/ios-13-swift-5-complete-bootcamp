//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class TodolistViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadData()
        }
    }
    
    var todoItems: Results<Item>?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let item = todoItems![indexPath.row]
        cell.textLabel?.text = item.done ? item.title + "   ✅" : item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = todoItems![indexPath.row]
        do {
            try realm.write {
                item.done = !item.done
            }
        } catch {
            print("Error updating item: \(item)")
        }
        
        loadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var mainTextField = UITextField()

        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            do {
                try self.realm.write {
                    let item = Item()
                    item.title = mainTextField.text!
                    item.done = false
                    self.selectedCategory?.items.append(item)
                }
            } catch {
                print("Error creating item: \(error)")
            }
            self.loadData()
            //self.saveData(item)
        }

        alert.addTextField { (textField) in
            textField.placeholder = "Create new item"
            mainTextField = textField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Items list manipulation
    
    func saveData(_ item: Item) {
        do {
            try realm.write {
                realm.add(item, update: .modified)
            }
        } catch {
            print("Error while saving data: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadData() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        
        do {
            try realm.write {
                realm.delete(self.todoItems![indexPath.row])
            }
        } catch {
            print("Error deleting item: \(error)")
        }
        
    }
}

// MARK: - Search bar methods
extension TodolistViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
