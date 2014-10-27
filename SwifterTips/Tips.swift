//
//  Tips.swift
//  SwifterTips
//
//  Created by Moch on 10/19/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

import Foundation

// MARK: - func
// MARK: 产 32 位 和 64 位平台通用的生随机数
func randomInRange(range: Range<Int>) -> Int {
    let count = UInt32(range.endIndex - range.endIndex)
    return Int(arc4random_uniform(count)) + range.startIndex
}

// MARK: - extensions
// MARK: 数组下标为数组的取值，设值
extension Array {
    subscript(input: [Int]) -> Slice<T> {
        get {
            var result = Slice<T>()
            for i in input {
                assert(i < self.count, "Index out of range")
                result.append(self[i])
            }
            return result
        }
        set {
            for (index,i) in enumerate(input) {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

// MARK: - Others
// MARK: 正则表达式
struct RegexHelper {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
        var error: NSError?
        regex = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)
    }
    
    func match(input: String) -> Bool {
        let matches = regex?.matchesInString(input, options: nil, range: NSMakeRange(0, countElements(input)))
         return matches?.count > 0
    }
}

infix operator =~ {
    associativity none
    precedence 130
}

func =~(lhs: String, rhs: String) -> Bool {
    return RegexHelper(rhs).match(lhs)
}

// MARK: 重载 =~
func ~=(pattern: NSRegularExpression, input: String) -> Bool {
    return pattern.numberOfMatchesInString(input, options: nil, range: NSRange(location: 0, length: countElements(input))) > 0
}

// MARK: 字符串转为正则表达式
prefix operator ~/ {}
prefix func ~/(pattern: String) -> NSRegularExpression? {
    return NSRegularExpression(pattern: pattern, options: nil, error: nil)
}

// MARK: - 多线程
// MARK: 封装 GCD 延迟调用
typealias Task = (cancel: Bool) -> ()

func delay(time: NSTimeInterval, task: () -> ()) -> Task? {
    func dispatch_later(block: () -> ()) {
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW,
            Int64(time * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue(), block)
    }
    
    var closure: dispatch_block_t? = task
    var result: Task?
    
    let delayedClosure: Task = {
        if let internalClosure = closure {
            if $0 == false {
                dispatch_async(dispatch_get_main_queue(), internalClosure)
            }
        }
        
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(cancel: false)
        }
    }
    
    return result
}

func cancel(task: Task?) {
    task?(cancel: true)
}

// MARK: 模拟 kvc
/**
根据 key 获取对应的值

:param: object 从哪个对象种获取
:param: key    key 值

:returns: 取得的值
*/
func valueFrom(object: Any, key: String) -> Any? {
    let mirror = reflect(object)
    for index in 0..<mirror.count {
        let (targetKey, targetMirror) = mirror[index]
        if key == targetKey {
            return targetMirror.value
        }
    }
    
    return nil
}


// MARK:

extension Double {
    /**
    格式化 Double
    
    :param: f 格式化字符串
    
    :returns: 格式化后的字符串
    */
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
        
    }
}

// MARK: log
func printLog<T>(message: T, file: String = __FILE__, method: String = __FUNCTION__, line: Int = __LINE__) {
#if DEBUG
    println("\(file.lastPathComponent)[\(line)], \(method): \(message)")
#endif
}












































