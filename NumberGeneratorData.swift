//
//  NumberGeneratorData.swift
//  LottoAnnuity
//
//  Created by Lamar Greene on 11/6/16.
//  Copyright © 2016 Lamar Greene. All rights reserved.
//

import Foundation
import UIKit


var megamillionsPick = [Int]()
var powerballPick = [Int]()
var texasLottoPick = [Int]()
var pickDisplay = ""


//override func viewDidLoad() {
//    super.viewDidLoad()
//    pickDisplay = ""
//    
//}

func pickMegaNumbers(){
    
    megamillionsPick.removeAll()
    
    repeat {
        
        let megaNum = generateRandomNumber(75)
        
        if !megamillionsPick.contains(megaNum) {
            
            megamillionsPick.append(megaNum)
        }
        
    } while (megamillionsPick.count < 5);
    
    pickDisplay += "MegaMillions draw numbers are\n\(megamillionsPick)\nAnd the megaNumber is... \(generateRandomNumber(15))\n\n"
    print("MegaMillions draw numbers are \(megamillionsPick)\nAnd the megaNumber is... \(generateRandomNumber(15))\n\n")
   // numDisplay.text = pickDisplay
}

func pickPowerNumbers(){
    
    powerballPick.removeAll()
    
    repeat {
        
        let megaNum = generateRandomNumber(69)
        
        if !powerballPick.contains(megaNum) {
            
            powerballPick.append(megaNum)
        }
        
    } while (powerballPick.count < 5);
    
    pickDisplay += "Powerball draw numbers are\n\(powerballPick)\nAnd the Power Ball is... \(generateRandomNumber(26))\n\n"
    print("Powerball draw numbers are \(powerballPick)\nAnd the Power Ball is... \(generateRandomNumber(26))")
   // numDisplay.text = pickDisplay
}

func pickTXLottoNumbers(){
    
    texasLottoPick.removeAll()
    
    repeat {
        
        let megaNum = generateRandomNumber(54)
        
        if !texasLottoPick.contains(megaNum) {
            
            texasLottoPick.append(megaNum)
        }
        
    } while (texasLottoPick.count < 6);
    
    pickDisplay += "Texas Lotto draw numbers are \(texasLottoPick)\n"
    print("Texas Lotto draw numbers are \(texasLottoPick)\n")
   // numDisplay.text = pickDisplay
}


func generateRandomNumber(_ theVariable: UInt32) -> Int {
    let generatedNum = Int(arc4random_uniform(theVariable) + 1)
    return generatedNum
}


