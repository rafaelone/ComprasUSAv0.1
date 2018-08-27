//
//  SettingsViewController.swift
//  ComprasUSA
//
//  Created by Desenvolvimento on 23/08/18.
//  Copyright © 2018 FIAP. All rights reserved.
//

import UIKit
import CoreData
class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    var fetchedResultController: NSFetchedResultsController<State>!
    var listaEstados:[State] = []
    var produto: Product!
    let numberFormatter = NumberFormatter()
    
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
//        print(listaEstados)
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
            estado.imposto = 0
            do{
                try self.context.save()
//                self.tbEstado.reloadData()
                
            }catch{print(error.localizedDescription)}
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nome do estado"
            textField.text = estado?.nome
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Imposto"
            estado?.imposto  = self.numberFormatter.number(from: textField.text!)?.doubleValue ?? 0
//            textField.text = Double(estado?.imposto) ?? 0
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(confirmar)
        alert.addAction(cancelar)
        
        present(alert, animated: true, completion: nil)
    }
    
    func carregaEstados(){
        let fetchRequest: NSFetchRequest<State> = State.fetchRequest()
        let ordenaNome = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [ordenaNome]
        do{
            listaEstados = try context.fetch(fetchRequest)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func saveDolarIof(){
        view.endEditing(true)
        guard let dolar = txDolar.text else {return}
        guard let iof = txIof.text else {return}
        ud.set(dolar, forKey: "dolar")
        ud.set(iof, forKey: "iof")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaEstados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tbEstado.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! EstadoTableViewCell
        cell.txEstado.text = listaEstados[indexPath.row].nome
        cell.txValor.text = "\(listaEstados[indexPath.row].imposto)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleta = UITableViewRowAction(style: .destructive, title: "Excluir") { (action, indexPath) in
            let estado = self.listaEstados[indexPath.row]
//            self.produto.removeFromEstados(estado)
            self.context.delete(estado)
            do{
                try self.context.save()
                self.listaEstados.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            
            }catch{
                print(error.localizedDescription)
                
            }
            
        }
        
        let edita = UITableViewRowAction(style: .default, title: "Editar") { (action, indexPath) in
            let estado = self.listaEstados[indexPath.row]
            self.showAlert(estado: estado)
            tableView.setEditing(false, animated: true)
        }
        edita.backgroundColor = .blue
        return [deleta, edita]
    }
    
    
}





extension SettingsViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveDolarIof()
        return true
    }
}

extension SettingsViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tbEstado.reloadData()
    }
}




