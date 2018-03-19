//
//  hydroVC.swift
//  beerhelp
//
//  Created by David Tosh on 10/08/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import UIKit

class hydroVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var hydroLabel: UILabel!
    @IBOutlet weak var hydroCalcLabel: UILabel!
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var hydroText: UITextField!
    @IBOutlet weak var wortText: UITextField!
    @IBOutlet weak var hydroCalText: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // curves on view
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        hydroText.delegate = self
        wortText.delegate = self
        hydroCalText.delegate = self
        
    }

    
    //close popup
    
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //clear fields
    
    @IBAction func clearFields(_ sender: Any) {
        hydroText.text = ""
        hydroCalText.text = ""
        wortText.text = ""
        calculationLabel.text = ""
        
    }
    
    
    
    
    // calculate hydro adjustment
    
    @IBAction func calculatePressed(_ sender: Any) {
        
        //celcius
        
        if hydroText.text == nil {
            hydroText.text = "0.000"
        }
        
        if wortText.text == nil {
            wortText.text = "0"
            
        }
        
        if hydroCalText.text == nil {
            hydroCalText.text = "0"
            
        }
        
        
        let hydroreading = Float(hydroText.text!)
        let tempreading = Float(wortText.text!)
        let calreading = Float(hydroCalText.text!)
        let celciusTemp = Float((tempreading!*1.8)+32)
        let calculatedCelciusTemp = Float((calreading!*1.8)+32)
        
        //breakdown of calculation
        
        let partOne = Float(1.00130346-0.000134722124 * celciusTemp)
        let partTwo = Float(0.00000204052596 * (celciusTemp * celciusTemp))
        let partThree = Float(0.00000000232820948 * (celciusTemp * celciusTemp * celciusTemp))
        
        let partFour = Float(1.00130346 - 0.000134722124 * calculatedCelciusTemp)
        let partFive = Float(0.00000204052596 * (calculatedCelciusTemp * calculatedCelciusTemp))
        let partSix = Float(0.00000000232820948 * (calculatedCelciusTemp * calculatedCelciusTemp * calculatedCelciusTemp))
        
        // calculation answer
        
        let answerFinal = Float(hydroreading! * (partOne + partTwo - partThree) / (partFour + partFive - partSix))
        
        
        // the answer
        
        calculationLabel.text = String(format: "%.3f", answerFinal)
        
        
        hydroText.resignFirstResponder()
        wortText.resignFirstResponder()
        hydroCalText.resignFirstResponder()

        
    }
    
    


    // text restrictions
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 5
    }
    
    
    
        //dismiss keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hydroText.resignFirstResponder()
        wortText.resignFirstResponder()
        hydroCalText.resignFirstResponder()
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
