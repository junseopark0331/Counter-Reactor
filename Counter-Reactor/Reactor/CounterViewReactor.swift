import UIKit
import ReactorKit
import RxSwift

class CounterViewReactor: Reactor {
    
    let initialState = State()
    
    //View의 Action 정의
    enum Action {
        case increase
        case decrease
    }
    
    //Action을 받을 Mutation 정의
    enum Mutation {
        case increaseValue
        case decreaseValue
    }
    
    struct State {
        var value: Int = 0
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.just(Mutation.increaseValue)
        case .decrease:
            return Observable.just(Mutation.decreaseValue)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        }
        return newState
    }
}
