//
//  TodoListViewController.swift
//  Todoey
//
//  Created by NeilPhung194 on 5/20/19.
//  Copyright © 2019 NeilPhung194. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

            loadItem()
        
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
        
        saveItem()
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done =  true
//        }else {
//             itemArray[indexPath.row].done =  false
//        }

        
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
            
            self.saveItem()
            
//            self.defaults.set(self.itemArray, forKey: "todoListArray")
            

            
          
            
            
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Item Todo"
            itemTextField = alertTextField
            
            
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //    MARK: - Model Manupulation Methods
    
    func saveItem(){
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        }
        catch {
            print(error)
        }
      self.tableView.reloadData()
    }
    
    func loadItem () {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                print(error)
            }
        }

    }

}
