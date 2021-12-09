//
//  MyProfileViewController.swift
//  ColorBasketApp
//
//  Created by apple on 2021/09/02.
//

import UIKit
import FirebaseAuth

class MyProfileViewController: UIViewController {
    
    let logout: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(logoutClick), for: .touchUpInside)
        btn.backgroundColor = .white
        btn.setTitle("logout", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 247/255, green: 247/255, blue: 245/255, alpha: 1)
        view.addSubview(logout)
        setting()
        // Do any additional setup after loading the view.
    }
    
    private func setting() {
        logout.translatesAutoresizingMaskIntoConstraints = false
        logout.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logout.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func logoutClick() {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
    }

}
