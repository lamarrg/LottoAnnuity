//
//  ViewController.swift
//  LottoAnnuity
//
//  Created by Lamar Greene on 12/17/15.
//  Copyright © 2015 Lamar Greene. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var allPayments = ""
    var currentPayment = ""
    var selectedLottery = MEGA
    var printInstallment: Float = 0.0
    var firstPayment: Float = 0.0
    
    @IBOutlet weak var table: UITableView!
    
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
        // sets how many people the jackpot will be devided between
        
        stepperLabel.text = String(Int(stepperControl.value))
        updateData()
    }

    override func viewWillAppear(_ animated: Bool) {
        // calls function to retrieve current lottery jackpots from website. if not avail, they will default to minimum values
        
        getLotteryJackpotValue(lottery: MEGA) { (result) in
        }
        
        getLotteryJackpotValue(lottery: POWER) { (result) in
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets initial text value
        
        lotteryJackpot.text = "0"
        self.lotteryLabel.text = "$0"
        
        // sets text field delegate
        self.stepperLabel.text = String(Int(self.stepperControl.value))
        self.lotteryJackpot.delegate = self
        self.lotteryJackpot.addTarget(self, action: #selector(ViewController.setPaymentText), for: UIControlEvents.editingChanged)
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func updateData(){
        // calls function to calculate the annual payments and update the tableview
        
        if manualEntry == true {
            calculatePaymentsManual(lottery: selectedLottery, stepperValue: stepperControl, manualValue: lotteryJackpot.text!)
        } else {
            calculatePayments(lottery: selectedLottery, stepperValue: stepperControl)
        }
            table.reloadData()
    }
    
    
    func setPaymentText(){
        // sets text value for lottery fields
        
        if lotteryJackpot.text == "" || lotteryJackpot.text == "0" {
            lotteryJackpot.text = "0"
            lotteryLabel.text = "$0"
        } else {
            if let textValue = Float(lotteryJackpot.text!) {
                lotteryLabel.text = textValue.asLocalCurrency
            updateData()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

//MARK:- TABLEVIEW FUNCTIONS
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return installmentPayments.count
    
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "Payment \(indexPath.row+1): \(installmentPayments[indexPath.row])"
        return cell
    }
    
}

