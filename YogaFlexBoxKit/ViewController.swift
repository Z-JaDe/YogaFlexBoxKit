//
//  ViewController.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/5/27.
//  Copyright © 2019 zjade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let child = CenterLayoutViewController()
        let child = CornerLayoutViewController()
        self.addChild(child)
        self.view.addSubview(child.view)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        test()
    }
}
///release下测试更精准
let 测试次数 = 100
let 每次测试循环次数 = 1000
func test() {
    let startTime = CFAbsoluteTimeGetCurrent()
    let corner = testTime(cornerTimerTest)
    let center = testTime(centerTimerTest)
    print("corner yoga算: \(corner.0) 自己算: \(corner.1)")
    print("center yoga算: \(center.0) 自己算: \(center.1)")
    group.notify(queue: DispatchQueue.main) {
        let endTime = CFAbsoluteTimeGetCurrent()
        let diff:Double = (endTime - startTime) * 1000
        print("结束: " + String(diff) + " 毫秒(ms)")
    }
}
func testTime(_ testFunc: @escaping (Bool, CGSize) -> Double) -> (Double, Double) {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var sumYoga: Double = 0
    var sumLayout: Double = 0
    for _ in 0..<测试次数 {
        let width = CGFloat(Int(CGFloat.random(in: screenWidth/2...screenWidth)))
        let height = CGFloat(Int(CGFloat.random(in: screenWidth/2...screenHeight)))
        let size = CGSize(width: width, height: height)
        sumYoga += testFunc(true, size)
        sumLayout += testFunc(false, size)
        print("width：\(size.width) height：\(size.height)\n")
    }
    return (sumYoga / Double(测试次数), sumLayout / Double(测试次数))
}
let group: DispatchGroup = DispatchGroup()
let queue: OperationQueue = {
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 1
    return queue
}()
func runTest(_ id: String, closure: @escaping () -> Void) -> Double {
//    queue.addOperation {
//        group.enter()
//        group.leave()
//    }
    let startTime = CFAbsoluteTimeGetCurrent()
    for _ in 0..<每次测试循环次数 {
        closure()
    }
    let endTime = CFAbsoluteTimeGetCurrent()
    let diff:Double = (endTime - startTime) * 1000
    print(id + ": " + String(diff) + " 毫秒(ms)")
    return diff
}
// MARK -
func cornerTimerTest(_ value: Bool, _ size: CGSize) -> Double {
    let view = UIView()
    let cornerlayout = YogaFlexBoxKit.CornerLayoutTest()
    cornerlayout.test(in: view, isUseYoga: value)
    
    let id = (value ? "yoga" : "layout") + " corner"
    return runTest(id) {
        cornerlayout.reload(in: view, size: size)
    }
}
func centerTimerTest(_ value: Bool, _ size: CGSize) -> Double {
    let view = UIView()
    let centerlayout = YogaFlexBoxKit.CenterLayoutTest()
    centerlayout.test(in: view, isUseYoga: value)
    
    let id = (value ? "yoga" : "layout") + " center"
    return runTest(id) {
        centerlayout.reload(in: view, size: size)
    }
}
