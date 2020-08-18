//
//  LoginController.swift
//  gameofchats
//
//  Created by Mac on 21/02/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController{
    
    
       // Container View Code
    //Means White box to add Text field init
    var inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
        
    }()
    
         // Register Login Button
   lazy var loginRegisterButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
        
    }()
    @objc func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0{
            
            handleLogin()
        }else{
            handleRegister()
        }
    }
    
    func handleLogin() {
        guard let email = emailTextField.text,  let password = passwordTextField.text
        else{
            print("form is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password:  password) { (user, error) in
            if error != nil{
                
                print(error)
                return
            }
            // Successfully logged in our user
        self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @objc func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else{
            print("form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
            
          
          if error != nil{
            
              print(error)
               return
            }
            
            
            
     
                 // Successfully authenticated user
          
            guard let uid = user?.user.uid else {return}
             let  ref = Database.database().reference(fromURL: "https://mynewchatapp-988d4.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil{
                    
                    print(err)
                    return
                }
                self.dismiss(animated: true, completion: nil)
          
            })
            
            
            })
        print(123)
    }
    
           // Name Text Field Place holder code
    let nameTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    
         // Line Seprator Code
    let nameSepratorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    
    let emailTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    
    // Line Seprator Code
    let emailSepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    
    
    let passwordTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "PassWord"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
        
    }()
    
    
    // Line Seprator Code
    let passwordSepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    // To Set a image Code
    let profileImageView: UIImageView = {
        
       var imageview = UIImageView()
        imageview.image = UIImage(named: "pngguru.com.png") ?? UIImage()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        
        return imageview
        
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        
        loginRegisterButton.setTitle(title, for: .normal)
        
        // change hieght for inputcontainer view, but how?
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        // change Height of name textfield
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // Login background color making blue appear
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        // To add in Container View
        view.addSubview(inputContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
        SetupInputsContainersView()
        SetuploginRegisterButton()
        SetupProfileImageView()
        setupLoginRegisterSegmentedControl()
    }
    
    func setupLoginRegisterSegmentedControl() {
        // need x, y, width, height Constraints
        
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        
        
        
        
    }
    
    
    
    
    
    func SetupProfileImageView() {
        // need x, y, width, height Constraints
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    func SetupInputsContainersView() {
        
        // need x, y, width, height Constraints
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        
        
             inputsContainerViewHeightAnchor = inputContainerView.heightAnchor.constraint(equalToConstant: 150)
        
                inputsContainerViewHeightAnchor?.isActive = true
        
        
        
        // Name TextField Constraints
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSepratorView)
        // Email TextField Constraints
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(emailSepratorView)
        // Password Text Field contraints
        inputContainerView.addSubview(passwordTextField)
        inputContainerView.addSubview(passwordSepratorView)
        
        // need x, y, width, height Constraint
        nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        
        
        nameTextFieldHeightAnchor?.isActive = true
        
        // need x, y, width, height Constraint
        
        nameSepratorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        nameSepratorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSepratorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameSepratorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Email text field Contrains
        
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
            emailTextFieldHeightAnchor?.isActive = true
        
        // need x, y, width, height Constraint
        
        emailSepratorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        emailSepratorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSepratorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailSepratorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        // Pass word text field Constraints
        
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
            passwordTextFieldHeightAnchor?.isActive = true
        
        // need x, y, width, height Constraint
        
        passwordSepratorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        passwordSepratorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        passwordSepratorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordSepratorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        
        
        
        
        
        
    }
    
    
    
    func SetuploginRegisterButton() {
        
       loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
            // Making status Bar Look white in color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return.lightContent
    }

}

            //Login Background color extension
extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}
