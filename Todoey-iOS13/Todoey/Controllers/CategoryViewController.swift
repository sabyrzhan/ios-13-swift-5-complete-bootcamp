//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Sabyrzhan Tynybayev on 12/25/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    var categoriesArray: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.separatorStyle = .none
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hexString: "1D9BF6")
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: - Data manipulation methods
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var mainTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            let category = Category()
            category.name = mainTextField.text!
            category.color = UIColor.randomFlat().hexValue()
            self.save(category)
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create new category"
            mainTextField = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func save(_ category: Category) {
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error while saving data: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadData() {
        let realm = try! Realm()
        categoriesArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        let realm = try! Realm()
       do {
           try realm.write {
               realm.delete(self.categoriesArray![indexPath.row])
           }
       } catch {
           print("Error deleting category: \(error)")
       }
    }
}

// MARK: - Table data source

extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let category = categoriesArray![indexPath.row]
        cell.textLabel?.text = category.name
        if category.color.isEmpty {
            let realm = try! Realm()
            do {
                try realm.write {
                    category.color = UIColor.randomFlat().hexValue()
                }
            } catch {
                print("Error saving color of the category: \(error)")
            }
        }
        
        if let uiColor = UIColor.init(hexString: category.color) {
            cell.backgroundColor = uiColor
            cell.textLabel?.textColor = ContrastColorOf(uiColor, returnFlat: true)
        }
        
        return cell
    }
}

// MARK: - Table delegate

extension CategoryViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        let selectedCategory = categoriesArray![indexPath!.row]
        let destinationVC = segue.destination as! TodolistViewController
        destinationVC.selectedCategory = selectedCategory
    }
}
