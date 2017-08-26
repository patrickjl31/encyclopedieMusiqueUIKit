//
//  OeuvreViewController.swift
//  encyclopedieMusique
//
//  Created by patrick lanneau on 25/08/2017.
//  Copyright © 2017 patrick lanneau. All rights reserved.
//

import UIKit

class OeuvreViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var lbl_titre: UILabel!
    
    @IBOutlet weak var webYoutube: UIWebView!
    
    var uneOeuvre:oeuvre?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbl_titre.text = uneOeuvre?.titre
        
        if uneOeuvre!.lien.contains("http"){
            let url = NSURL(string: (uneOeuvre?.lien)!)
            let requete = NSURLRequest(url:url as! URL)
            webYoutube.loadRequest(requete as URLRequest)
        }
        
        
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
