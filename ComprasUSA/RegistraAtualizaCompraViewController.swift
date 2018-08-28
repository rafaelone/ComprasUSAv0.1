//
//  RegistraAtualizaCompraViewController.swift
//  ComprasUSA
//
//  Created by Usuário Convidado on 21/08/2018.
//  Copyright © 2018 FIAP. All rights reserved.
//

import UIKit
import CoreData
class RegistraAtualizaCompraViewController: UIViewController {

    @IBOutlet weak var txNome: UITextField!
    @IBOutlet weak var ivFoto: UIImageView!
    @IBOutlet weak var txEstado: UITextField!
    @IBOutlet weak var txValor: UITextField!
    @IBOutlet weak var slCartao: UISwitch!
    @IBOutlet weak var btAddEdit: UIButton!
    
    @IBOutlet weak var lbError: UILabel!
    
    let pickerView = UIPickerView(frame: .zero)
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
    var produto: Product!
    var estado: State!
    var listaEstados:[State] = []
    var fetchedResultController: NSFetchedResultsController<State>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PRINTANDO")
        print(listaEstados)
        pickerView.dataSource = self
        pickerView.delegate = self
        toolBarConfiguracao()
        carregaEstados()
        txValor.keyboardType = UIKeyboardType.numberPad
        if produto != nil {
            txNome.text = produto.title
            ivFoto.image = produto.image as? UIImage
            txValor.text = "\(produto.money)"
            slCartao.setOn(produto.cartao, animated: true)
            btAddEdit.setTitle("Atualizar", for: .normal)
            
        }else{
            produto = Product(context: context)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txValor.keyboardType = UIKeyboardType.numberPad
        txEstado.text = produto.estadosString
    }
    
    
    @IBAction func addEditProduto(_ sender: UIButton) {
        guard let txtNome = txNome.text else {return}
        guard let txDinheiro = txValor.text else {return}
        produto.image = ivFoto.image
      
        
        
       if txtNome != "" && txDinheiro != ""{
            produto.title = txtNome
            produto.image = ivFoto.image
            produto.money = Double(txDinheiro)!
            produto.cartao = slCartao.isOn
            lbError.text = "Produto cadastrado com sucesso"
            do{
                try context.save()
                navigationController?.popViewController(animated: true)
            }catch{
                print(error.localizedDescription)
            }
            
        }else{
            lbError.text = "Todos os campos são obrigatórios"
        
        }
        
    }
    
    // funcao para pegar foto da camera ou biblioteca
    @IBAction func addFoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecionar foto", message: "De onde você gostaria de selecionar a foto ?", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let acaoCamera = UIAlertAction(title: "Camera", style: .default) { (action) in
                self.selecionaFoto(sourceType: .camera)
            }
            alert.addAction(acaoCamera)
        }
        
        let biblioteca = UIAlertAction(title: "Bilioteca de fotos", style: .default) { (action) in
            self.selecionaFoto(sourceType: .photoLibrary)
        }
        alert.addAction(biblioteca)
        

        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelar)
        
        present(alert, animated: true, completion: nil)
    }

    // funcao para selecionar foto
    func selecionaFoto(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func toolBarConfiguracao(){
        let btOk = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(done))
        
        let btSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let btCancel = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancel))
        
        toolbar.backgroundColor = .white
        toolbar.setItems([btCancel, btSpace, btOk], animated: false)
        
        txEstado.inputView = pickerView
        txEstado.inputAccessoryView = toolbar
    }
    @objc func done() {
        let estado = listaEstados[pickerView.selectedRow(inComponent: 0)]
        txEstado.text = estado.nome
        produto.addToEstados(estado)
        cancel()
     
    }
    
    @objc func cancel() {
        view.endEditing(true)
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
        pickerView.reloadAllComponents()
    }
    
   
}

extension RegistraAtualizaCompraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            let aspectRation = image.size.width / image.size.height
            let tamanhoMaximo: CGFloat = 500
            var tamanhoMinimo: CGSize
            if aspectRation > 1 {
                tamanhoMinimo = CGSize(width: tamanhoMaximo, height: tamanhoMaximo/aspectRation)
            }else{
                tamanhoMinimo = CGSize(width: tamanhoMaximo*aspectRation, height: tamanhoMaximo)
            }
             UIGraphicsBeginImageContext(tamanhoMinimo)
            image.draw(in: CGRect(x: 0, y: 0, width: tamanhoMinimo.width, height: tamanhoMinimo.height))
            ivFoto.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        dismiss(animated: true, completion: nil)
    }
}

extension RegistraAtualizaCompraViewController: NSFetchedResultsControllerDelegate {
    //metodo disparado toda vez que ha uma mudanca de conteudo
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
       pickerView.reloadAllComponents()
    }
}

extension RegistraAtualizaCompraViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaEstados.count
    }
}

extension RegistraAtualizaCompraViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listaEstados[row].nome
    }
}


