//
//  ColorView.swift
//  ColorBasketApp
//
//  Created by apple on 2021/12/11.
//

import UIKit

class ColorListView: UIStackView {
    
    var cardViewModel = CardViewModel()
    var colorList: [String] = []
    
    private let stackView1: UIStackView = {
        let st = UIStackView()
        st.axis = .horizontal
        st.alignment = .fill
        st.distribution = .fillEqually
        return st
    }()
    private let stackView2: UIStackView = {
        let st = UIStackView()
        st.axis = .horizontal
        st.alignment = .fill
        st.distribution = .fillEqually
        return st
    }()
    
    private let colorView1: TouchColorView = TouchColorView()
    private let colorView2: TouchColorView = TouchColorView()
    private let colorView3: TouchColorView = TouchColorView()
    private let colorView4: TouchColorView = TouchColorView()
    private let colorView5: TouchColorView = TouchColorView()
    private let colorView6: TouchColorView = TouchColorView()
    
    public func uiSetting(colorList: [String]) {
        self.colorList = colorList
        
        self.layoutIfNeeded()
        print(self.frame)
        
        self.addArrangedSubview(stackView1)
        self.addArrangedSubview(stackView2)
        stackView1.addArrangedSubview(colorView1)
        stackView1.addArrangedSubview(colorView2)
        stackView1.addArrangedSubview(colorView3)
        stackView2.addArrangedSubview(colorView4)
        stackView2.addArrangedSubview(colorView5)
        stackView2.addArrangedSubview(colorView6)

        stackView1.layoutIfNeeded()
        print(stackView1.frame)
        
        colorViewSetting()
    }
    
    private func colorViewSetting() {
        colorView1.backgroundColor = UIColor(hexFromString: colorList[0])
        colorView2.backgroundColor = UIColor(hexFromString: colorList[1])
        colorView3.backgroundColor = UIColor(hexFromString: colorList[2])
        colorView4.backgroundColor = UIColor(hexFromString: colorList[3])
        colorView5.backgroundColor = UIColor(hexFromString: colorList[4])
        colorView6.backgroundColor = UIColor(hexFromString: colorList[5])
        
        colorView1.cardViewModel = cardViewModel
        colorView2.cardViewModel = cardViewModel
        colorView3.cardViewModel = cardViewModel
        colorView4.cardViewModel = cardViewModel
        colorView5.cardViewModel = cardViewModel
        colorView6.cardViewModel = cardViewModel
    }
}

class TouchColorView: UIButton {
    
    var cardViewModel: CardViewModel = CardViewModel()
    var maxColorList = 3
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
//            guard let cardViewModel = cardViewModel else { return }
            
            if newValue {
                UIView.animate(withDuration: 0.5) {
                    self.layer.borderWidth = 1
                }
                cardViewModel.listAppend(view: self)
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.layer.borderWidth = 0
                }
                cardViewModel.listRemove(view: self)
            }

            super.isSelected = newValue
        }
    }
    
    
    public func backGroundColorSetting(color: UIColor) {
        self.backgroundColor = color
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isSelected = !isSelected
    }
    
}
