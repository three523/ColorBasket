//
//  ExampleCard.swift
//  ColorBasketApp
//
//  Created by apple on 2021/10/07.
//

import UIKit

class NeumorphicView: UIView {

    var cornerRadius: CGFloat = 15
    
    lazy var darkShadow: CALayer = {
        let darkShadow = CALayer()
       
        darkShadow.shadowOffset = CGSize(width: 10, height: 10)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = 15
        darkShadow.cornerRadius = cornerRadius
        
        return darkShadow
    }()
    
    lazy var lightShadow: CALayer = {
        let lightShadow = CALayer()
        
        lightShadow.shadowOffset = CGSize(width: -5, height: -5)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = 5
        lightShadow.cornerRadius = cornerRadius
        
        return lightShadow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = cornerRadius
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.insertSublayer(darkShadow, at: 0)
        self.layer.insertSublayer(lightShadow, at: 0)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        darkShadow.frame = self.bounds
        darkShadow.backgroundColor = UIColor(hexFromString: "EFEEEE")?.cgColor
        darkShadow.shadowColor = UIColor(hexFromString: "D1CDC7")?.withAlphaComponent(0.5).cgColor
        
        lightShadow.frame = self.bounds
        lightShadow.backgroundColor = UIColor(hexFromString: "FFFFFF")?.cgColor
        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.9).cgColor
        
        let path = UIBezierPath(roundedRect: bounds.insetBy(dx: -3, dy: -3), cornerRadius: cornerRadius)
        let cutout = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        path.append(cutout)
        
        darkShadow.shadowPath = path.cgPath
        lightShadow.shadowPath = path.cgPath
    }
    
}
class NeumorphicInnerView: UIView {
    
    var cornerRadius: CGFloat = 15
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var darkShadow: CALayer = {
        let view = CALayer()
        view.shadowColor = UIColor(hexFromString: "D1CDC7")?.cgColor
        view.shadowOffset = .init(width: 5, height: 5)
        view.shadowOpacity = 1
        view.shadowRadius = 3
        view.cornerRadius = cornerRadius
        return view
    }()
    
    lazy var lightShadow: CALayer = {
        let view = CALayer()
        view.shadowColor = UIColor(hexFromString: "FFFFFF")?.cgColor
        view.shadowOffset = .init(width: -5, height: -5)
        view.shadowOpacity = 1
        view.shadowRadius = 3
        view.cornerRadius = cornerRadius
        return view
    }()
    
    private func setupView() {
        backgroundColor = UIColor(hexFromString: "EFEEEE")
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.addSublayer(darkShadow)
        self.layer.addSublayer(lightShadow)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        darkShadow.frame = self.bounds
        lightShadow.frame = self.bounds
        
        let path = UIBezierPath(roundedRect: bounds.insetBy(dx: -3, dy: -3), cornerRadius: cornerRadius)
        let cutout = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).reversing()
        path.append(cutout)
        
        darkShadow.shadowPath = path.cgPath
        lightShadow.shadowPath = path.cgPath
    }
}

class NeumorphicViewController: ViewController {
    
    let exampleCard: NeumorphicView = {
        let view = NeumorphicView()
        return view
    }()
    let exampleInnerCard: NeumorphicInnerView = {
        let view = NeumorphicInnerView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexFromString: "EFEEEE")
        setupView()
    }
    
    private func setupView() {
        
        view.addSubview(exampleCard)
        
        exampleCard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        exampleCard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exampleCard.heightAnchor.constraint(equalToConstant: 100).isActive = true
        exampleCard.widthAnchor.constraint(equalToConstant: 300).isActive = true
        exampleCard.layoutIfNeeded()
        
        view.addSubview(exampleInnerCard)
        
        exampleInnerCard.topAnchor.constraint(equalTo: exampleCard.bottomAnchor, constant: 20).isActive = true
        exampleInnerCard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exampleInnerCard.heightAnchor.constraint(equalToConstant: 100).isActive = true
        exampleInnerCard.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        exampleInnerCard.layoutIfNeeded()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)

struct NeumorphicVCRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return NeumorphicViewController().view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //ddd
    }
}

struct Preview: PreviewProvider {
    static var previews: some View {
        NeumorphicVCRepresentable()
            .previewDevice("iPhone 12 Pro")
    }
}
#endif
