//
//  CardView.swift
//  DrawingSample
//
//  Created by omaestra on 08/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {
    @IBInspectable
    var icon: String = "🍎" {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var titleString: String = "" {
        didSet {
            setNeedsLayout()
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var isFaceUp: Bool = true {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    /**
     Corner radius of the card.
     */
    @IBInspectable public var cardRadius: CGFloat = 20 {
        didSet{
            self.layer.cornerRadius = cardRadius
        }
    }
    
    private lazy var characterLabel: UILabel = {
        let label = UILabel()
        addSubview(label)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .white
        addSubview(label)
        return label
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    // MARK: - Setup View
    private func setup() {
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        characterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0).isActive = true
        characterLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15.0).isActive = true
        characterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0).isActive = true
        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: characterLabel.bottomAnchor, constant: 15.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15.0).isActive = true
    }
    
    // MARK: - Instance methods.
    
    @objc func adjustCardViewScale(byHandlingGestureRecognizerBy recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed:
            self.transform = CGAffineTransform(scaleX: recognizer.scale, y: recognizer.scale)
        case .ended:
            UIView.animate(withDuration: 0.5) {
                self.transform = CGAffineTransform.identity
            }
        default:
            break
        }
    }

    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle:paragraphStyle, .font: font])
    }
    
    private var iconAttributedString: NSAttributedString {
        return centeredAttributedString(icon, fontSize: 120)
    }
    
    private var titleAttributedString: NSAttributedString {
        return centeredAttributedString(titleString, fontSize: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        characterLabel.attributedText = iconAttributedString
        characterLabel.isHidden = !isFaceUp
        titleLabel.attributedText = titleAttributedString
        titleLabel.isHidden = !isFaceUp
//        characterLabel.center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        layer.masksToBounds = true
//        layer.shadowRadius = 3.0
//        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        layer.shadowOpacity = 0.3
    }

    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cardRadius)
        roundedRect.addClip()
//        #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).setFill()
        self.backgroundColor?.setFill()
        roundedRect.fill()
    }
}

extension CardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
}

extension CGRect {
    func zoom(by zoomFactor: CGFloat) -> CGRect {
        let zoomedWidth = size.width * zoomFactor
        let zoomedHeight = size.height * zoomFactor
        let originX = origin.x + (size.width - zoomedWidth) / 2
        let originY = origin.y + (size.height - zoomedHeight) / 2
        return CGRect(origin: CGPoint(x: originX,y: originY) , size: CGSize(width: zoomedWidth, height: zoomedHeight))
    }
}
