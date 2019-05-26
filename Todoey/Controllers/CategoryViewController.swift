//
//  CategoryViewController.swift
//  Todoey
//
//  Created by NeilPhung194 on 5/24/19.
//  Copyright © 2019 NeilPhung194. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryItemArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategaries()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categoryItemArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryItemArray[indexPath.row].name

        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVC.selectedCategory = categoryItemArray[indexPath.row]
        }
    }

    
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories() {
        do {
            try context.save()
        }
        catch {
            print("save errror \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategaries(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryItemArray = try context.fetch(request)
        }catch {
            print("Load Item error \(error)")
        }
        
        tableView.reloadData()
    }

    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var itemCategoryTextfield = UITextField()

        
        let alert = UIAlertController(title: "Create Item Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCotegory = Category(context: self.context)
            newCotegory.name = itemCategoryTextfield.text!
            
            self.saveCategories()
            self.loadCategaries()
            
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new item category"
            itemCategoryTextfield = alertTextField
        }
        
      present(alert, animated: true, completion: nil)
    }
    

    
}
