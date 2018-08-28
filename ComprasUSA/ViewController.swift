//
//  ViewController.swift
//  ComprasUSA
//
//  Created by Desenvolvimento on 21/08/18.
//  Copyright © 2018 FIAP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var ivProduto: UIImageView!
    @IBOutlet weak var lbNomeProduto: UILabel!
    @IBOutlet weak var lbValorProduto: UILabel!
    @IBOutlet weak var lbEstadoProduto: UILabel!
    @IBOutlet weak var lbCartao: UILabel!
    
    var produto: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ivProduto.image = produto.image as? UIImage
        lbNomeProduto.text = produto.title
        lbValorProduto.text = "\(produto.money)"
        lbEstadoProduto.text = produto.estadosString
        
        if produto.cartao == false {
            lbCartao.text = "Não foi comprado por cartão"
        }else{
            lbCartao.text = "Foi comprado por cartão"
        }
        
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? RegistraAtualizaCompraViewController {
            vc.produto = produto
        }
    }
    


}

