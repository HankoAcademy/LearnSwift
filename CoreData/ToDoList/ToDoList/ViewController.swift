//
//  ViewController.swift
//  ToDoList
//
//  Created by Hannie Kim on 10/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    let contentView = ContentView()
    lazy var tableView = contentView.tableView
    
    private var todoItems = [ToDoItem]()
    
    override func loadView() {
        view = contentView
        tableView.delegate = self
        tableView.dataSource = self
        setUpNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.fetchToDoListItems { todoListItems in
            if let todoListItems = todoListItems {
                todoItems = todoListItems
                
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
            
        }
    }
    
    private func setUpNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "New ToDo", message: "Enter the title and description of your new ToDo", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter ToDo title"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter ToDo description"
        }
        
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { alertAction in
            
            let titleTextField = alertController.textFields?.first
            let descriptionTextField = alertController.textFields?[1]
            
            guard let title = titleTextField?.text, let description = descriptionTextField?.text, !title.isEmpty, !description.isEmpty else {
                print("user needs to enter both title and description")
                return
            }
            
            DataManager.createToDoListItem(withTitle: title, andDescription: description)
            
            DataManager.fetchToDoListItems { [weak self] todoItems in
                guard let todos = todoItems else {
                    return
                }
                
                self?.todoItems = todos
                
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.id, for: indexPath) as? ToDoCell else {
            assertionFailure("Should always expect a ToDoCell to dequeue")
            return UITableViewCell()
        }
        
        cell.titleLabel.text = todoItems[indexPath.row].title
        cell.descriptionLabel.text = todoItems[indexPath.row].itemDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "", message: "Edit or Delete the ToDo or cancel this alert", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak self] _ in
            let alertController = UIAlertController(title: "Edit ToDo", message: "Enter new title and description for selected ToDo", preferredStyle: .alert)
            
            alertController.addTextField { textField in
                textField.placeholder = "Enter new title"
            }
            
            alertController.addTextField { textField in
                textField.placeholder = "Enter new description"
            }
            
            alertController.addAction(UIAlertAction(title: "Update", style: .default, handler: { alertAction in
                
                let titleTextField = alertController.textFields?.first
                let descriptionTextField = alertController.textFields?[1]
                
                guard let selectedToDo = self?.todoItems[indexPath.row], let title = titleTextField?.text, let description = descriptionTextField?.text, !title.isEmpty, !description.isEmpty else {
                    print("User needs to enter both title and description")
                    return
                }
                
                DataManager.updateToDo(item: selectedToDo, title: title, description: description)
                
                DataManager.fetchToDoListItem(usingTitle: title) { todoItem in
                    guard let todoItem = todoItem else {
                        return
                    }
                    
                    self?.todoItems[indexPath.row] = todoItem
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self?.present(alertController, animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "Delete", style: .default, handler: { [weak self] _ in
            
            guard let selectedToDo = self?.todoItems[indexPath.row] else {
                return
            }
            
            DataManager.deleteToDo(item: selectedToDo)
            
            tableView.beginUpdates()
            self?.todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}
