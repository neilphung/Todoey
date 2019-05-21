//
//  TodoListViewController.swift
//  Todoey
//
//  Created by NeilPhung194 on 5/20/19.
//  Copyright © 2019 NeilPhung194. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
//        if let items = defaults.array(forKey: "todoListArray") as? [String]{
//            itemArray = items
//        }
        let newItem = Item()
        newItem.title = "Fist Todo"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Fist Todo"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Fist Todo"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Fist Todo"
        itemArray.append(newItem3)
        
        let newItem4 = Item()
        newItem4.title = "Fist Todo"
        itemArray.append(newItem4)
        
        let newItem5 = Item()
        newItem5.title = "Fist Todo"
        itemArray.append(newItem5)
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)

        cell.textLabel?.text = itemArray[indexPath.row].title
        

        (itemArray[indexPath.row].done == true) ? (cell.accessoryType = .checkmark) : (cell.accessoryType = .none)
        
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }else {
//             cell.accessoryType = .none
//        }
        
        return cell
    }
    
    // MARK: - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done =  true
//        }else {
//             itemArray[indexPath.row].done =  false
//        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
//        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
       
    }
    
    // MARK: - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
         var itemTextField = UITextField()
         let newItem = Item()
        
        let alert = UIAlertController(title: "Creat Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
            newItem.title = itemTextField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "todoListArray")
            
            self.tableView.reloadData()
            
          
            
            
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Item Todo"
            itemTextField = alertTextField
            
            
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    

}
