//
//  calculatorsVC.swift
//  beerhelp
//
//  Created by David Tosh on 19/07/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import UIKit

class calculatorsVC: UITableViewController, UINavigationControllerDelegate {
    
    var loadTheme: Bool = {
        Style.loadTheme()
        return true
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Style.loadTheme()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
    }

    
    
}
