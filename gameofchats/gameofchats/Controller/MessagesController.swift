//
//  ViewController.swift
//  gameofchats
//
//  Created by Mac on 21/02/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //Left Bar Button item code
        // Right Bar Button Item code
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
      
        
        setUpMenuButton()
        checkIfUserLoggedIn()
        
     
    }
              // func for making rightbutton appear
    
    func setUpMenuButton(){
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 50, height: 30)
        menuBtn.setImage(UIImage(named:"1944245.svg.png"), for: .normal)
        menuBtn.addTarget(self, action: #selector(handeNewMessage), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 40)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 40)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
    }
    
    
    
    @objc func handeNewMessage() {
        
        
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
        
        
        
        
    }
    
    func checkIfUserLoggedIn() {
        
        // User  is not logged in
        
        if Auth.auth().currentUser?.uid == nil{
            
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
            
        } else {
            
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                //print(snapshot)
                if let dictionary =  snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["name"] as? String
                }
                
            }, withCancel: nil)
        }
        
    }

    //Left Bar Button Logout Handler
    @objc func handleLogout() {
        
        do{
            try Auth.auth().signOut()
            
            
        }catch let logoutError   {
            print(logoutError)
        }
        
        
        // To present a Login Controller on a tap of Logout Button
        // Blue Login Screen will Appear
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
}

