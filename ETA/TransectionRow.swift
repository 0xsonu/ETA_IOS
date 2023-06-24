//
//  TransectionRow.swift
//  ETA
//
//  Created by Sonu Kumar on 21/06/23.
//

import SwiftUI
import SwiftUIFontIcon

struct TransectionRow: View {
    var transection : Transection
    
    var body: some View {
        HStack(spacing: 20){
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay{
                    FontIcon.text(.awesome5Solid(code: transection.icon), fontsize: 24, color: Color.icon)
                }
            VStack(alignment: .leading, spacing: 6){
                Text(transection.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                Text(transection.category)
                    .font(.footnote).opacity(0.7).lineLimit(1)
                
                Text(transection.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(transection.signedAmount * 85.6, format: .currency(code: "INR"))
                .bold()
                .foregroundColor(transection.type == TransectionType.credit.rawValue
                                 ? Color.text : .primary)
        }
        .padding([.top, .bottom], 8)
        
    }
}

struct TransectionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransectionRow(transection: transectionPreviewData)
    }
}
