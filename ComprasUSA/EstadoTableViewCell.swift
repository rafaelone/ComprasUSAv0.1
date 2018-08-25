//
//  EstadoTableViewCell.swift
//  ComprasUSA
//
//  Created by Usuário Convidado on 25/08/2018.
//  Copyright © 2018 FIAP. All rights reserved.
//

import UIKit

class EstadoTableViewCell: UITableViewCell {

    @IBOutlet weak var txEstado: UILabel!
    @IBOutlet weak var txValor: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
