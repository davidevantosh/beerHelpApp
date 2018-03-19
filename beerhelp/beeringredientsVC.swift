//
//  beeringredientsVC.swift
//  beerhelp
//
//  Created by David Tosh on 4/09/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import UIKit
import CoreData

class beeringredientsVC: UIViewController, UITableViewDelegate, UITableViewDataSource,ExpandableHeaderViewDelegate {

    
    @IBOutlet weak var ingredientsTableView: UITableView!




    
    
    
    
    
    var headerTitles = [Section(type: "Grain", item: ["pilsner", "american", "german", "amber", "stout", "porter"], expanded: false), Section(type: "Hops", item: ["david", "tebow", "sambam"], expanded: false), Section(type: "Yeast", item: ["david", "tebow", "sambam"], expanded: false), Section(type: "Other", item: ["david", "tebow", "sambam"], expanded: false)]
    
    
    var labelCell = [String]()
    
    var itemToEdit: Item?
    
    var grainCell: grainCell?
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        
     //   popupView.layer.cornerRadius = 10
      //  popupView.layer.masksToBounds = true
        
        //allow multiple row selection
        
    //    self.ingredientsTableView.allowsMultipleSelection = true

        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerTitles[section].item.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (headerTitles[indexPath.section].expanded) {
            return 44
        } else {
            
        return 0
    }
        
    }
        
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: headerTitles[section].type, section: section, delegate: self)
        return header
    }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")! as! grainCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        
        
        
        //cell.textLabel?.text = headerTitles[indexPath.section].item[indexPath.row]
        cell.textLabel?.text = headerTitles[indexPath.section].item[indexPath.row]
    //    cell.accessoryType = cell.isSelected ? .checkmark : .none
       // cell.selectionStyle = .none // to prevent cells from being "highlighted"
        
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        headerTitles[section].expanded = !headerTitles[section].expanded
        
        ingredientsTableView.beginUpdates()
        for i in 0 ..< headerTitles[section].item.count {
            ingredientsTableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        ingredientsTableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  ingredientsTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = headerTitles[indexPath.section].item[indexPath.row]
        
        
        
        var item: Item!
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
        item = itemToEdit
    }
    
        if let ingredientName = cell.textLabel?.text {
           item.ingredientName = ingredientName
            print("this is the ingredient", ingredientName)
        }
        
     //   if recipeCell?.label.text != String("tebow") {
            
     //   if let type = String("hops") {
     //       item.type = type
        
     //   }
        
      //  } else {
            
       //     if let type = String("grain") {
        //        item.type = type
         //       }
      //  }
        
      //  cell.textLabel?.text = String(describing: headerTitles[indexPath.section])
        
     //   if let type =  cell.textLabel?.text {
      //      item.type = type
            
       //     print("this is also the type", type)
     //   }
        
        if cell.textLabel?.text == String("david") {
            if let type = String("roses") {
                item.type = type
                
                print(type)
            }
            
        } else {
            
            if let type = String("guns") {
                item.type = type
                
                print(type)
            }
        }
        

        
        
    
        
       
        
     
        adt.saveContext()
       
        
        performSegue(withIdentifier: "dataPass", sender: self)
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //ingredientsTableView.cellForRow(at: indexPath)?.accessoryType = .none
        
        
    }
    
    
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
    }
    
    //pan gesture
    
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    
    
    
    
    
    


    
    
    
    
    
    
    
    
    
   
    
   
    
    
    
  
        
    

    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    }
