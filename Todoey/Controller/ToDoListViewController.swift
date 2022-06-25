//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var listArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadData()
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
        
        tableView.deselectRow(at: indexPath, animated: true)
        saveItems()
    }
    
    //MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Activity", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.task = false
            
            self.listArray.append(newItem)
            
            self.saveItems()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add new activity"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Data
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
        func loadData() {
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            do {
               listArray =  try context.fetch(request)
            } catch {
                print("Error fetching data from context \(error)")
            }
        }
}











