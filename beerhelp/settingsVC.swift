//
//  settingsVC.swift
//  beerhelp
//
//  Created by David Tosh on 19/07/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import UIKit
import Firebase

class settingsVC: UITableViewController {
    
    @IBOutlet weak var darkmodeSwitch: UISwitch!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var removeadsLabel: UILabel!
    @IBOutlet weak var fullAccessLabel: UILabel!
    @IBOutlet weak var fullAccessSubLabel: UILabel!
    @IBOutlet weak var darkmodeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var usernameFB: UILabel!
    
    
    
    //dark mode
    var darkOn = Bool()
    var lightOn = Bool()
    var refresher: UIRefreshControl!
    let defaults = UserDefaults.standard
  
    // firebase
    
    let currentUserId = Auth.auth().currentUser?.uid

    

    
    //rate link
    let url = URL(string: "http://www.stuff.co.nz")!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //firebase user name
        
        if Auth.auth().currentUser == nil {
            usernameFB.text = ""
        } else {
            usernameFB.text = Auth.auth().currentUser?.email
        }
        
        //dark mode
        self.refreshControl = nil
        
        Style.loadTheme()
        
        
        let blackTheme = UserDefaults.standard
        darkOn = blackTheme.bool(forKey: "blackTheme")
        let defaultTheme = UserDefaults.standard
        lightOn = defaultTheme.bool(forKey: "defaultTheme")
        
        if (darkOn == true) {
            darkmodeSwitch.isOn = true
            Style.blackTheme()
            
        }
        
        if (lightOn == true) {
            darkmodeSwitch.isOn = false
            Style.defaultTheme()
            
            
        }
        
        Style.loadTheme()
        
        refresher = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refresher.addTarget(self, action: #selector(getter: settingsVC.darkmodeSwitch), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refresher)
        
        // all the labels, backgrounds etc that will change during dark mode
        
        usernameLabel.textColor = Style.sectionHeaderTitleColor
        removeadsLabel.textColor = Style.sectionHeaderTitleColor
        fullAccessLabel.textColor = Style.sectionHeaderTitleColor
        fullAccessSubLabel.textColor = Style.sectionHeaderTitleColor
        darkmodeLabel.textColor = Style.sectionHeaderTitleColor
        weightLabel.textColor = Style.sectionHeaderTitleColor
        volumeLabel.textColor = Style.sectionHeaderTitleColor
        rateLabel.textColor = Style.sectionHeaderTitleColor
        aboutLabel.textColor = Style.sectionHeaderTitleColor
        
        
               
    
        

        }

  
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        usernameLabel.textColor = Style.sectionHeaderTitleColor
        removeadsLabel.textColor = Style.sectionHeaderTitleColor
        fullAccessLabel.textColor = Style.sectionHeaderTitleColor
        fullAccessSubLabel.textColor = Style.sectionHeaderTitleColor
        darkmodeLabel.textColor = Style.sectionHeaderTitleColor
        weightLabel.textColor = Style.sectionHeaderTitleColor
        volumeLabel.textColor = Style.sectionHeaderTitleColor
        rateLabel.textColor = Style.sectionHeaderTitleColor
        aboutLabel.textColor = Style.sectionHeaderTitleColor
        

        
    }
    
    
    
    
    
    
    //style switch
    
    @IBAction func darkmodeSwitchPressed(_ sender: Any) {
        
        if darkmodeSwitch.isOn == false {
            
            let defaultTheme = UserDefaults.standard
            defaultTheme.set(true, forKey: "defaultTheme")
            
            let blackTheme = UserDefaults.standard
            blackTheme.set(false, forKey: "blackTheme")
            
            let defaults = UserDefaults.standard
            defaults.set("defaultTheme", forKey: "Theme")
            
            Style.defaultTheme()
            
            
        } else {
            if darkmodeSwitch.isOn == true {
                
                let blackTheme = UserDefaults.standard
                blackTheme.set(true, forKey: "blackTheme")
                
                
                let defaultTheme = UserDefaults.standard
                defaultTheme.set(false, forKey: "defaultTheme")
                
                let defaults = UserDefaults.standard
                defaults.set("blackTheme", forKey: "Theme")
                
                Style.blackTheme()
                
                
            }
        }
        
        tableView.reloadData()
        
        refresher.endRefreshing()
        
        
    }
    
    
    

    
    //remove excess cells
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
    }
    
    

    //rate button
    @IBAction func rateButtonPressed(_ sender: Any) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                print("Open \(self.url): \(success)")
            })
            
        }
        
    }
    
    


}
