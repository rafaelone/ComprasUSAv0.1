//
//  UIViewController+CoreData.swift
//  ComprasUSA
//
//  Created by Usuário Convidado on 21/08/2018.
//  Copyright © 2018 FIAP. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
