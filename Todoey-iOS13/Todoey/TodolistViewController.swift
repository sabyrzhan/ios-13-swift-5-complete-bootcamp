//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodolistViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let itemsList = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ItemsList.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
//        loadData()
        print(itemsList)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell")
        let item = itemArray[indexPath.row]
        cell?.textLabel?.text = item.title
        
        cell?.accessoryType = item.done ? .checkmark : .none
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var mainTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            let item = Item(context: self.context)
            item.title = mainTextField.text!
            item.done = false
            self.itemArray.append(item)
            self.saveData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create new item"
            mainTextField = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Items list manipulation
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error while saving data: \(error)")
        }
        
        tableView.reloadData()
    }
    
//    func loadData() {
//        if let savedData = try? Data(contentsOf: itemsList!) {
//            let decoder = PropertyListDecoder.init()
//            do {
//                let decodedData = try decoder.decode([Item].self, from: savedData)
//                itemArray = decodedData
//            } catch {
//                print("Error while loading data: \(error)")
//            }
//        }
//        tableView.reloadData()
//    }
}
