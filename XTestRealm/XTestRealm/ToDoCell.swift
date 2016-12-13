//
//  ToDoCell.swift
//  RealmTest
//
//  Created by Sushant on 12/13/16.
//  Copyright © 2016 Sushant. All rights reserved.
//

import UIKit
protocol TodoDelegate {
    func deleteTodoAtIndexPath(indexPath:NSIndexPath);
    func editToDoAtIndexPath(indexPath:NSIndexPath)
}

class ToDoCell: UITableViewCell {
    @IBOutlet weak var lblToDotitle: UILabel!
    @IBOutlet weak var lblToDoDate: UILabel!

    var delagate:TodoDelegate?;
    var indexPath:NSIndexPath?;
    
    private var _todo:ToDo?;
    var todo:ToDo{
        get{
            return _todo!;
        }
        set{
            _todo = newValue;
            updateUI();
            
        }
    }
    
    func updateUI(){
         self.lblToDotitle.text = self.todo.title;
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm"
        let str = formatter.string(from: self.todo.date!)
        self.lblToDoDate.text = str
        self.indexPath = NSIndexPath(row: self.tag, section: 0);
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        if indexPath == nil {
            self.indexPath = NSIndexPath(row: self.tag, section: 0);
        }
        self.delagate?.editToDoAtIndexPath(indexPath: self.indexPath!)
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        if indexPath == nil {
            self.indexPath = NSIndexPath(row: self.tag, section: 0);
        }
        self.delagate?.deleteTodoAtIndexPath(indexPath: self.indexPath!)
    }

}
