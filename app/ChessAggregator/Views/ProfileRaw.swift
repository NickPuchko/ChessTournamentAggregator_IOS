
import UIKit

class ProfileRaw: AutoLayoutView {

    let mainView = UIView()
    let label = UILabel()
    let arrow = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    init(name: String) {
        super.init(frame: .zero)
                
        label.text = name
        setup()
    }
    
    private func setup() {
        
        mainView.backgroundColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(label)
        mainView.addSubview(arrow)
    }
    
    private var didSetupConstraints: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupConstraints() {
        super.setupConstraints()
        
        addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.heightAnchor.constraint(equalTo: superview!.heightAnchor),
            mainView.widthAnchor.constraint(equalTo: superview!.widthAnchor),
            mainView.centerXAnchor.constraint(equalTo: superview!.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: superview!.centerYAnchor),
            
            label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            
            arrow.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            arrow.centerYAnchor.constraint(equalTo: label.centerYAnchor)
        ])
    }
}
