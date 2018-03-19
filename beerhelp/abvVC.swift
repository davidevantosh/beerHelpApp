//
//  abvVC.swift
//  beerhelp
//
//  Created by David Tosh on 1/08/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import UIKit

class abvVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalGravityLabel: UITextField!
    @IBOutlet weak var finalGravityLabel: UITextField!
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var calculationFinal: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //curves on view
        
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true

        
        
        
        
        originalGravityLabel.delegate = self
        finalGravityLabel.delegate = self
        
    }

    
    
    // close the popup
    
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    //clear fields
    
    @IBAction func clearButton(_ sender: Any) {
        originalGravityLabel.text = ""
        finalGravityLabel.text = ""
        calculationFinal.text = ""
    }
    
    
   
    //calculate the ABV
    
    @IBAction func calculatePressed(_ sender: Any) {
        
        if originalGravityLabel.text == nil {
            originalGravityLabel.text = "0.000"
        }
        
        if finalGravityLabel.text == nil {
            finalGravityLabel.text = "0.00"
            
        }
        
            
            let originalgravity = Float(originalGravityLabel.text!)
            let finalgravity = Float(finalGravityLabel.text!)
            
            calculationFinal.text = String(format: "%.2f",(originalgravity! - finalgravity!)*131.25) + "%"
            
            originalGravityLabel.resignFirstResponder()
            finalGravityLabel.resignFirstResponder()
    
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
    // restrictions on text field number of characters
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 5
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // dismiss keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        originalGravityLabel.resignFirstResponder()
        finalGravityLabel.resignFirstResponder()
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
