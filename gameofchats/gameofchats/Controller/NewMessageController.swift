//
//  NewMessageController.swift
//  gameofchats
//
//  Created by Mac on 27/02/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {

    let  cellId = "cellId"
    var users = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        fetchUser()
    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
      
      
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                
                
                //user.setValuesForKeys(dictionary)
                user.setValuesForKeys(dictionary)
                self.users.append(user)
                
                // this will crash because of background thread,so let use dispatch _async to fix
            
                
                DispatchQueue.main.async(execute:  {
                    self.tableView.reloadData()
                    
                })
                
            }
           // print("User found")
           // print(snapshot)
        }, withCancel: nil)
            
}
    
    @objc func handleCancel() {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let use a hack now, cells we actually need to deqeue our for memory efficency
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
       // cell.textLabel?.text = "mosin shaikh"
       let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        

        return cell
        
        
    }
}
