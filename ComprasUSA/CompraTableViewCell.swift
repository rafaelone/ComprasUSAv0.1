//
//  CompraTableViewCell.swift
//  ComprasUSA
//
//  Created by Usuário Convidado on 21/08/2018.
//  Copyright © 2018 FIAP. All rights reserved.
//

import UIKit

class CompraTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ivProduto: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPreco: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
