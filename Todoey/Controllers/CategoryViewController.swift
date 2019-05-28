//
//  CategoryViewController.swift
//  Todoey
//
//  Created by NeilPhung194 on 5/24/19.
//  Copyright © 2019 NeilPhung194. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategaries()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categories?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category Cell"

        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    
    
    //MARK: - Data Manipulation Methods
    
    func save(Category : Category) {
        do {
            try realm.write {
                realm.add(Category)
            }
        }
        catch {
            print("save errror \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategaries(){
      
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }

    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var itemCategoryTextfield = UITextField()

        
        let alert = UIAlertController(title: "Create Item Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCotegory = Category()
            newCotegory.name = itemCategoryTextfield.text!
   
            self.save(Category: newCotegory)
            
            self.loadCategaries()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new item category"
            itemCategoryTextfield = alertTextField
        }
        
      present(alert, animated: true, completion: nil)
    }
    

    
}
