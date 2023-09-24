import UIKit
import SnapKit
import Then
import RxCocoa
import ReactorKit

class ViewController: UIViewController, View {
    
    var disposeBag = DisposeBag()
    
    init(reactor: CounterViewReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let loadingIndicator = UIActivityIndicatorView()
    
    private let decreaseButton = UIButton().then {
        $0.setTitleColor(UIColor.blue, for: .normal)
        $0.setTitle("-", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 30)
    }
    
    private let numberLabel = UILabel().then {
        $0.text = "0"
        $0.textAlignment = .center
        $0.textColor = UIColor.black
    }
    
    private let increaseButton = UIButton().then {
        $0.setTitleColor(UIColor.blue, for: .normal)
        $0.setTitle("+", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 30)
    }
    
    private let stackView = UIStackView().then {
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.spacing = 120
        $0.distribution = .equalSpacing
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addview()
        setLayout()
    }
    
    private func addview() {
        //        view.addSubview(loadingIndicator)
        
        self.view.addSubview(self.stackView)
        [decreaseButton,numberLabel,increaseButton].map {
            self.stackView.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        self.stackView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    func bind(reactor: CounterViewReactor) {
        decreaseButton.rx.tap
            .map{Reactor.Action.decrease}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        increaseButton.rx.tap
            .map{Reactor.Action.increase}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        reactor.state
            .map{String($0.value)}
            .distinctUntilChanged()
            .bind(to: numberLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}
