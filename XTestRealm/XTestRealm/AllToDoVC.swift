//
//  ViewController.swift
//  RealmTest
//
//  Created by Sushant on 12/13/16.
//  Copyright © 2016 Sushant. All rights reserved.
//

import UIKit
import RealmSwift

class AllToDoVC: UIViewController,UITableViewDelegate,UITableViewDataSource,TodoDelegate {

    var isUpdateExistingTodo = false;
    var selectedTodo:ToDo?
    var todoList:Results<ToDo>?
    @IBOutlet weak var tblTodos: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadTable();
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return  1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.todoList?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") as! ToDoCell;
        cell.delagate = self;
        cell.tag = indexPath.row;
        cell.todo = (self.todoList?[indexPath.row])!;
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func editToDoAtIndexPath(indexPath: NSIndexPath) {
         self.isUpdateExistingTodo = true
        self.selectedTodo = self.todoList?[indexPath.row];
        self.performSegue(withIdentifier: "AddUpdateTodoVc", sender: self);
    }
    func deleteTodoAtIndexPath(indexPath: NSIndexPath) {
        let todoObj = self.todoList?[indexPath.row];
        ModelHandeller.sharedModelHandeller.deleteToDo(todoObj: todoObj!)
    }
    @IBAction func createNewTodoAction(_ sender: Any) {
        self.isUpdateExistingTodo = false
        self.performSegue(withIdentifier: "AddUpdateTodoVc", sender: self);
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.isUpdateExistingTodo == true{
            let destinationVC = segue.destination as! AddUpdateToDoVC;
            destinationVC.todo = self.selectedTodo
            self.isUpdateExistingTodo = false
        }
    }
    
    func loadTable(){
        self.todoList = ModelHandeller.sharedModelHandeller.getSortedToDos();
        self.tblTodos.reloadData();
    }
}


