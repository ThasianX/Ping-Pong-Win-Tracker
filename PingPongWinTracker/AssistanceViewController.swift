//
//  SecondViewController.swift
//  PingPongWinTracker
//
//  Created by Kevin Li on 9/15/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//
import os
import UIKit

class DailyScoreCell : UITableViewCell{
    
    @IBOutlet weak var kevinWins: UILabel!
    @IBOutlet weak var andrewWins: UILabel!
}

class AssistanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Properties
    @IBOutlet var tableView: UITableView!
    var kevinWinsArray : [Int] = []
    var andrewWinsArray : [Int] = []
    var dateArray : [String] = []
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        os_log("Assistance view loaded.", log: OSLog.default, type: .info)
        
        if (UserDefaults.standard.value(forKey: "kevinWinsArray") as? [Int]) != nil {
            kevinWinsArray = UserDefaults.standard.value(forKey: "kevinWinsArray") as! [Int]
        }
        if (UserDefaults.standard.value(forKey: "andrewWinsArray") as? [Int]) != nil {
            andrewWinsArray = UserDefaults.standard.value(forKey: "andrewWinsArray") as! [Int]
        }
        if (UserDefaults.standard.value(forKey: "dateArray") as? [String]) != nil {
            dateArray = UserDefaults.standard.value(forKey: "dateArray") as! [String]
        }
        
        print(kevinWinsArray)
        print(andrewWinsArray)
        print(dateArray)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        os_log("Assistance view will appear.", log: OSLog.default, type: .info)
        
        kevinWinsArray = UserDefaults.standard.value(forKey: "kevinWinsArray") as! [Int]
        andrewWinsArray = UserDefaults.standard.value(forKey: "andrewWinsArray") as! [Int]
        dateArray = UserDefaults.standard.value(forKey: "dateArray") as! [String]
        self.tableView.reloadData()
        
    }
    
    //MARK: UITableView methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dateArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DailyScoreCell = tableView.dequeueReusableCell(withIdentifier: "dailyScoreCell") as! DailyScoreCell
        let kevinWins = kevinWinsArray[indexPath.section]
        let andrewWins = andrewWinsArray[indexPath.section]
        
        cell.kevinWins.text = "\(kevinWins)"
        cell.andrewWins.text = "\(andrewWins)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateArray[section]
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete", handler: { (delete, view, completionHandler) in
            self.deleteRow(at: indexPath.section)
            completionHandler(true)
        })
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteRow(at section: Int){
        os_log("Deleting row in assistance view.", log: OSLog.default, type: .info)
        var kevinWins = UserDefaults.standard.value(forKey: "kevinWins") as! Int
        var andrewWins = UserDefaults.standard.value(forKey: "andrewWins") as! Int
        kevinWins -= kevinWinsArray[section]
        andrewWins -= andrewWinsArray[section]
        UserDefaults.standard.set(kevinWins, forKey: "kevinWins")
        UserDefaults.standard.set(andrewWins, forKey: "andrewWins")
        
        kevinWinsArray = UserDefaults.standard.value(forKey: "kevinWinsArray") as! [Int]
        andrewWinsArray = UserDefaults.standard.value(forKey: "andrewWinsArray") as! [Int]
        dateArray = UserDefaults.standard.value(forKey: "dateArray") as! [String]
        dateArray.remove(at: section)
        kevinWinsArray.remove(at: section)
        andrewWinsArray.remove(at: section)
        print(dateArray)
        
        UserDefaults.standard.set(dateArray, forKey: "dateArray")
        UserDefaults.standard.set(kevinWinsArray, forKey: "kevinWinsArray")
        UserDefaults.standard.set(andrewWinsArray, forKey: "andrewWinsArray")
        
        tableView.reloadData()
    }

    

}

