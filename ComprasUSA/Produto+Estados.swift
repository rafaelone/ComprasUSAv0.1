//
//  Produto+Estados.swift
//  ComprasUSA
//
//  Created by Desenvolvimento on 24/08/18.
//  Copyright © 2018 FIAP. All rights reserved.
//

import Foundation

extension Product {
    var estadosString: String {
        //return categories?.reduce("", {$0 + ($1 as Category).name + "|"})
        if let estados  = estados {
            //pegando cada elemento por nome e tratando
           return Array(estados).map({($0 as! State).nome ?? ""}).joined(separator: " | ")
        }else {
            return ""
        }
    }
}
