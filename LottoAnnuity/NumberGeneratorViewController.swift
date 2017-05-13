//
//  NumberGeneratorViewController.swift
//  LottoAnnuity
//
//  Created by Lamar Greene on 11/6/16.
//  Copyright © 2016 Lamar Greene. All rights reserved.
//

import UIKit

class NumberGeneratorViewController: UIViewController {
    
    @IBAction func GenerateRandom(_ sender: UIButton) {
        pickDisplay = ""
        pickMegaNumbers()
        pickPowerNumbers()
        randomLottoPicks.text = pickDisplay
        
    }
    
    
    @IBOutlet weak var randomLottoPicks: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        pickMegaNumbers()
        pickPowerNumbers()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        randomLottoPicks.text = pickDisplay
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
