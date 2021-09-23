//
//  PullToRefresh.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/23/21.
//

import Introspect
import SwiftUI


@available(iOS, introduced: 13, obsoleted: 15)
private struct PullToRefresh: UIViewRepresentable {
    @Binding var isRefreshing: Bool
    let onRefresh: () -> Void
    
    init(isRefreshing: Binding<Bool>, onRefresh: @escaping () -> Void) {
        self._isRefreshing = isRefreshing
        self.onRefresh = onRefresh
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isRefreshing: $isRefreshing, onRefresh: onRefresh)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            guard let tableView = self.tableView(view: uiView) else { return }
            
            if let refreshControl = tableView.refreshControl {
                if self.isRefreshing {
                    refreshControl.beginRefreshing()
                } else {
                    refreshControl.endRefreshing()
                }
                return
            }
            
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.onValueChanged), for: .valueChanged)
        }
    }
    
    class Coordinator {
        let isRefreshing: Binding<Bool>
        let onRefresh: () -> Void
        
        init(isRefreshing: Binding<Bool>, onRefresh: @escaping () -> Void) {
            self.isRefreshing = isRefreshing
            self.onRefresh = onRefresh
        }
        
        @objc func onValueChanged() {
            isRefreshing.wrappedValue = true
            onRefresh()
        }
    }
    
    private func tableView(view: UIView) -> UITableView? {
        // Search in ancestors
        if let tableView = Introspect.findAncestor(ofType: UITableView.self, from: view) {
            return tableView
        }
        
        guard let viewHost = Introspect.findViewHost(from: view) else {
            return nil
        }
        
        // Search in siblings
        return Introspect.previousSibling(containing: UITableView.self, from: viewHost)
    }
}
