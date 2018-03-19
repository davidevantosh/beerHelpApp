//
//  mainVC.swift
//  beerhelp
//
//  Created by David Tosh on 19/07/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import UIKit
import Firebase
import CoreData


class NameCell: UITableViewCell {
}
class BatchCell: UITableViewCell {
}
class BoilCell: UITableViewCell {
}
class EfficiencyCell: UITableViewCell {
}
class StyleSelectCell: UITableViewCell {
}

class mainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate {
    
    //section 1
    
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var beerStyleButtton: UIButton!
    @IBOutlet weak var testTwo: UILabel!
    
    @IBOutlet weak var addIngredient: UIBarButtonItem!
    
    
    // tableview 1



    
    
    //tableview 2
    
    @IBOutlet weak var recipeView: UITableView!
    @IBOutlet weak var detailsTableview: UITableView!
    
    
    //section 2
   
    
    
    
    // popup
    @IBOutlet weak var stylePopup: UIView!
    @IBOutlet weak var styleButton: UIButton!
    @IBOutlet weak var gravityLabel: UILabel!
    @IBOutlet weak var bitternessLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var estAbvLabel: UILabel!
    @IBOutlet weak var gravitySlider: UISlider!
    @IBOutlet weak var bitternessSlider: UISlider!
    @IBOutlet weak var colorSlider: UISlider!
    @IBOutlet weak var estAbvSlider: UISlider!
    
    
    
//    let data = [["pilsner", "american", "german", "amber", "stout", "porter"],["david", "tebow", "sambam"]]
   
    
    var testingLabel: String = ""
    
    
    var labelCell = [String]()
    var sytlecell = [String]()
    
    //core data
    
    var controller: NSFetchedResultsController<Item>!
    
    var names = ["Grain": ["german", "stout"], "Hops": ["samantha", "tebow"]]
    
    struct Objects {
        
        var sectionName: String!
        var sectionObjects : [String]!
        
    }
    
    var objectArray = [Objects]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
     //   testTwo.text = testingLabel
        
        stylePopup.isHidden = true
        
        stylePopup.layer.cornerRadius = 10
        stylePopup.layer.masksToBounds = true
        
        //tableviews
        
        recipeView.delegate = self
        recipeView.dataSource = self
        detailsTableview.delegate = self
        detailsTableview.dataSource = self
        
    //   parseBeerCSV()
        
        attemptFetch()
        
        //sections
        
        for (key, value) in names {
            print("\(key) -> \(value)")
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }
    }

    
    // parsing data from the csv file
    
