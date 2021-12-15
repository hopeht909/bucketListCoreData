//
//  ViewController.swift
//  bucketListCoreData
//
//  Created by admin on 15/12/2021.
//

import UIKit
import CoreData
class TableViewController: UITableViewController, TableViewDelegate {
    
   
    var itemsList = [BucketListItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketCell", for: indexPath)
        cell.textLabel?.text = itemsList[indexPath.row].item
        return cell
    }
   
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditSegue" , sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = itemsList[indexPath.row]
        getContext().delete(item)
        
        saveItem()
        
        itemsList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem {
            
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemViewController
            addItemTableViewController.delegate = self
            
        }
        
        else if  sender is IndexPath   {
            
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemViewController
            addItemTableViewController.delegate = self
    
            let indexPath = sender as! NSIndexPath
            let item = itemsList[indexPath.row].item
            
            addItemTableViewController.item = item
            addItemTableViewController.indexPath = indexPath
        }
    }
    
    func cancelButtonPressed(by controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: AddItemViewController, with text: String, at indexPath: NSIndexPath?) {
        
        if let ip = indexPath {
            
            let item = itemsList[ip.row]
            item.item = text
        
        }
        else{
            
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: getContext()) as! BucketListItem
            item.item = text
            itemsList.append(item)
       
        }
        saveItem()
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    
}
extension TableViewController {
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getItems() {
        let context = getContext()
        
        let request = NSFetchRequest<BucketListItem>.init(entityName: "BucketListItem")
        
        do {
            itemsList = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    func saveItem() {
          
          let context = getContext()
          do {
              try context.save()
          } catch {
              print(error.localizedDescription)
          }
      }
}



