//
//  SettingsViewController.swift
//  ComprasUSA
//
//  Created by Desenvolvimento on 23/08/18.
//  Copyright © 2018 FIAP. All rights reserved.
//

import UIKit
import CoreData
class SettingsViewController: UIViewController  {
    
//    , UITableViewDataSource, UITableViewDelegate
    var fetchedResultController: NSFetchedResultsController<State>!
    var estados: [State] = []
    
    @IBOutlet weak var txDolar: UITextField!
    @IBOutlet weak var txIof: UITextField!
    @IBOutlet weak var tbEstado: UITableView!
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Lista de estados vazia."
        label.textAlignment = .center
        label.textColor = UIColor.gray
        return label
    }()
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txDolar.keyboardType = UIKeyboardType.numberPad
        txIof.keyboardType = UIKeyboardType.numberPad
                carregaEstados()
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
    
    @IBAction func addEstado(_ sender: UIButton) {
        showAlert(estado: nil)
    }
    
    func showAlert(estado: State?){
        let title = estado == nil ? "Adicionar Estado" : "Atualizar Estado"
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        let confirmar = UIAlertAction(title: "Adicionar", style: .default) { (action) in
            let nomeEstado = alert.textFields![0].text
//            let impostoEstado = alert.textFields![1].text
            let estado = estado ?? State(context: self.context)
            estado.nome = nomeEstado
//            estado.imposto = Double(impostoEstado)!
            do{
                try self.context.save()
//                self.loadEstados()
            }catch{print(error.localizedDescription)}
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nome do estado"
            textField.text = estado?.nome
        }
//        alert.addTextField { (textField) in
//            textField.placeholder = "Imposto"
//            textField.text = estado?.imposto ?? 0
//        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(confirmar)
        alert.addAction(cancelar)
        
        present(alert, animated: true, completion: nil)
    }
    
    func carregaEstados(){
        let fetchRequest: NSFetchRequest<State> = State.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do{
            estados = try context.fetch(fetchRequest)
//            tableView.reloadData()
        }catch{print(error.localizedDescription)}
    }
    
    
    
    
    
    
    func saveDolarIof(){
        view.endEditing(true)
        guard let dolar = txDolar.text else {return}
        guard let iof = txIof.text else {return}
        ud.set(dolar, forKey: "dolar")
        ud.set(iof, forKey: "iof")
        
    }
    
    
    
    
}





extension SettingsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveDolarIof()
        return true
    }
}

//extension SettingsViewController: NSFetchedResultsControllerDelegate {
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.reloadData()
//    }
//}




