//
//  FirstViewController.swift
//  PingPongWinTracker
//
//  Created by Kevin Li on 9/15/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import UIKit
import os

class MainViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var kevinWinsLabel: UILabel!
    @IBOutlet weak var andrewWinsLabel: UILabel!
    var kevinWins : Int = 0
    var andrewWins : Int = 0
    var kevinWinsArray : [Int] = []
    var andrewWinsArray : [Int] = []
    var dateArray : [String] = []
    var date : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        os_log("Application started. View did load.", log: OSLog.default, type: .info)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        os_log("Main view will appear.", log: OSLog.default, type: .info)
        if (UserDefaults.standard.value(forKey: "kevinWins") as? Int) != nil {
            kevinWins = UserDefaults.standard.value(forKey: "kevinWins") as! Int
        }
        if (UserDefaults.standard.value(forKey: "andrewWins") as? Int) != nil {
            andrewWins = UserDefaults.standard.value(forKey: "andrewWins") as! Int
        }
        
        kevinWinsLabel.text = "\(kevinWins)"
        andrewWinsLabel.text = "\(andrewWins)"
        
        if (UserDefaults.standard.value(forKey: "kevinWinsArray") as? [Int]) != nil {
            kevinWinsArray = UserDefaults.standard.value(forKey: "kevinWinsArray") as! [Int]
        }
        if (UserDefaults.standard.value(forKey: "andrewWinsArray") as? [Int]) != nil {
            andrewWinsArray = UserDefaults.standard.value(forKey: "andrewWinsArray") as! [Int]
        }
        if (UserDefaults.standard.value(forKey: "dateArray") as? [String]) != nil {
            dateArray = UserDefaults.standard.value(forKey: "dateArray") as! [String]
        }
        
        date = getDate()
        
        if (dateArray.first != nil && (dateArray[0] != date)){
            os_log("Adding new section.", log: OSLog.default, type: .info)
            dateArray.insert(date, at: 0)
            UserDefaults.standard.set(dateArray, forKey: "dateArray")
            kevinWinsArray.insert(0, at: 0)
            UserDefaults.standard.set(kevinWinsArray, forKey: "kevinWinsArray")
            andrewWinsArray.insert(0, at: 0)
            UserDefaults.standard.set(andrewWinsArray, forKey: "andrewWinsArray")
        }
        if dateArray.count == 0{
            os_log("Adding new section.", log: OSLog.default, type: .info)
            dateArray.insert(date, at: 0)
            UserDefaults.standard.set(dateArray, forKey: "dateArray")
            kevinWinsArray.insert(0, at: 0)
            UserDefaults.standard.set(kevinWinsArray, forKey: "kevinWinsArray")
            andrewWinsArray.insert(0, at: 0)
            UserDefaults.standard.set(andrewWinsArray, forKey: "andrewWinsArray")
        }
        
    }

    
    //MARK: Button methods
    
    @IBAction func increaseKevinWins(_ sender: UIButton) {
        kevinWins+=1
        UserDefaults.standard.set(kevinWins, forKey: "kevinWins")
        kevinWinsLabel.text = "\(kevinWins)"
        os_log("Increasing Kevin's score to %d.", log: OSLog.default, type: .info, kevinWins)
        
        kevinWinsArray[0] += 1
        UserDefaults.standard.set(kevinWinsArray, forKey: "kevinWinsArray")
    }
    
    @IBAction func increaseAndrewWins(_ sender: UIButton) {
        andrewWins+=1
        UserDefaults.standard.set(andrewWins, forKey: "andrewWins")
        andrewWinsLabel.text = "\(andrewWins)"
        os_log("Increasing Andrew's score to %d.", log: OSLog.default, type: .info, andrewWins)
        
        andrewWinsArray[0] += 1
        UserDefaults.standard.set(andrewWinsArray, forKey: "andrewWinsArray")
    }
    @IBAction func decreaseKevinWins(_ sender: UIButton) {
        kevinWins-=1
        UserDefaults.standard.set(kevinWins, forKey: "kevinWins")
        kevinWinsLabel.text = "\(kevinWins)"
        os_log("Decreasing Kevin's score to %d.", log: OSLog.default, type: .info, kevinWins)
        
        kevinWinsArray[0] -= 1
        UserDefaults.standard.set(kevinWinsArray, forKey: "kevinWinsArray")
    }
    
    @IBAction func decreaseAndrewWins(_ sender: UIButton) {
        andrewWins-=1
        UserDefaults.standard.set(andrewWins, forKey: "andrewWins")
        andrewWinsLabel.text = "\(andrewWins)"
        os_log("Decreasing Andrew's score to %d.", log: OSLog.default, type: .info, andrewWins)
        
        andrewWinsArray[0] -= 1
        UserDefaults.standard.set(andrewWinsArray, forKey: "andrewWinsArray")
    }
    //MARK: Helper functions
    
    func getDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter.string(from: date)
    }
}

