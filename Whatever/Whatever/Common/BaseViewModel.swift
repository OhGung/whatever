//
//  BaseViewModel.swift
//  Whatever
//
//  Created by sei on 2023/06/13.
//

import Foundation

open class BaseViewModel {

    public init() {
        debugPrint("💡 init ViewModel [\(String(describing: self))]")
    }

    deinit {
        debugPrint("♻️ deinit ViewModel [\(String(describing: self))]")
    }

}
