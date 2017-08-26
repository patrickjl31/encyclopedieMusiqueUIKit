//
//  GestionAuteurs.swift
//  encyclopedieMusique
//
//  Created by patrick lanneau on 26/08/2017.
//  Copyright © 2017 patrick lanneau. All rights reserved.
//

import UIKit

class GestionAuteurs: NSObject {
    var lesCompositeurs:[compositeur] = []
    
    var compositeursAlpha:[String: [compositeur]]?
    var alphabet:[String]

    
    
    override init() {
        //Init compositeur alpha
        let alpha = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
        alphabet = alpha.components(separatedBy: " ")
        for lettre in alphabet {
            compositeursAlpha?.updateValue([], forKey: lettre)
        }
        for compositeur in lesCompositeurs{
            let initiale = compositeur.nom.characters.first
            let initialeS = String(initiale!)
            if alpha.contains(initialeS) {
                compositeursAlpha?[initialeS]?.append(compositeur)
            }
            
        }
        
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
}
