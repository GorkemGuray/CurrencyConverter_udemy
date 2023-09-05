//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Görkem Güray on 4.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRatesClicked(_ sender: UIButton) {
        
        // 1 - Request & Session
        // 2 - Response & Data
        // 3 - Parsing & JSON Serialization
        
        
        // 1 - Request & Session
        //--------------------------------------
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=8dead10fcd9580d373792775786709f0")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, responseSession, error in
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
                
            } else {
                
                // 2 - Response & Data
                //--------------------------------------
                if data != nil {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        // 3 - Parsing & JSON Serialization
                        //--------------------------------------
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = String("CAD : \(cad)")
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = String("CHF : \(chf)")
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = String("GBP : \(gbp)")
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = String("JPY : \(jpy)")
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = String("USD : \(usd)")
                                }
                                
                                if let tl = rates["TRY"] as? Double {
                                    self.tryLabel.text = String("TRY : \(tl)")
                                }
                                
                            }
                        }
                        
                    } catch {
                        print("json serialization'da hata var.")
                    }
                    
                    
                    
                    
                }
                
                
            }
        }
        
        task.resume()
        
        
    }
}

