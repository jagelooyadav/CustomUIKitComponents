//
//  SettingsTableView.swift
//  CustomUIKit
//
//  Created by Jageloo Yadav on 29/07/20.
//  Copyright © 2020 Jageloo. All rights reserved.
//

import UIKit


public protocol TableInfo {
    var icons: [UIImage] { get }
    var titles: [String] { get }
    var switchStatuses: [Bool] { get }
    var cornerRadius: CGFloat { get }
    var cellTypes: [CellType] { get }
    var layerAnimationDurations: [CGFloat] { get }
    var cameraBackImage: UIImage? { get }
    var camerFrontImage: UIImage? { get }
}

public extension TableInfo {
    var cornerRadius: Float { return 20.0 }
    var cellTypes: [CellType] { return [CellType]() }
    var layerAnimationDurations: [CGFloat] { return [] }
    
    var cameraBackImage: UIImage? { return nil }
    var camerFrontImage: UIImage? { return nil }
}

public enum CellType {
    case switchSettings
    case cheveron
    case progressHud
    case checkMark
    case crossMark
    case none
    case cameraBackImage
    case camerFrontImage
}

public class SettingsTableView: UITableView, UITableViewDelegate {
    let tableInfo: TableInfo
    let identifier = "settingIdentifier"
    
    public var switchUpdated: ((_ row: Int, _ status: Bool) -> Void)?
    
    public init(withTableInfo info: TableInfo) {
        self.tableInfo = info
        super.init(frame: .zero, style: .plain)
        self.delegate = self
        self.dataSource = self
        self.layer.cornerRadius = self.tableInfo.cornerRadius
        self.backgroundColor = .white
        let background = UIView()
        background.backgroundColor = .white
        self.backgroundView = UIView()
        self.estimatedRowHeight = 100.0
        self.rowHeight = UITableView.automaticDimension
        self.register(SettingCell.self, forCellReuseIdentifier: identifier)
        self.clipsToBounds = true
        self.isScrollEnabled = false
        self.separatorStyle = .none
        self.separatorColor = .clear
        self.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func reloadData() {
      super.reloadData()
      self.invalidateIntrinsicContentSize()
      self.layoutIfNeeded()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }
    
    public override var intrinsicContentSize: CGSize {
      return CGSize(width: contentSize.width, height: contentSize.height + 40)
    }
}

extension SettingsTableView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableInfo.titles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier) as? SettingCell else {
            fatalError()
        }
        
        cell.title = self.tableInfo.titles[indexPath.row]
        cell.leftIconImage = self.tableInfo.icons[indexPath.row]
        cell.switchStatus = self.tableInfo.switchStatuses[indexPath.row]
        cell.updateSwitchIndex(indexPath.row, rowCount: self.tableInfo.titles.count)
        cell.switchUpdated = { [weak self] index, status in
            self?.switchUpdated?(index, status)
        }
        cell.cameraBackImage = self.tableInfo.cameraBackImage
        cell.camerFrontImage = self.tableInfo.camerFrontImage
        
        cell.cellTypes = self.tableInfo.cellTypes
        if self.tableInfo.layerAnimationDurations.count > indexPath.row, cell.cellTypes[indexPath.row] == .progressHud {
            cell.animate(tillDuration: self.tableInfo.layerAnimationDurations[indexPath.row])
        } else {
            cell.removeAnimationLayer()
        }
        return cell
    }
}