//    func parseBeerCSV(){
        
    //    let path = Bundle.main.path(forResource: "beer mac csv", ofType: "csv")!
  //
  //      do {
            
    //        let csv = try CSV(contentsOfURL: path)
    //        let rows = csv.rows
     //       print(rows)
            
      //      for row in rows {
                
      //          let beerName = row["identifier"]!
      //          let orgGravMin = row["og_min"]!
      //          let orgGravMax = row["og_max"]!
      //          let ibuMin = row["ibu_min"]!
      //          let ibuMax = row["ibu_max"]!
       //         let colorMin = row["colour_min"]!
       //         let colorMax = row["colour_max"]!
      //          let abvMin = row["abv_min"]!
      //          let abvMax = row["abv_max"]!
                
       //         if testTwo.text == beerName {
       //             testLabel.text = orgGravMin
        //            gravitySlider.minimumValue = Float(orgGravMin)!
       //             gravitySlider.maximumValue = Float(orgGravMax)!
       //             gravitySlider.value = Float("1.046")!
                    
       //             bitternessSlider.minimumValue = Float(ibuMin)!
        //            bitternessSlider.maximumValue = Float(ibuMax)!
                    
                    
         //           colorSlider.minimumValue = Float(colorMin)!
         //           colorSlider.maximumValue = Float(colorMax)!
                   
                    
         //           estAbvSlider.minimumValue = Float(abvMin)!
        //            estAbvSlider.maximumValue = Float(abvMax)!
                    
                    
         //       }

                
      //      }
            
    //    } catch let err as NSError {
    
     //       print(err.debugDescription)
        
 //   }
 //   }
    
    
    func configureCell(cell: recipeCell, indexPath: NSIndexPath) {
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == detailsTableview {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! nameCell
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "batchCell") as! batchCell
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "boilCell") as! boilCell
                return cell
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "efficiencyCell") as! efficiencyCell
                return cell
            } else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "styleselectCell") as! styleselectCell
                return cell
            }
        }
                
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as! recipeCell
            configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            return cell
        }
    


    
 //   func configureCellStyle(cell: styleSelectCell, indexPath: NSIndexPath) {
   //     let item = controller.object(at: indexPath as IndexPath)
  //      cell.configureCellStyle(item: item)
 //   }
    
    
   //height of the header in each section
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == detailsTableview {
            return 0
        } else {
        return 44.0
        }
    }
    
    
    //number of sections in tableview
        
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == recipeView {
        if let sections = controller.sections {
           return sections.count
          //  return objectArray.count
        }
       return 0
        } else {
            return 1
        }
    }
    
    //number of rows in section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == recipeView {
        
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
        
     //   return objectArray[section].sectionObjects.count
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == recipeView {
        return objectArray[section].sectionName
        } else {
            return nil
    }
    }
    
    
    
    //core data
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "ingredientName", ascending: true)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print ("\(error)")
        }
        
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        recipeView.beginUpdates()
     //   detailsTableview.beginUpdates()
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        recipeView.endUpdates()
     //   detailsTableview.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                
                recipeView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                recipeView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = recipeView.cellForRow(at: indexPath) as! recipeCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
           //     let cellTwo = detailsTableview.cellForRow(at: indexPath) as! styleSelectCell
            //    configureCellStyle(cell: cellTwo, indexPath: indexPath as NSIndexPath)
                
            }
            break
        case.move:
            if let indexPath = indexPath {
                recipeView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                recipeView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
    }

    
    
    
    // moving cells across tableviews
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
  //      if tableView == ingredientsTableView {
   //         let copyAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Pass Data") { (UITableViewRowAction, NSIndexPath) -> Void in
                
          //      print("editActionsForRowAt called")
          //      self.performSegue(withIdentifier: "send", sender: indexPath)
     //   }
     //   return [copyAction]
     //   } else {
     //       return nil
     //   }
//}
    
 //   override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
  //      if segue.identifier == "send" {
            
    //        let selectedIndex = sender as! NSIndexPath
   //         let currentCell = self.ingredientsTableView.cellForRow(at: selectedIndex as IndexPath)! as! grainCell
    //        self.sendSelectedData = (currentCell.textLabel?.text)! as String as NSString
            
    //        print(self.sendSelectedData)
            
    //        labelCell = ([self.sendSelectedData as String])
            
 //       }
        
        
        
//    }
    
    //swipe to delete cell functionality
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView == detailsTableview {
            return UITableViewCellEditingStyle.delete
        } else {
            return UITableViewCellEditingStyle.none
        }
    }
    
    fileprivate func whitespaceString(font: UIFont = UIFont.systemFont(ofSize: 15), width: CGFloat) -> String {
        let kPadding: CGFloat = 20
        let mutable = NSMutableString(string: "")
        let attribute = [NSFontAttributeName: font]
        while mutable.size(attributes: attribute).width < width - (2 * kPadding) {
            mutable.append(" ")
        }
        return mutable as String
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let kCellActionWidth = CGFloat(70.0)
        let kCellHeight = tableView.frame.size.height
        let whitespace = whitespaceString(width: kCellActionWidth)
        
        let deleteAction = UITableViewRowAction(style: .`default`, title: whitespace)
        {_,_ in context.delete((self.controller.fetchedObjects?[indexPath.row])!)
            
            adt.saveContext()
            self.attemptFetch()
            
        }
        
        let view = UIView(frame: CGRect(x: tableView.frame.size.width-70, y: 0, width: 70, height: kCellHeight))
        view.backgroundColor = UIColor(red:73.0/255.0, green: 153.0/255.0, blue: 218.0/255.0, alpha: 1.0) // background color of view
        let imageView = UIImageView(frame: CGRect(x: 17, y: 17.5, width: 35, height: 35))
        
        return [deleteAction]
        
        
        
        
    }

    
  
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    

    
    

    @IBAction func styleButtonPressed(_ sender: Any) {
        
        if stylePopup.isHidden == true {
            stylePopup.isHidden = false
        } else {
            if stylePopup.isHidden == false {
                stylePopup.isHidden = true
            }
        }
        
    }
    
    

}
