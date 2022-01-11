//
//  ExampleCardView.swift
//  ColorBasketApp
//
//  Created by apple on 2021/10/08.
//

import UIKit

class ExampleCardView: NeumorphicView {
    var colorList: [UIColor] = []
    let cardViewModel: CardViewModel = CardViewModel()
    
    func createSubviews() {
        self.layoutIfNeeded()
    }
    
    public func animateStart() {
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat]) {
            self.center.y += 30
        }
    }
}

class ExampleCardBasketCardView: ExampleCardView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Color Basket"
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
        
        return label
    }()
    
    private func setupView() {
        self.addSubview(titleLabel)
    }
    
    override func createSubviews() {
        super.createSubviews()
        setupView()
        colorList = cardViewModel.getColorList(maxCount: 2, index: 0)
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: frame.width/2, y: frame.height/2 - 100)
        titleLabel.textColor = colorList[1]
        createBasketHandle()
        createBasketBody()
    }
    
    private func createBasketHandle() {
        let handleSize = self.frame.width/2
        let center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        let beizerPath = UIBezierPath()
        beizerPath.move(to: center)
        beizerPath.addArc(withCenter: center, radius: handleSize/2, startAngle: .pi, endAngle: 0, clockwise: true)
        beizerPath.close()
        let handleShapeLayer = CAShapeLayer()
        handleShapeLayer.path = beizerPath.cgPath
        handleShapeLayer.lineWidth = 5
        handleShapeLayer.strokeColor = colorList[0].cgColor
        handleShapeLayer.fillColor = UIColor.white.cgColor
        
        self.layer.addSublayer(handleShapeLayer)

    }
    
    private func createBasketBody() {
        let startPoint = CGPoint(x: (self.frame.width/4)/2, y: self.frame.height/2)
        let beizerPath = UIBezierPath()
        beizerPath.move(to: startPoint)
        beizerPath.addLine(to: CGPoint(x: startPoint.x*7, y: self.frame.height*0.5))
        beizerPath.addLine(to: CGPoint(x: startPoint.x*6, y: self.frame.height*0.75))
        beizerPath.addLine(to: CGPoint(x: startPoint.x*2, y: self.frame.height*0.75))
        beizerPath.close()
        
        let bodyShapeLayer = CAShapeLayer()
        bodyShapeLayer.path = beizerPath.cgPath
        bodyShapeLayer.lineWidth = 5
        bodyShapeLayer.strokeColor = colorList[0].cgColor
        bodyShapeLayer.fillColor = UIColor.white.cgColor
        
        self.layer.addSublayer(bodyShapeLayer)
        
    }
}
class ExampleCardPictureView: ExampleCardView {
    var imageView = UIImageView()
    let mainTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.text = "mainText"
        return label
    }()
    let subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        label.text = "subText"
        return label
    }()
    
    override func createSubviews() {
        super.createSubviews()
        let pictureLayer = createPictureLayer()
        imageView = imageViewFrameSetting()
        imageView.layer.addSublayer(pictureLayer)
        imageView.layer.mask = pictureLayer
        
        mainTitle.origin(CGPoint(x: imageView.frame.minX, y: imageView.frame.maxY))
        mainTitle.sizeToFit()
        subTitle.origin(CGPoint(x: mainTitle.frame.minX, y: mainTitle.frame.maxY))
        subTitle.sizeToFit()
                
        self.addSubview(imageView)
        self.addSubview(mainTitle)
        self.addSubview(subTitle)
        
        setColor()
    }
    
    private func imageViewFrameSetting() -> UIImageView {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: self.frame.width/4, y: self.frame.height/5, width: self.frame.width/2, height: (self.frame.height/2))
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    private func createPictureLayer() -> CAShapeLayer {
        let startPoint = CGPoint(x: self.frame.width/4, y: self.frame.height/4)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: startPoint.y*2))
        path.addCurve(to: CGPoint(x: startPoint.x*2, y: startPoint.y*2), controlPoint1: CGPoint(x: 0, y: -50), controlPoint2: CGPoint(x: startPoint.x*2, y: -50))
        path.close()
        
        let pictureLayer = CAShapeLayer()
        pictureLayer.path = path.cgPath
        pictureLayer.lineWidth = 5
        pictureLayer.strokeColor = UIColor.black.cgColor
        pictureLayer.fillColor = UIColor.black.cgColor

        return pictureLayer
    }
    
    private func setColor() {
        colorList = cardViewModel.getColorList(maxCount: 3, index: 1)
        self.backgroundColor = colorList[0]
        mainTitle.textColor = colorList[1]
        subTitle.textColor = colorList[2]
    }
}
class ExampleCardWiseSayingView: ExampleCardView {
    let wiseSaying: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "HelveticaNeue-Ligh", size: 15)
        lable.text = "나는 실패한 게 아니다. 나는 잘 되지 않는 방법 1만 가지를 발견한 것이다"
        lable.numberOfLines = 10
        return lable
    }()
    let byName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        label.text = "by 토마스 에디슨"
        return label
    }()
    
    override func createSubviews() {
        super.createSubviews()
        let wiseSayingLine = createTopLine()
        self.layer.addSublayer(wiseSayingLine)
        
        self.addSubview(wiseSaying)
        self.addSubview(byName)
        
        colorList = cardViewModel.getColorList(maxCount: 3, index: 2)
        
        wiseSayingLine.strokeColor = colorList[0].cgColor
        wiseSayingLine.fillColor = colorList[0].cgColor
        wiseSaying.textColor = colorList[1]
        byName.textColor = colorList[2]
        
        wiseSayingLabelSetting()
        
    }
    
    private func wiseSayingLabelSetting() {
        wiseSaying.translatesAutoresizingMaskIntoConstraints = false
        wiseSaying.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        wiseSaying.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        wiseSaying.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        byName.translatesAutoresizingMaskIntoConstraints = false
        byName.topAnchor.constraint(equalTo: wiseSaying.bottomAnchor, constant: 15).isActive = true
        byName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
    }
    
    private func createTopLine() ->CAShapeLayer {
        
        let startPoint = CGPoint(x: self.frame.width/8, y: self.frame.height/8)
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: startPoint.x*4, y: startPoint.y))
        path.addArc(withCenter: CGPoint(x: startPoint.x*4, y: startPoint.y), radius: 8, startAngle: 0, endAngle: .pi*2, clockwise: true)
        path.addLine(to: CGPoint(x: startPoint.x*7, y: startPoint.y))
        
        let topLineLayer = CAShapeLayer()
        topLineLayer.path = path.cgPath
        topLineLayer.lineWidth = 2
        topLineLayer.strokeColor = UIColor.black.cgColor
        
        return topLineLayer
    }
}
class ExampleCardPhotoFrameView: ExampleCardView {
    let photoFrameView = UIView()
    let photoImageView = UIImageView()
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        lb.text = "Title"
        return lb
    }()
    let todayLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "HelveticaNeue-Ligh", size: 15)
        return lb
    }()
    
    override func createSubviews() {
        super.createSubviews()
        
        colorList = cardViewModel.getColorList(maxCount: 3, index: 3)
        
        self.addSubview(photoFrameView)
        photoFrameView.addSubview(photoImageView)
        photoFrameView.addSubview(titleLabel)
        photoFrameView.addSubview(todayLabel)
        
        titleLabel.textColor = colorList[0]
        todayLabel.textColor = colorList[1]
        
        todayLabel.text = "\(todayToString())"
        
        createPhotoFrame()
    }
    
    private func createPhotoFrame() {
        
        photoFrameView.translatesAutoresizingMaskIntoConstraints = false
        photoFrameView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        photoFrameView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        photoFrameView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        photoFrameView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        photoFrameView.layer.borderWidth = 5
        photoFrameView.layer.borderColor = colorList[2].cgColor
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: photoFrameView.topAnchor, constant: 20).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: photoFrameView.centerXAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: photoFrameView.widthAnchor, multiplier: 0.8).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: photoFrameView.heightAnchor, multiplier: 0.6).isActive = true
        photoImageView.image = UIImage(named: "test")
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: photoFrameView.centerXAnchor).isActive = true
        
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        todayLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        todayLabel.centerXAnchor.constraint(equalTo: photoFrameView.centerXAnchor).isActive = true
    }
    
    private func todayToString() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.mm.dd"
        return dateFormatter.string(from: today)
    }
}
class ExampleCardTextView: ExampleCardView {
    let text = UILabel()
    
