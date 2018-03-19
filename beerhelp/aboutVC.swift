//
//  aboutVC.swift
//  beerhelp
//
//  Created by David Tosh on 31/08/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import UIKit

class aboutVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var bulkText: UILabel!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var websiteText: UITextView!
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    // curves on view
        
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        //links
        
        let linkAttributes = [NSLinkAttributeName: NSURL(string: "http://www.david-tosh.com")!, NSForegroundColorAttributeName: UIColor.blue, NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)] as [String : Any]
        
        let attributedString = NSMutableAttributedString(string: "david-tosh.com", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular), NSForegroundColorAttributeName: UIColor.blue])
        
    
        
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(0, 14))
        
        
        self.websiteText.delegate = self
        self.websiteText.attributedText = attributedString
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //close the popup
    
    @IBAction func closePressed(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
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
