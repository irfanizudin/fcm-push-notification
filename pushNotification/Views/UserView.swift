//
//  UserView.swift
//  pushNotification
//
//  Created by Irfan Izudin on 14/05/23.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var vm: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(vm.users, id: \.email) { user in
                        
                        VStack(alignment: .leading) {
                            Text("\(user.name.firstname) \(user.name.lastname)")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 100)
                        .background(.background)
                        .onTapGesture {
                            vm.showUserDetail = true
                            vm.userSelected = user.id
                        }

                    }
                }
                .sheet(isPresented: $vm.showUserDetail, content: {
                    UserDetail(id: vm.userSelected ?? 0)
                })

            }
            .navigationTitle("Users")
            .onAppear {
                vm.getUsers()
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            .environmentObject(AppViewModel())
    }
}
