//
//  RegistraAtualizaCompraViewController.swift
//  ComprasUSA
//
//  Created by Usuário Convidado on 21/08/2018.
//  Copyright © 2018 FIAP. All rights reserved.
//

import UIKit

class RegistraAtualizaCompraViewController: UIViewController {

    @IBOutlet weak var txNome: UITextField!
    @IBOutlet weak var ivFoto: UIImageView!
    @IBOutlet weak var txEstado: UITextField!
    @IBOutlet weak var txValor: UITextField!
    @IBOutlet weak var slCartao: UISwitch!
    @IBOutlet weak var btAddEdit: UIButton!
    
    var produto: Produto!
    var estado: Estado!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        txValor.keyboardType = UIKeyboardType.numberPad
        if produto != nil {
            txNome.text = produto.title
            ivFoto.image = produto.image as? UIImage
            txValor.text = "\(produto.money)"
            slCartao.isOn = produto.cartao
            btAddEdit.setTitle("Atualizar", for: .normal)
            
        }else{
            produto = Produto(context: context)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        txEstado.text = produto.estadosString
    }
    
    
    @IBAction func addEditProduto(_ sender: UIButton) {
        produto.title = txNome.text!
//        produto.estados = txEstado.text
//        produto.image = ivFoto.image
//        produto.money =  Double(txValor.text!)!
        
    
    }
    
    
    

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
        
        let album = UIAlertAction(title: "Album de fotos", style: .default) { (action) in
            self.selecionaFoto(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(album)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelar)
        
        present(alert, animated: true, completion: nil)
    }

    func selecionaFoto(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
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
