//
//  ViewController.swift
//  SampleCoreData
//
//  Created by Archimedes Angeles on 17/3/19.
//  Copyright © 2019 Archimedes Angeles. All rights reserved.
//

import UIKit
import Foundation
import CoreData
//

class ViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtBirthdate: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        
        let fileManager = FileManager.default
        
        let dirPath = fileManager.urls(for: .applicationDirectory, in: .userDomainMask)
        
        let docsDir = dirPath[0].path
        
        print(docsDir)
    }

    @IBAction func SaveClicked(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let description = NSEntityDescription.entity(forEntityName: "Person", in: context)
        let newPerson = NSManagedObject.init(entity: description!, insertInto: context)
        
        
        newPerson.setValue(txtName.text, forKey: "firstname")
        newPerson.setValue(txtLastName.text, forKey: "lastname")
        
        let bdate = converToDate(textDate: txtBirthdate.text!)
        
        newPerson.setValue(bdate, forKey: "birthdate")
        
        do {
            try context.save()
            
            let alertCon = UIAlertController.init(title: "Saved Notification", message: "Record has been saved", preferredStyle: .alert)
            
            let OKAction = UIAlertAction.init(title: "OK", style: .default) { (alertaction) in
                print("You click ok ")
            }
            
            alertCon.addAction(OKAction)
            
            self.present(alertCon, animated: true, completion: nil)
            
            
            print("Saved")
        } catch  {
            print("Error \(error.localizedDescription)")
        }
        
    }
    
    func converToDate(textDate: String) -> Date {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        dateFormat.timeZone = TimeZone(abbreviation: "GMT+0:00")
        
        guard let date1 = dateFormat.date(from: textDate) else
        {
            return Date()
        }
        
        return date1
        
    }
    
    func getData() -> Void {
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Person")
        
        fetch.returnsObjectsAsFaults = false
        
        do {
            let result  = try context.fetch(fetch)
            
            for item in result as! [NSManagedObject] {
                
                
                
                print("Last Name: \(item.value(forKey: "lastname") ?? ""), First Name : \(item.value(forKey: "firstname") ?? ""), Age: \(item.value(forKey: "birthdate") ?? 0)")
            }
        } catch  {
            print("error \(error.localizedDescription)")
        }
        
        
//
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
//
//        request.returnsObjectsAsFaults = false
//
//        do {
//            let result = try context.fetch(request)
//
//            for data in result as! [NSManagedObject] {
//
//                var lastname = data.value(forKey: "lastname")
//                var firstname = data.value(forKey: "firstname")
//                var  age = data.value(forKey: "age")
//
//
//                if data.value(forKey: "lastname") == nil
//                {
//                    lastname = ""
//                }
//
//
//                if data.value(forKey: "firstname") == nil
//                {
//                    firstname = ""
//                }
//
//                if data.value(forKey: "age") == nil
//                {
//                    age = 0
//                }
////
////                txtLastName.text = lastname as? String
////                txtName.text = firstname as? String
////                txtAge.text = "\(age)"
//
//
//                print("LastName: \(lastname!), First Name: \(firstname!)), Age:\(age!)")
//            }
//
//        } catch  {
//            print("error \(error.localizedDescription)")
//        }
        
    }
    
}

