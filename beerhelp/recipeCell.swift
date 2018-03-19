//
//  recipeCell.swift
//  beerhelp
//
//  Created by David Tosh on 16/08/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import UIKit
import CoreData

class recipeCell: UITableViewCell, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var labelTest: UILabel!
    
    @IBOutlet weak var sectionLabel: UILabel!
    
     var controller: NSFetchedResultsController<Item>!
    
    
    func configureCell(item: Item) {
        
        
        label.text = item.ingredientName
        labelTest.text = item.type
    }

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
