
import UIKit

class Divider: UIView {
    var dividerView: UIView
    init() {
        dividerView = UIView()
        super.init(frame: .zero)
        
        dividerView.backgroundColor = .white
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.widthAnchor.constraint(equalTo: superview!.widthAnchor).isActive = true
        dividerView.centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
