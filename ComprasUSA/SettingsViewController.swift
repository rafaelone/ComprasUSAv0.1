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
        txDolar.keyboardType = UIKeyboardType.numberPad
        txIof.keyboardType = UIKeyboardType.numberPad
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        saveDolarIof()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txDolar.text = ud.string(forKey: "dolar")
         txIof.text = ud.string(forKey: "iof")
    }
    
    
    func saveDolarIof(){
         view.endEditing(true)
        guard let dolar = txDolar.text else {return}
        guard let iof = txIof.text else {return}
        
        ud.set(dolar, forKey: "dolar")
        ud.set(iof, forKey: "iof")
//        if dolar != nil {
//            txDolar.keyboardType = UIKeyboardType.numberPad
//            ud.set(dolar, forKey: "dolar")
//        } else{
//            return
//        }
    }
    


}

extension SettingsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveDolarIof()
        return true
    }
}
