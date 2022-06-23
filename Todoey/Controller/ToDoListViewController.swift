//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var listArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Learn Programming"
        listArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Read a Book"
        listArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Record a Video"
        listArray.append(newItem3)
        
        //        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        //            listArray = items }
    
    }
    
    
    //MARK: - UITableViewDataSource
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = listArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.task == true ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listArray[indexPath.row].task = !listArray[indexPath.row].task
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Activity", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let newItem = Item()
            newItem.title = textField.text!
            self.listArray.append(newItem)
            
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(self.listArray)
                try data.write(to: self.dataFilePath!)
            } catch {
                print(error)
            }
            
            
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add new activity"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}











