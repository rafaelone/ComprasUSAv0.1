//
//  SettingsViewController.swift
//  ComprasUSA
//
//  Created by Desenvolvimento on 23/08/18.
//  Copyright © 2018 FIAP. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var txDolar: UITextField!
    @IBOutlet weak var txIof: UITextField!
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        saveDolar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txDolar.text = ud.string(forKey: "dolar")
    }
    
    
    func saveDolar(){
        guard let dolar = txDolar.text else {return}
//        view.endEditing(true)
//        ud.set(txDolar.text!, forKey: "dolar")
        if dolar != nil {
            txDolar.keyboardType = UIKeyboardType.numberPad
            ud.set(dolar, forKey: "dolar")
        } else{
            return
        }
    }

}

extension SettingsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveDolar()
        return true
    }
}