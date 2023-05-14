//
//  SettingView.swift
//  pushNotification
//
//  Created by Irfan Izudin on 14/05/23.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var vm: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Setting")
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Notification") {
                        vm.showNotifSetting = true
                    }
                }
                
            }
            .navigationTitle("Setting")
            .background {
                NavigationLink(isActive: $vm.showNotifSetting) {
                    Text("Notif Setting")
                } label: {
                    EmptyView()
                }

            }

        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(AppViewModel())
    }
}
