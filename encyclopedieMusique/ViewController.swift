//
//  ViewController.swift
//  encyclopedieMusique
//
//  Created by patrick lanneau on 24/08/2017.
//  Copyright © 2017 patrick lanneau. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var lesCompositeurs:[compositeur] = []
    
    @IBOutlet weak var lbl_titre: UILabel!
    @IBOutlet weak var tableCompositeurs: UITableView!
    
    
    var selectedCell = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // On lit le fichier
        lectureFichierCompositeurs(nomfic: "baseOeuvre2")
        print("Compositeurs : \(lesCompositeurs.count)")
        // La table des compositeurs
        tableCompositeurs.delegate = self
        tableCompositeurs.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK Lecture du fichier JSON
    func lectureFichierCompositeurs(nomfic:String)   {
        if let path = Bundle.main.path(forResource: nomfic, ofType: "json"){
            
            if let data = NSData(contentsOfFile: path){
                //print("\(data)")
                
                do {
                    let objet = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                    if let dictionnaire = objet as? [[String: AnyObject]]{
                        //print("\(dictionnaire.count) \n \n \(dictionnaire)")
                        for fiche in dictionnaire {
                            let num:String = fiche["n"] as! String
                            if num == "1"{
                                let unCompositeur:compositeur = compositeur()
                                unCompositeur.nom = fiche["nom"] as! String
                                unCompositeur.nationalite = fiche["titre"] as! String
                                unCompositeur.dateNaissance = fiche["dn"] as! String
                                unCompositeur.dateMort = fiche["duree"] as! String
                                unCompositeur.wiki = fiche["lien"] as! String
                                //print("\(unCompositeur.nom)")
                                lesCompositeurs.append(unCompositeur)
                            } else {
                                let uneOeuvre:oeuvre = oeuvre()
                                uneOeuvre.titre = fiche["nom"] as! String
                                uneOeuvre.complement = fiche["titre"] as! String
                                uneOeuvre.duree = fiche["duree"] as! String
                                uneOeuvre.lien = fiche["lien"] as! String
                                uneOeuvre.dateComposition = fiche["dn"] as! String
                                lesCompositeurs.last?.sesOeuvre.append(uneOeuvre)
                            }
                        }
                    }
                } catch {
                    print("erreur")
                }
            }
        }
    }
    
    // MARK segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CompositeurViewController
        if segue.identifier == "voir_compositeur" {
            vc.unAuteur = lesCompositeurs[(tableCompositeurs.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    
    // MARK gestion tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return lesCompositeurs.count
        return lesCompositeurs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "cell_compositeur", for: indexPath)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell_compositeur")
        }
        cell?.textLabel?.text = lesCompositeurs[indexPath.row].nom//"Compositeur \(indexPath.row)"
        //print("Compositeur \(indexPath.row)")
        var mort = lesCompositeurs[indexPath.row].dateMort
        if mort != "" {
            mort = ", mort en " + mort
        }
        cell?.detailTextLabel?.text = "\(lesCompositeurs[indexPath.row].nationalite), Né en \(lesCompositeurs[indexPath.row].dateNaissance)\(mort)"
        return cell!
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //NSLog("You selected cell number: \(indexPath.row)!")
        selectedCell = indexPath.row
        //self.performSegueWithIdentifier("yourIdentifier", sender: self)
    }


}