fileprivate class SettingCell: UITableViewCell {
    private var cellContainerView = UIView()
    private let leftIcon = UIImageView()
    private let rightIcon = UIImageView()
    private let switchView = CustomSwitch()
    private let titleLabel = UILabel()
    private var index: Int = 0
    private var rowCount = 0
    var switchUpdated: ((_ row: Int, Bool) -> Void)?
    private let stack = UIStackView()
    let dividerView = DividerView()
    private var testingLabel = UILabel()
    
    lazy var linearAnimation: LinearLayerAnimation = {
        LinearLayerAnimation(lineWidth: 2.0, lineColor: UIColor(actualRed: 239.0, green: 110.0, blue: 92.0))
    }()

    private lazy var switchContainerView: UIView = {
        let containerView = UIView()
        containerView.addSubview(self.switchView)
        self.switchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.switchView.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: switchView.trailingAnchor),
            switchView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        self.switchView.onTintColor = UIColor.init(actualRed: 239.0, green: 110.0, blue: 92.0)
        self.switchView.addTarget(self, action: #selector(self.valueChanged(_:)), for: .valueChanged)
        return containerView
    }()
    
    private lazy var rightIconContainerView: UIView = {
        let containerView = UIView()
        containerView.addSubview(self.rightIcon)
        self.rightIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.rightIcon.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: rightIcon.trailingAnchor),
            rightIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        return containerView
    }()
    
    private lazy var testingContainerView: UIView = {
           let containerView = UIView()
           containerView.addSubview(self.testingLabel)
           self.testingLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               self.testingLabel.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor),
               containerView.trailingAnchor.constraint(equalTo: testingLabel.trailingAnchor),
               testingLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
           ])
           return containerView
       }()
    
    @objc private func valueChanged(_ sender: CustomSwitch) {
        self.switchUpdated?(sender.currentRow, sender.isOn)
    }
    
    private lazy var titleContainerView: UIView = {
        let containerView = UIView()
        containerView.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16.0),
            containerView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0)
        ])
        return containerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        self.contentView.addSubview(cellContainerView, insets: .zero)
        cellContainerView.translatesAutoresizingMaskIntoConstraints = false
        cellContainerView.addSubview(stack, insets: UIEdgeInsets.init(top: 0, left: 26, bottom: 1, right: 26))
        dividerView.backgroundColor = Color.grey3Colour
        cellContainerView.addSubview(dividerView, insets: UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16), ignoreConstant: .top)
        stack.addArrangedSubview(leftIcon)
        stack.addArrangedSubview(titleContainerView)
        stack.addArrangedSubview(switchContainerView)
        stack.spacing = 10.0
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        leftIcon.contentMode = .scaleAspectFit
    }
    
    func animate(tillDuration: CGFloat) {
        self.linearAnimation.animate(in: self.dividerView, duration: tillDuration, distanceToCover: self.frame.width, completion: nil)
    }
    
    func removeAnimationLayer() {
        self.linearAnimation.removeAnimationLayer()
    }
    
    func updateSwitchIndex(_ index: Int, rowCount: Int) {
        self.index = index
        self.rowCount = rowCount
        self.switchView.currentRow = index
    }
    
    var title: String? {
        get { return self.titleLabel.text }
        set {
            self.titleLabel.text = newValue
            self.layoutIfNeeded()
        }
    }
    
    var leftIconImage: UIImage? {
        get { return self.leftIcon.image }
        set { self.leftIcon.image = newValue }
    }
    
    var cameraBackImage: UIImage? {
        didSet {
            self.rightIcon.image = self.cameraBackImage
        }
    }
    
    var camerFrontImage: UIImage? {
        didSet {
            self.rightIcon.image = self.camerFrontImage
        }
    }
    
    var switchStatus: Bool {
        get { self.switchView.isOn }
           set { self.switchView.isOn = newValue }
    }
    
    var cellTypes: [CellType] = [] {
        didSet {
            guard self.cellTypes.count == self.rowCount, !self.cellTypes.isEmpty else { return }
            self.switchContainerView.removeFromSuperview()
            let cellType = self.cellTypes[index]
            switch self.cellTypes[index] {
            case .crossMark, .checkMark, .cameraBackImage, .camerFrontImage:
                self.testingContainerView.removeFromSuperview()
                self.stack.addArrangedSubview(self.rightIconContainerView)
                self.rightIcon.image = cellType == .crossMark ? UIImage.redCheckMark : UIImage.greenTick
            
            case .progressHud:
                self.rightIconContainerView.removeFromSuperview()
                self.stack.addArrangedSubview(testingContainerView)
                self.testingLabel.text = "Testing.."
                self.testingLabel.textColor = Color.darkGrey3Colour
                
            case .none:
                self.rightIconContainerView.removeFromSuperview()
                self.switchContainerView.removeFromSuperview()
                self.testingContainerView.removeFromSuperview()
                
            default:
                break
            }
        }
    }
}

private class CustomSwitch: UISwitch {
    var currentRow: Int = 0
}
