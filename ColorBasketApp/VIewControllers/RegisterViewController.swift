//
//  RegisterViewController.swift
//  ColorBasketApp
//
//  Created by apple on 2021/12/03.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    enum RegexMode {
        case email
        case password
    }
    
    let backButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.tintColor = UIColor(hexFromString: "D2691E")
        btn.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        return btn
    }()
    let singupLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Avenir Next Heavy", size: 30)
        lb.text = "Sign UP"
        lb.textColor = UIColor(hexFromString: "D2691E")
        lb.textAlignment = .center
        lb.sizeToFit()
        return lb
    }()
    let name: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.autocapitalizationType = .none
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 5
        tf.addSidePadding(padding: 10)
        tf.addTarget(self, action: #selector(nameNotEmpty(textFiled:)), for: .touchUpInside)
        return tf
    }()
    let email: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.autocapitalizationType = .none
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 5
        tf.addSidePadding(padding: 10)
        tf.addTarget(self, action: #selector(emailRegex), for: .editingDidEnd)
        return tf
    }()
    let emailRegexLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Avenir-Medium", size: 15)
        lb.sizeToFit()
        lb.text = ""
        return lb
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
        tf.addTarget(self, action: #selector(passwordRegex), for: .editingDidEnd)
        return tf
    }()
    let passwordRegexLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Avenir-Medium", size: 15)
        lb.text = "비밀번호는 영문, 숫자, 특수문자를 혼합하여 8~20자로 입력해주세요."
        lb.sizeToFit()
        lb.numberOfLines = 2
        return lb
    }()
    let confirm: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Confirm Password"
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 5
        tf.addSidePadding(padding: 10)
        tf.addTarget(self, action: #selector(passwordConfirm), for: .editingDidEnd)
        return tf
    }()
    let passwordConfirmLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Avenir-Medium", size: 15)
        lb.sizeToFit()
        lb.text = ""
        return lb
    }()
    let registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Register", for: .normal)
        btn.backgroundColor = UIColor(hexFromString: "D2691E")
        btn.setTitleColor(UIColor(displayP3Red: 247/255, green: 247/255, blue: 245/255, alpha: 1), for: .normal)
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)
        return btn
    }()
    let accountLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Already have an account?"
        lb.sizeToFit()
        return lb
    }()
    let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        return btn
    }()
    var isEmailRegex: Bool = false
    var isPasswordRegex: Bool = false
    var isConfim: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
    }
    
    private func setting() {
        let margins = view.layoutMarginsGuide
        let backgroundGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(backgroundGesture)
        view.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 245/255, alpha: 1)
        
        view.addSubview(backButton)
        view.addSubview(singupLabel)
        view.addSubview(name)
        view.addSubview(email)
        view.addSubview(emailRegexLabel)
        view.addSubview(password)
        view.addSubview(passwordRegexLabel)
        view.addSubview(confirm)
        view.addSubview(passwordConfirmLabel)
        view.addSubview(registerButton)
        view.addSubview(accountLabel)
        view.addSubview(loginButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.centerYAnchor.constraint(equalTo: singupLabel.centerYAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        singupLabel.translatesAutoresizingMaskIntoConstraints = false
        singupLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        singupLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: singupLabel.bottomAnchor, constant: 50).isActive = true
        name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        name.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        email.translatesAutoresizingMaskIntoConstraints = false
        email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15).isActive = true
        email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        email.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailRegexLabel.translatesAutoresizingMaskIntoConstraints = false
        emailRegexLabel.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 5).isActive = true
        emailRegexLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        emailRegexLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        
        password.translatesAutoresizingMaskIntoConstraints = false
        password.topAnchor.constraint(equalTo: emailRegexLabel.bottomAnchor, constant: 15).isActive = true
        password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        password.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordRegexLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordRegexLabel.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 5).isActive = true
        passwordRegexLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        passwordRegexLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        confirm.translatesAutoresizingMaskIntoConstraints = false
        confirm.topAnchor.constraint(equalTo: passwordRegexLabel.bottomAnchor, constant: 15).isActive = true
        confirm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        confirm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        confirm.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordConfirmLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordConfirmLabel.topAnchor.constraint(equalTo: confirm.bottomAnchor, constant: 5).isActive = true
        passwordConfirmLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        passwordConfirmLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: passwordConfirmLabel.bottomAnchor, constant: 15).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 316).isActive = true
        
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        accountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        accountLabel.bottomAnchor.constraint(equalTo:  margins.bottomAnchor, constant: -10).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.leadingAnchor.constraint(equalTo: accountLabel.trailingAnchor, constant: 0).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: accountLabel.centerYAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 81).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc private func backButtonClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func backgroundTap() {
        dismissKeyboard()
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    @objc private func emailRegex() {
        guard let emailStr: String = email.text  else { return }
        if emailStr == "" { return }
        
        if isRegex(str: emailStr, regexMode: .email) {
            isEmailRegex = true
            emailRegexLabel.text = "✓ 확인되었습니다."
            emailRegexLabel.textColor = UIColor(hexFromString: "008000")
            email.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            isEmailRegex = false
            emailRegexLabel.text = "형식이 맞지 않습니다"
            emailRegexLabel.textColor = .red
            email.layer.borderColor = UIColor.red.cgColor
            email.shake()
        }
    }
    
    @objc private func passwordRegex() {
        guard let passwordStr: String = password.text else { return }
        if passwordStr == "" { return }
        
        if isRegex(str: passwordStr, regexMode: .password) {
            isPasswordRegex = true
            passwordRegexLabel.text = "✓ 확인되었습니다."
            passwordRegexLabel.textColor = UIColor(hexFromString: "008000")
            password.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            isPasswordRegex = false
            passwordRegexLabel.text = "형식이 맞지 않습니다."
            passwordRegexLabel.textColor = .red
            password.layer.borderColor = UIColor.red.cgColor
            password.shake()
        }
        
    }
    
    @objc private func passwordConfirm() {
        guard let confirmStr: String = confirm.text else { return }
        if confirmStr == "" { return }
        
        if isPasswordConfirm(str: confirmStr) && isPasswordRegex {
            isConfim = true
            passwordConfirmLabel.text = "✓ 확인되었습니다."
            passwordConfirmLabel.textColor = UIColor(hexFromString: "008000")
            confirm.layer.borderColor = UIColor.lightGray.cgColor
        } else if !isPasswordRegex {
            isConfim = false
            passwordConfirmLabel.text = "형식이 맞지 않습니다"
            passwordConfirmLabel.textColor = .red
            confirm.layer.borderColor = UIColor.red.cgColor
            confirm.shake()
        } else {
            isConfim = false
            passwordConfirmLabel.text = "패스워드가 일치하지 않습니다"
            passwordConfirmLabel.textColor = .red
            confirm.layer.borderColor = UIColor.red.cgColor
            confirm.shake()
        }
        
    }
    
    private func isRegex(str: String, regexMode: RegexMode ) -> Bool {
        var pattern = ""
        
        switch regexMode {
        case .email:
            pattern = "^[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$"
        case .password:
            pattern = "(?=.*\\d{1,})(?=.*[~`!@#$%\\^&*()-+=]{1,})(?=.*[a-zA-Z]{1,}).{8,}$"
        }
        
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: str, options: [], range: NSRange(location: 0, length: str.count)) {
            return true
        }
        return false
    }
    
    private func isPasswordConfirm(str: String) -> Bool {
        return password.text == str
    }
    
    @objc private func registerButtonClick() {
        dismissKeyboard()
        guard let email = email.text, let pw = password.text else { return }
        if !isEmpty() {
            Auth.auth().createUser(withEmail: email, password: pw) { result, error in
                print(error?.localizedDescription)
            
                
                Auth.auth().signIn(withEmail: email, password: pw) { user, error in
                    if user != nil {
                        self.dismiss(animated: false, completion: nil)
                    } else {
                        print(error?.localizedDescription)
                    }
                }
            }
        }
        
    }
    
    @objc private func nameNotEmpty(textFiled: UITextField) {
        if textFiled.text != "" {
            textFiled.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    private func isEmpty() -> Bool {
        if name.text == "" {
            name.layer.borderColor = UIColor.red.cgColor
            name.shake()
            return true
        } else if !isEmailRegex {
            email.layer.borderColor = UIColor.red.cgColor
            email.shake()
            return true
        } else if !isPasswordRegex {
            password.layer.borderColor = UIColor.red.cgColor
            password.shake()
            return true
        } else if !isConfim {
            confirm.layer.borderColor = UIColor.red.cgColor
            confirm.shake()
            return true
        }
        return false
    }

}

public extension UITextField {

    func shake(count : Float = 2,for duration : TimeInterval = 0.2,withTranslation translation : Float = 3) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}

