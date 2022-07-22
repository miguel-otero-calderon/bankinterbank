//
//  Extensions.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import Foundation
import Alamofire
import UIKit


// MARK: - UIView
extension UIView {
    
    // MARK: - Inspectables
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            return self.borderColor
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var circular: Bool {
        get {
            return self.circular
        }
        set {
            if newValue {
                self.layer.cornerRadius = self.frame.size.width/2
                self.clipsToBounds = true
            }
        }
    }
    
    @IBInspectable var shadow: Bool{
        get{ return false }
        set{
            
            if newValue {
                self.layer.masksToBounds = false
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOpacity = 0.12
                self.layer.shadowOffset = CGSize(width: 0, height: 0)
                self.layer.shadowRadius = 5
            }else{
                self.layer.masksToBounds = true
            }
        }
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat, shadow: Bool = false) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.015) {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
            
            if shadow {
                let shadowView: UIView = UIView()
                shadowView.backgroundColor = self.backgroundColor
                shadowView.layer.cornerRadius = radius
                shadowView.layer.shadowColor = UIColor.black.cgColor
                shadowView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
                shadowView.layer.shadowOpacity = 0.5
                shadowView.layer.shadowRadius = 5
                self.superview?.insertSubview(shadowView, belowSubview: self)
                shadowView.frame = self.frame
            }
        }
    }
    
    func addBottomShadow() {
        let shadowPath = UIBezierPath()
        // Creating bottom shadow
        shadowPath.move(to: CGPoint(x: self.bounds.origin.x, y: self.bounds.size.height))
        shadowPath.addLine(to: CGPoint(x: self.bounds.width / 2, y: self.bounds.height + 4.0))
        shadowPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        shadowPath.close()
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowRadius = 5
    }
    
    func shake(){
        let anim = CABasicAnimation(keyPath: "shake")
        anim.duration = 0.05
        anim.repeatCount = 5
        anim.autoreverses = true
        anim.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
        anim.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
        
        layer.add(anim, forKey: "shake")
    }
    
    enum BounceDirection {
        case multiple
        case vertical
        case horizontal
    }
    
    func bounce(in direction: BounceDirection){
        let anim = CABasicAnimation(keyPath: "bounce")
        
        switch direction {
        case .multiple:
            break
        case .vertical:
            anim.duration = 0.05
            anim.repeatCount = 5
            anim.autoreverses = true
            anim.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
            anim.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
            break
        case .horizontal:
            anim.duration = 0.05
            anim.repeatCount = 5
            anim.autoreverses = true
            anim.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
            anim.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
            break
        }
        
        layer.add(anim, forKey: "bounce")
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func fadeIn(at duration: TimeInterval, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.alpha = 1
        }) { (_) in
            completion?()
        }
    }
    
    func fadeOut(at duration: TimeInterval, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: { [weak self] in
            self?.alpha = 0
        }) { (_) in
            completion?()
        }
    }
    
    func addDashedBorder(color:UIColor, cornerRadius: CGFloat) {
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    var top: CGFloat {
        frame.origin.y
    }

    var bottom: CGFloat {
        frame.origin.y+height
    }

    var left: CGFloat {
        frame.origin.x
    }

    var right: CGFloat {
        frame.origin.x+width
    }

    var width: CGFloat {
        frame.size.width
    }

    var height: CGFloat {
        frame.size.height
    }
}
