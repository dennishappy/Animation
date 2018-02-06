//
//  ViewController.swift
//  Animation
//
//  Created by yaoxinpan on 2018/1/26.
//  Copyright © 2018年 yaoxp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var bottonViewTop: NSLayoutConstraint!
    @IBOutlet weak var animationViewBottom: NSLayoutConstraint!
    
    // 1.无动画；2.普通动画；3.从中间开始的动画；4.在2的基础上中间线变宽，最后恢复；
    @IBOutlet weak var animationStyle: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.isX() {
            bottonViewTop.constant = 88
            animationViewBottom.constant = 38
        } else {
            bottonViewTop.constant = 64
            animationViewBottom.constant = 0
        }
        title = "学习贝塞尔曲线"
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetAnimationView() {
        if let sublayers = animationView.layer.sublayers {
            for layer in sublayers {
                layer.removeFromSuperlayer()
            }
        }

    }
    
    @IBAction func onBrokenLineButton(_ sender: Any) {
        resetAnimationView()
        
        let linePath = UIBezierPath()
        
        // 起点
        linePath.move(to: CGPoint.init(x: 20, y: 20))
        
        // 拐点
        linePath.addLine(to: CGPoint.init(x:160, y:160))

        // 终点
        linePath.addLine(to: CGPoint.init(x: 180, y: 50))
        
        // 画布
        let shapeLayer = CAShapeLayer()
        
        // 画布大小
        shapeLayer.bounds = animationView.bounds
        
        // 画布在画板上的位置。
        // 可以这么理解：用一个图钉将一张画布钉在画板上，
        // postion是图钉在画板上的位置，anchorPoint是图钉在画布上的位置
        shapeLayer.position = CGPoint.zero
        shapeLayer.anchorPoint = CGPoint.zero
        
        // 线的宽度
        shapeLayer.lineWidth = 10.0
        
        // 线终点式样
//        shapeLayer.lineCap = kCALineCapSquare
//        shapeLayer.lineCap = kCALineCapButt
        shapeLayer.lineCap = kCALineCapRound
        
        // 线的颜色
        shapeLayer.strokeColor = UIColor.orange.cgColor
        
        // 线的路径
        shapeLayer.path = linePath.cgPath
        
        // 线围成区域的填充颜色
        shapeLayer.fillColor = nil
        
        // 添加动画效果
        addAnimationTo(layer: shapeLayer)
        
        animationView.layer.addSublayer(shapeLayer)
    }

    @IBAction func onTriangleButton(_ sender: Any) {
        resetAnimationView()
        
        let linePath = UIBezierPath()
        
        // 起点
        linePath.move(to: CGPoint.init(x: 20, y: 20))
        
        // 拐点
        linePath.addLine(to: CGPoint.init(x:160, y:160))
        
        // 终点
        linePath.addLine(to: CGPoint.init(x: 180, y: 50))
        
        linePath.close()
        
        // 画布
        let shapeLayer = CAShapeLayer()
        
        // 画布大小
        shapeLayer.bounds = animationView.bounds
        
        // 画布在画板上的位置。
        // 可以这么理解：用一个图钉将一张画布钉在画板上，
        // postion是图钉在画板上的位置，anchorPoint是图钉在画布上的位置
        shapeLayer.position = CGPoint.zero
        shapeLayer.anchorPoint = CGPoint.zero
        
        // 线的宽度
        shapeLayer.lineWidth = 2.0
        
        // 线的颜色
        shapeLayer.strokeColor = UIColor.orange.cgColor
        
        // 线拐点式样
//        shapeLayer.lineJoin = kCALineJoinBevel
//        shapeLayer.lineJoin = kCALineJoinMiter
        shapeLayer.lineJoin = kCALineJoinRound
        
        // 线的路径
        shapeLayer.path = linePath.cgPath
        
        // 线围成区域的填充颜色
        shapeLayer.fillColor = nil
        
        // 添加动画效果
        addAnimationTo(layer: shapeLayer)
        
        animationView.layer.addSublayer(shapeLayer)
    }
    
    @IBAction func onPolygonButton(_ sender: Any) {
        resetAnimationView()
        
        let polygonPath = UIBezierPath()
        polygonPath.move(to: CGPoint.init(x: 100, y: 0.0))
        polygonPath.addLine(to: CGPoint.init(x: 200, y: 40))
        polygonPath.addLine(to: CGPoint.init(x: 160, y: 140))
        polygonPath.addLine(to: CGPoint.init(x: 40, y: 140))
        polygonPath.addLine(to: CGPoint.init(x: 0, y: 40))
        polygonPath.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = animationView.bounds
        shapeLayer.position = CGPoint.init(x: 100, y: 100)
        shapeLayer.anchorPoint = CGPoint.zero
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.fillColor = nil;
        shapeLayer.path = polygonPath.cgPath
        addAnimationTo(layer: shapeLayer)
        animationView.layer.addSublayer(shapeLayer)
    }
    
    @IBAction func onCurveButton(_ sender: Any) {
        resetAnimationView()
        
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: 100, y: 100))
        path.addLine(to: CGPoint.init(x: 200, y: 200))
        path.addArc(withCenter: CGPoint.init(x: 200, y: 200), radius: 50, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.fillColor = nil
        shapeLayer.position = CGPoint.zero
        shapeLayer.anchorPoint = CGPoint.zero
        shapeLayer.bounds = animationView.bounds
        addAnimationTo(layer: shapeLayer)
        animationView.layer.addSublayer(shapeLayer)
    }
    
}

extension ViewController {
    func addAnimationTo(layer: CAShapeLayer) {
        let animationIndex = animationStyle.selectedSegmentIndex
        switch animationIndex {
        case 1:
            addOneAnimation(layer: layer, duration: 1.5)
        case 2:
            addTwoAnimation(layer: layer, duration: 1.5)
        case 3:
            addThreeAnimation(layer: layer, duration: 1.5)
        default:
            print(" ")
        }
    }
    
    
    func addOneAnimation(layer: CAShapeLayer, duration: CFTimeInterval) {
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = duration
        layer.add(animation, forKey: nil)
    }
    
    func addTwoAnimation(layer: CAShapeLayer, duration: CFTimeInterval) {
        let animationBegin = CABasicAnimation.init(keyPath: "strokeStart")
        animationBegin.fromValue = 0.5
        animationBegin.toValue = 0
        animationBegin.duration = duration
        let animationEnd = CABasicAnimation.init(keyPath: "strokeEnd")
        animationEnd.fromValue = 0.5
        animationEnd.toValue = 1
        animationEnd.duration = duration
        layer.add(animationBegin, forKey: nil)
        layer.add(animationEnd, forKey: nil)
    }
    
    func addThreeAnimation(layer: CAShapeLayer, duration: CFTimeInterval) {
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = duration
        let animationWidth = CABasicAnimation.init(keyPath: "lineWidth")
        animationWidth.fromValue = 1
        animationWidth.toValue = 10
        animationWidth.duration = 1.5
        layer.add(animation, forKey: nil)
        layer.add(animationWidth, forKey: nil)
    }
}
