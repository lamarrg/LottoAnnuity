//
//  LottoData.swift
//  lotto value
//
//  Created by Lamar Greene on 8/13/16.
//  Copyright © 2016 Lamar Greene. All rights reserved.
//

import Foundation
import UIKit

var installmentPayments = [String]()


var manualEntry = true // why is this here?!?! check use on viewcontroller

// extension to create currency display

extension Float {
    var asLocalCurrency: String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        formatter.maximumFractionDigits = 0
        return formatter.string(from: self as NSNumber)!
    }
}

// important info for each lottery version

struct LottoChoice {
    let name: String
    let initialPercent: Double
    let percentIncrease: Double
    var jackpot: Double
    let jackpotURL: String
    let stringSeparator1: String
    let stringSeparator2: String
}


// set struct for each lottery

var MEGA = LottoChoice(name: "mega", initialPercent: 0.0150514350803, percentIncrease: 1.05, jackpot: 15000000.0, jackpotURL: "http://www.megamillions.com", stringSeparator1: "<div class=\"home-next-drawing-estimated-jackpot-dollar-amount\">", stringSeparator2: "</div>")

var POWER = LottoChoice(name: "power", initialPercent: 0.017830099134, percentIncrease: 1.04, jackpot: 40000000.0, jackpotURL: "http://www.powerball.com", stringSeparator1: "<h1>$", stringSeparator2: "&nbsp;")



// >>>> should probably put a completion handler on here so updateDate() does not fire until this is complete <<<

func formatLotterJackpotText(forLottery: LottoChoice) -> String {
    let kerry = NSString(string: "\(forLottery.jackpot)" as String).components(separatedBy: ".")
    
    return "\(kerry[0])"
    
}




func calculatePayments(lottery: LottoChoice, stepperValue: UIStepper ) {
    // calculates annuitized payments for mega or power lottery
    
    installmentPayments.removeAll()
    let payments = 29
    let initialpayment = lottery.jackpot * lottery.initialPercent
    var annuityPayment = initialpayment
    var total = initialpayment
    installmentPayments.append(String(Float(annuityPayment/stepperValue.value).asLocalCurrency))
    
    for _ in 1...payments {
        
        annuityPayment = annuityPayment * lottery.percentIncrease
        total += annuityPayment
        installmentPayments.append(String(Float(annuityPayment/stepperValue.value).asLocalCurrency))
    }
}


func calculatePaymentsManual(lottery: LottoChoice, stepperValue: UIStepper, manualValue: String) {
    // calculates annuitized payments for manually input lottery value. assumes 5% increase.
    
    installmentPayments.removeAll()
    let payments = 29
    let initialpayment = Double(manualValue)! * 0.0150514350803
    var annuityPayment = initialpayment
    var total = initialpayment
    installmentPayments.append(String(Float(annuityPayment/stepperValue.value).asLocalCurrency))
    
    for _ in 1...payments {
        
        annuityPayment = annuityPayment * 1.05
        total += annuityPayment
        installmentPayments.append(String(Float(annuityPayment/stepperValue.value).asLocalCurrency))
    }
}



func getLotteryJackpotValue(lottery: LottoChoice, completion: @escaping (_ result: Bool) -> Void) {
    // retrieves current annuitized lottery value from relevant website, and applies to struct. if unavailable, struct will not update, will display lowest lottery value (default)
    
    if let url = URL(string: lottery.jackpotURL) {
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var message = ""
            
            if error != nil {
                print(error)
            } else {
                
                if let unwrappedData = data {
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                   
                    var stringSeparator = lottery.stringSeparator1
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeparator = lottery.stringSeparator2
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            
                            if newContentArray.count > 1 {
                                
                                message = String(newContentArray[0]+"000000")
                                
                                if lottery.name == "mega" {
                                    
                                    MEGA.jackpot = Double(message)!
                                    
                                } else if lottery.name == "power"{
                                    
                                    POWER.jackpot = Double(message)!
                                    
                                }
                                
                                completion(true)
                                
                            }
                        }
                    }
                }
            }
            
            if message == "" {
                
                message = "The lotto data could not be found. Please try again."
                
            }
            
            DispatchQueue.main.sync(execute: {
                
                //self.resultLabel.text = message
                
            })
        }
        
        task.resume()
        
    } else {
        
        //resultLabel.text = "The weather there couldn't be found. Please try again."
        
    } 
}
