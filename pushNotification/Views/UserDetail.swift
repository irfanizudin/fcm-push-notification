//
//  UserDetail.swift
//  pushNotification
//
//  Created by Irfan Izudin on 14/05/23.
//

import SwiftUI

struct UserDetail: View {
    @EnvironmentObject var vm: AppViewModel
    let id: Int
    
    var body: some View {
        VStack {
            if let firstname = vm.user?.name.firstname,
               let lastname = vm.user?.name.lastname,
               let email = vm.user?.email {
                
                Text("\(id)")
                Text(firstname + lastname)
                    .font(.largeTitle.bold())
                Text(email)
                    .foregroundColor(.gray)

            }
        }
        .onAppear {
            vm.getUserDetail(id: id)
        }
    }
}

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserDetail(id: 1)
            .environmentObject(AppViewModel())
    }
}
