//
//  ViewModel.swift
//  sample-RxSwift
//
//  Created by Yudai Fujioka on 2021/08/12.
//

import Foundation
import RxSwift

final class ViewModel {
    
    private let disposeBug = DisposeBag()
    //ViewModelから出ていく情報
    var textOutPut = PublishSubject<String>()
    
    //ViewControllerから入ってくる情報
    var textInput: AnyObserver<String> {
        textOutPut.asObserver()
    }
    
    
    
    init() {
        textOutPut
            .asObservable()
            .subscribe { text in
                print("text情報です:\(text)")
            }
            .disposed(by: disposeBug)

    }
}
