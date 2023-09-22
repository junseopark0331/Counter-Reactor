import UIKit
import ReactorKit
import RxSwift


class CounterViewReactor: Reactor {
    
    let initialState: State
    
    init() {
        self.initialState = State(
            value: 0,
            isLoading: false
        )
    }
    
    enum Action {
        case plus
        case minus
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
        case setAlertMessage(String)
    }
    
    struct State {
        var value: Int
        var isLoading: Bool
        @Pulse var alertMessage: String?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .plus:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.increaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false)),
                Observable.just(Mutation.setAlertMessage("increased!"))
            ])
        case .minus:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false)),
                Observable.just(Mutation.setAlertMessage("decreased!"))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .increaseValue :
            state.value += 1
        case .decreaseValue :
            state.value -= 1
        case let .setLoading(isLoading) :
            state.isLoading = isLoading
        case let .setAlertMessage(message) :
            state.alertMessage = message
        }
        return state
    }
}
