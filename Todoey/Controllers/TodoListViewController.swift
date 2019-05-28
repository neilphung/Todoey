//
//  TodoListViewController.swift
//  Todoey
//
//  Created by NeilPhung194 on 5/20/19.
//  Copyright © 2019 NeilPhung194. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var selectedCategory : Category? {
        didSet{
            loadItem()
        }
    }
    let realm = try! Realm()
    var todoItems : Results<Item>?
 
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return todoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)

        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No Item Added"
        }
        return cell
    }
    
    // MARK: - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        if let item = todoItems?[indexPath.row]{
            do {
                try realm.write {
//                    item.done = !item.done
                    realm.delete(item)
                }
            }catch {
                print("error \(error)")
            }
        }
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    // MARK: - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
         var itemTextField = UITextField()
        
        let alert = UIAlertController(title: "Creat Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
         if let currentCategory = self.selectedCategory{
            do {

                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = itemTextField.text!
                        newItem.dataCreated = Date()
                        currentCategory.items.append(newItem)
                      
                      

                    }
                }
            catch {
                print("error \(error)")
            }
            
        }
            
            self.tableView.reloadData()
            
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Item Todo"
            itemTextField = alertTextField

        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //    MARK: - Model Manupulation Methods
   
    func loadItem () {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)


        tableView.reloadData()
        }
}
    
    
    
    // MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()

            DispatchQueue.main.async {
             searchBar.resignFirstResponder()

                }
            }
        }
    }
