//
//  CompositeurViewController.swift
//  encyclopedieMusique
//
//  Created by patrick lanneau on 25/08/2017.
//  Copyright © 2017 patrick lanneau. All rights reserved.
//

import UIKit

class CompositeurViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate {

    @IBOutlet weak var ui_titre: UILabel!
    
    @IBOutlet weak var ui_webPage: UIWebView!
    
    @IBOutlet weak var tableOeuvres: UITableView!
    
    
    //-----------
    
    var unAuteur:compositeur = compositeur()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ui_titre.text = unAuteur.nom
        if unAuteur.wiki.contains("http"){
            let url = NSURL(string: (unAuteur.wiki))
            let requete = NSURLRequest(url:url as! URL)
            ui_webPage.loadRequest(requete as URLRequest)
        }
        
        
        
        tableOeuvres.delegate = self
        tableOeuvres.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ui_titre.text = unAuteur.nom
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
    
    // MARK segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! OeuvreViewController
        if segue.identifier == "voir_oeuvre" {
            vc.uneOeuvre = unAuteur.sesOeuvre[(tableOeuvres.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    
    // MARK gestion tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 0
        return unAuteur.sesOeuvre.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "cell_oeuvre", for: indexPath)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell_oeuvre")
        }
        cell?.textLabel?.text = unAuteur.sesOeuvre[indexPath.row].titre
        //print("Compositeur \(indexPath.row)")
        var suite = unAuteur.sesOeuvre[indexPath.row].complement
        
        
        cell?.detailTextLabel?.text = "\(suite)"
        return cell!
        
        
        
        
    }
    


}
