//
//  LoginViewController.swift
//  ColorBasketApp
//
//  Created by apple on 2021/12/03.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    let logo: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Avenir Next Heavy", size: 40)
        lb.text = "Color\nBasket"
        lb.textColor = UIColor(hexFromString: "D2691E")
        lb.numberOfLines = 2
        lb.textAlignment = .center
        lb.sizeToFit()
        return lb
    }()
    let email: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.autocapitalizationType = .none
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 5
        tf.addSidePadding(padding: 10)
        return tf
    }()
    let password: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 5
        tf.addSidePadding(padding: 10)
        return tf
    }()
    let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.backgroundColor = UIColor(hexFromString: "D2691E")
        btn.setTitleColor(UIColor(displayP3Red: 247/255, green: 247/255, blue: 245/255, alpha: 1), for: .normal)
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        return btn
    }()
    let accountLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Dont have an account?"
        lb.sizeToFit()
        return lb
    }()
    let signupButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign up", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        return btn
    }()
    let googleLoginButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
        return btn
    }()
    
    let googleLogo: UIImageView = {
        let ig = UIImageView(image: UIImage(named: "GoogleLogo")!)
        return ig
    }()
    let googleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.text = "Sign in with Google"
        return lb
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = Auth.auth().currentUser {
            dismiss(animated: false, completion: nil)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
    }
    
    private func setting() {
        let margins = view.layoutMarginsGuide
        let backgroundGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(backgroundGesture)
        view.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 245/255, alpha: 1)
        
        view.addSubview(logo)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(loginButton)
        view.addSubview(accountLabel)
        view.addSubview(signupButton)
        view.addSubview(googleLoginButton)
        
        googleLoginButton.addSubview(googleLogo)
        googleLoginButton.addSubview(googleLabel)
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        email.translatesAutoresizingMaskIntoConstraints = false
        email.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 15).isActive = true
        email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        email.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        password.translatesAutoresizingMaskIntoConstraints = false
        password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10).isActive = true
        password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        password.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 316).isActive = true
        
        googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        googleLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        googleLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        googleLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 50).isActive = true
        googleLoginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        googleLogo.translatesAutoresizingMaskIntoConstraints = false
        googleLogo.topAnchor.constraint(equalTo: googleLoginButton.topAnchor).isActive = true
        googleLogo.leadingAnchor.constraint(equalTo: googleLoginButton.leadingAnchor, constant: 10).isActive = true
        googleLogo.bottomAnchor.constraint(equalTo: googleLoginButton.bottomAnchor).isActive = true
        googleLogo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        googleLogo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        googleLabel.translatesAutoresizingMaskIntoConstraints = false
        googleLabel.topAnchor.constraint(equalTo: googleLoginButton.topAnchor).isActive = true
        googleLabel.leadingAnchor.constraint(equalTo: googleLogo.trailingAnchor, constant: 40).isActive = true
        googleLabel.trailingAnchor.constraint(equalTo: googleLoginButton.trailingAnchor).isActive = true
        googleLabel.bottomAnchor.constraint(equalTo: googleLoginButton.bottomAnchor).isActive = true
        
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        accountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        accountLabel.bottomAnchor.constraint(equalTo:  margins.bottomAnchor, constant: -10).isActive = true
        
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.leadingAnchor.constraint(equalTo: accountLabel.trailingAnchor).isActive = true
        signupButton.centerYAnchor.constraint(equalTo: accountLabel.centerYAnchor).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 81).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc private func backgroundTap() {
        dismissKeyboard()
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    @objc private func loginButtonClick() {
        guard let email = email.text, let pw = password.text else { return }
        Auth.auth().signIn(withEmail: email, password: pw) { user, error in
            if user != nil {
                self.dismiss(animated: false, completion: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @objc private func registerBtnClick() {
        let registVC = RegisterViewController()
        registVC.modalPresentationStyle = .fullScreen
        self.present(registVC, animated: true, completion: nil)
    }
    
    @objc private func googleSignIn() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { Result, error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }

}

extension UITextField {
    func addSidePadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: padding))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
