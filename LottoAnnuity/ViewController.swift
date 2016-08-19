//
//  ViewController.swift
//  LottoAnnuity
//
//  Created by Lamar Greene on 12/17/15.
//  Copyright © 2015 Lamar Greene. All rights reserved.
//

import UIKit

extension Float {
    var asLocalCurrency: String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        formatter.maximumFractionDigits = 0
        return formatter.string(from: self)!
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    var allPayments = ""
    var currentPayment = ""
    var selectedLottery = MEGA
    var printInstallment: Float = 0.0
    var firstPayment: Float = 0.0
    
    
    @IBOutlet weak var lotteryLabel: UILabel!
    
    @IBOutlet weak var lotteryJackpot: UITextField!
    
    @IBOutlet weak var annuityText: UILabel!
    
    @IBOutlet weak var lotterySelection: UISegmentedControl!
    
    @IBAction func setLottery(sender: AnyObject) {
        if lotterySelection.selectedSegmentIndex == 0 {
            selectedLottery = MEGA
            lotteryJackpot.text = formatLotterJackpotText(forLottery: selectedLottery)
            setPaymentText()
        } else {
            selectedLottery = POWER
            lotteryJackpot.text = formatLotterJackpotText(forLottery: selectedLottery)
            setPaymentText()
        }
        updateData()
    }
    
    @IBOutlet weak var stepperLabel: UILabel!
    
    @IBOutlet weak var stepperControl: UIStepper!
    
    @IBAction func stepperCount(sender: AnyObject) {
        stepperLabel.text = String(Int(stepperControl.value))
        
    }

    override func viewWillAppear(_ animated: Bool) {
        getLotteryJackpotValue(lottery: MEGA) { (result) in
            self.updateData()
        }
        
        getLotteryJackpotValue(lottery: POWER) { (result) in
            self.updateData()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatePayments(lottery: MEGA)  // for new calculations
        lotteryJackpot.text = "0"
        self.lotteryLabel.text = "$0"
        
        self.stepperLabel.text = String(Int(self.stepperControl.value))
        self.lotteryJackpot.delegate = self
        self.lotteryJackpot.addTarget(self, action: #selector(ViewController.setPaymentText), for: UIControlEvents.editingChanged)
        self.lotteryJackpot.textColor = UIColor.red  //(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // print(lotteryJackpot.text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func updateData(){
        allPayments = ""
        calcs()
    }
    
    
    func setPaymentText(){
        if lotteryJackpot.text == "" {
            lotteryLabel.text = "$0"
        } else {
            if let oand = Float(lotteryJackpot.text!) {
                lotteryLabel.text = oand.asLocalCurrency
                updateData()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func calcs(){
        
        let payments = 30
        
        let annuityValue: Double = Double(lotteryJackpot.text!)!
        
        var initialPayment:Double {
            return annuityValue * selectedLottery.initialPercent
        }
        var totalValue: Double = initialPayment
        var annuityPayment: Double = initialPayment
        
        
        if stepperControl.value > 1 {
            firstPayment = Float(initialPayment * 0.71)/Float(stepperControl.value)
        } else {
            firstPayment = Float(initialPayment * 0.71)
        }
        
        allPayments = "Payment 1: \(firstPayment.asLocalCurrency)\n"
        
        func calcPayments() {
            for i in 1..<payments {
                annuityPayment = annuityPayment * selectedLottery.percentIncrease
                totalValue += annuityPayment;
                
                if stepperControl.value > 1 {
                    printInstallment = Float(annuityPayment * 0.71)/Float(stepperControl.value)
                } else {
                    printInstallment = Float(annuityPayment * 0.71)
                }
                
                currentPayment = " \(self.printInstallment.asLocalCurrency) \n"
                // print(currentPayment)
                allPayments = allPayments + currentPayment
                
                // append to array
                installmentPayments.append(allPayments)
            }
            
            //print(">>>>>>\(totalValue)")
        }
        
        calcPayments()
        
        annuityText.text = allPayments
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    
    func theAlert() {
        
        let anAlert = UIAlertController(title: "fuck me", message: "now", preferredStyle: .alert)
        let anAction = UIAlertAction(title: "do it", style: .default, handler: nil)
        anAlert.addAction(anAction)
        self.present(anAlert, animated: true, completion: nil)
        
    }
    
    
}

