//
//  ContentView.swift
//  pushNotification
//
//  Created by Irfan Izudin on 30/04/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: AppViewModel
    
    var body: some View {
        TabView(selection: $vm.tabSelected) {
            ProductView()
                .environmentObject(vm)
                .tag(Tab.product)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Products")
                }
            
            UserView()
                .environmentObject(vm)
                .tag(Tab.user)
                .tabItem {
                    Image(systemName: "person")
                    Text("Users")
                }
            
            SettingView()
                .environmentObject(vm)
                .tag(Tab.setting)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }
        }
        .tint(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppViewModel())
    }
}
