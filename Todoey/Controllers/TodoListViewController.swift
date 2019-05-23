//
//  TodoListViewController.swift
//  Todoey
//
//  Created by NeilPhung194 on 5/20/19.
//  Copyright © 2019 NeilPhung194. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var itemArray = [Item]()

    // truy cập vào func saveContext trong AppDelegate.swift
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask ))
        
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
        
        
        return cell
    }
    
    // MARK: - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
  
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItem()
        
        tableView.deselectRow(at: indexPath, animated: true)
       
    }
    
    // MARK: - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
         var itemTextField = UITextField()
        
        let alert = UIAlertController(title: "Creat Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        

            
            let newItem = Item(context: self.context)
            
            newItem.title = itemTextField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItem()
            
            
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
        
        do {
            
            try context.save()
        }
        catch {
            
            print("Error saving context\(error)")

        }
      self.tableView.reloadData()
    }
    
    func loadItem () {
        let request : NSFetchRequest<Item> = Item.fetchRequest()

            do {
               itemArray = try context.fetch(request)
            }catch {
                print("Load Item error \(error)")
            }
        }

    }
