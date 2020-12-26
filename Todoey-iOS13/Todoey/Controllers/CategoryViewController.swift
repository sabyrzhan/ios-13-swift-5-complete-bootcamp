//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Sabyrzhan Tynybayev on 12/25/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    var categoriesArray: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ItemsList.plist"))
    }
    
    // MARK: - Data manipulation methods
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var mainTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            let category = Category()
            category.name = mainTextField.text!
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
}

// MARK: - Table data source

extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")
        let category = categoriesArray![indexPath.row]
        cell?.textLabel?.text = category.name
        
        return cell!
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
