//
//  ProductCardView.swift
//  pushNotification
//
//  Created by Irfan Izudin on 08/05/23.
//

import SwiftUI

struct ProductCardView: View {
    let product: Product
    
    var body: some View {
        VStack {
            VStack {
                AsyncImage(url: URL(string: product.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 150)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(height: 150)
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(product.title)
                    .font(.callout)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Text("USD \(product.price)")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
                                                                    
        }
        .frame(width: 170)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3))
        }

    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: Product(id: 1, title: "", price: 1, description: "", category: "", image: "", rating: Rating(rate: 1, count: 1)))
    }
}
