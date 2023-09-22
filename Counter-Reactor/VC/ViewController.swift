import UIKit
import SnapKit
import Then
import RxCocoa
import ReactorKit


class ViewController: UIViewController {
    
    private let minusButton = UIButton().then {
        $0.setTitleColor(UIColor.blue, for: .normal)
        $0.setTitle("-", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 30)
    }
    
    private let numberLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = UIColor.black
    }
    
    private let plusButton = UIButton().then {
        $0.tintColor = UIColor.blue
        $0.setTitle("+", for: .normal)
    }
    
    private let loadingIndicator = UIActivityIndicatorView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addview()
        setLayout()
    }
    
    private func addview() {
        view.addSubview(minusButton)
//        view.addSubview(numberLabel)
        view.addSubview(plusButton)
//        view.addSubview(loadingIndicator)
    }
    
    private func setLayout() {
        self.minusButton.snp.makeConstraints {
            $0.height.width.equalTo(50)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(80)
        }
        self.minusButton.snp.makeConstraints {
            $0.height.width.equalTo(50)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(80)
        }
    }
    
    


}

