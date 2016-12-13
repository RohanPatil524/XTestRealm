//
//  AddUpdateToDoVC.swift
//  RealmTest
//
//  Created by Sushant on 12/13/16.
//  Copyright © 2016 Sushant. All rights reserved.
//

import UIKit

class AddUpdateToDoVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var txtTitl: UITextField!

    @IBOutlet var txtDate: UITextField!
    var selectedDate:Date?
    var todo:ToDo?;
    var dtPicker: UIDatePicker?;
    var formatter:DateFormatter?
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter = DateFormatter()
        self.dtPicker = UIDatePicker()
        self.dtPicker?.addTarget(self, action: #selector(AddUpdateToDoVC.updateDate), for: UIControlEvents.valueChanged);
        self.txtDate.inputView = self.dtPicker;
        self.selectedDate = self.dtPicker?.date;

        if self.todo != nil{
            self.navigationController?.title = "Udpate To Do"
            self.txtTitl.text = self.todo?.title
            self.txtDate.text = formatter?.string(from: (self.dtPicker?.date)!);
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 2{
            return false
        }
        return true
    }
    @IBAction func btnDoneAction(_ sender: Any) {
        if self.todo == nil{
            self.saveToDo()
        }else{
            self.updateDate()
        }
    }
    func updateDate(){
        self.txtDate.text = formatter?.string(from: (self.dtPicker?.date)!);
        self.selectedDate = self.dtPicker?.date;
    }
    
    func updateToDo(){
        ModelHandeller.sharedModelHandeller.updateToDo(todoObj: self.todo!, newTitle: self.txtTitl.text!, newDate: self.selectedDate!);
         self.navigationController!.popViewController(animated: true)
        
    }
    func saveToDo(){
        ModelHandeller.sharedModelHandeller.addToDo(title: self.txtTitl.text!, date: self.selectedDate!);
        self.navigationController!.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
