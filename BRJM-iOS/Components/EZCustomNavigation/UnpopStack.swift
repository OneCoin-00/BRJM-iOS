import Foundation
import UIKit


class UnpopStack {
    
    let config: EZUnpopConfiguration
    private var stack: [UIViewController] = []
    var count: Int {
        return stack.count
    }
    let debouncer: EZDebouncer?
    
    init(config: EZUnpopConfiguration) {
        self.config = config
        if let ttl = config.ttl {
            self.debouncer = EZDebouncer(interval: ttl)
            debouncer?.callback = { [weak self] in
                self?.clear()
            }
        } else {
            self.debouncer = nil
        }
    }
    
    func push(_ vc: UIViewController) {
        debouncer?.call()
        if stack.count >= config.stackDepth {
            // KSJ(stack.removeFirst())
            if stack.count > 0 { stack.removeFirst() }
        }
        
        // KSJ
        if config.stackDepth == 0 { return }
        
        stack.append(vc)
    }
    
    func pop() -> UIViewController? {
        debouncer?.call()
        return stack.popLast()
    }
    
    func clear() {
        stack.removeAll()
    }
}