    override func createSubviews() {
        super.createSubviews()
        
        colorList = cardViewModel.getColorList(maxCount: 2, index: 4)
        self.addSubview(text)
        
        text.textColor = colorList[0]
        self.backgroundColor = colorList[1]
        createText()
    }
    
    func createText() {
        text.font = UIFont(name: "Superclarendon Black", size: 50)
        text.numberOfLines = 4
        text.text = "I\nLOVE\nYOU\n♥︎"
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        text.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        text.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        text.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        text.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
}
class ExampleCardProfileView: ExampleCardView {
    let profileImageView = UIImageView()
    let nickName: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        lb.text = "Cat"
        return lb
    }()
    let tagStackView = UIStackView()
    let hashTag: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "HelveticaNeue-Ligh", size: 17)
        lb.text = "#test\n#testtest"
        lb.textAlignment = .center
        lb.numberOfLines = 2
        return lb
    }()
    
    override func createSubviews() {
        super.createSubviews()
        
        colorList = cardViewModel.getColorList(maxCount: 3, index: 5)
        
        self.addSubview(profileImageView)
        self.addSubview(nickName)
        self.addSubview(tagStackView)
        self.addSubview(hashTag)
        
        nickName.textColor = colorList[0]
        tagStackView.tintColor = colorList[1]
        hashTag.textColor = colorList[2]
        
        settings()
    }
    
    func settings() {
                
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true
        profileImageView.image = UIImage(named: "test")
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.layer.masksToBounds = true
        
        nickName.translatesAutoresizingMaskIntoConstraints = false
        nickName.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15).isActive = true
        nickName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        tagStackView.translatesAutoresizingMaskIntoConstraints = false
        tagStackView.topAnchor.constraint(equalTo: nickName.bottomAnchor, constant: 15).isActive = true
        tagStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tagStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        tagStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        tagStackView.layer.borderWidth = 2
        tagStackView.layer.borderColor = UIColor.black.cgColor
        
        hashTag.translatesAutoresizingMaskIntoConstraints = false
        hashTag.topAnchor.constraint(equalTo: tagStackView.bottomAnchor, constant: 15).isActive = true
        hashTag.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}

class ExampleCardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    func setupView() {
        view.backgroundColor = UIColor(hexFromString: "EFEEEE")
        let test = ExampleCardProfileView()
        
        view.addSubview(test)
        test.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        test.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        test.heightAnchor.constraint(equalToConstant: 400).isActive = true
        test.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        test.createSubviews()
        
    }
}

#if canImport(SwiftUI)
import SwiftUI
@available(iOS 13.0, *)

struct ExampleCardVCRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return ExampleCardViewController().view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}

struct ExampleCardVCPreview: PreviewProvider {
    static var previews: some View {
        Group {
            ExampleCardVCRepresentable()
                .previewDevice("iPhone SE (2nd generation)")
            ExampleCardVCRepresentable()
                .previewDevice("iPhone 12")
        }
    }
}
#endif
