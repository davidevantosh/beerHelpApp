//
//  BeerStyleVC.swift
//  beerhelp
//
//  Created by David Tosh on 21/08/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import UIKit
import CoreData

class BeerStyleVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var styleTableview: UITableView!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    let style : [String] = ["American", "German", "Pilsner", "Stout", "Porter", "Lager"]
    
 //   let sectionTitle = ["Style"]
    
    //var selectedLabel:String?
    var itemToEdit: Item?
    var stylecell = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    //curves on view
        
    popupView.layer.cornerRadius = 10
    popupView.layer.masksToBounds = true
        
    styleTableview.delegate = self
    styleTableview.dataSource = self
        
        
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stylecell", for: indexPath) as! styleCell
     cell.textLabel?.text = style[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return style.count
    }
    
    
   // func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
   //     return sectionTitle[section]
 //   }
    
 //   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // print("Row \(style[indexPath.row])selected")
       // selectedLabel = style[indexPath.row]
        
       
        
      //  performSegue(withIdentifier: "detailView", sender: self)
        
   //     let cell = tableView.dequeueReusableCell(withIdentifier: "stylecell")!
   //     cell.textLabel?.text = style[indexPath.row]
        
  //      var item: Item!
        
   //     if itemToEdit == nil {
   //         item = Item(context: context)
   //     } else {
    //        item = itemToEdit
    //    }
        
    //    if let styleName = cell.textLabel?.text {
    //        item.style = styleName
    //        print("this is the style selected", styleName)
    //    }
        
     //   adt.saveContext()
        
    //    performSegue(withIdentifier: "detailView", sender: self)
        
 //   }
 
   // func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
  //      if(segue.identifier == "detailView") {
  //         let vc = segue.destination as! mainVC
   //         vc.testingLabel = selectedLabel!
   //    }
  //  }
    
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
