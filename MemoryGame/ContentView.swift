//
//  ContentView.swift
//  MemoryGame
//
//  Phatthira Karn 6410742453
//  Wasawat Cheepsamut 6410742735
//

import SwiftUI

let food_emojis =       ["🍕","🍟","🍔","🌭","🌮","🍝","🍣","🍛"] +
                        ["🍕","🍟","🍔","🌭","🌮","🍝","🍣","🍛"]
let sealife_emojis =    ["🦑","🪼","🦞","🦀","🐡","🐠","🐬","🐳","🦈","🦭"] +
                        ["🦑","🪼","🦞","🦀","🐡","🐠","🐬","🐳","🦈","🦭"]
let fruit_emojis =      ["🍎","🍊","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🍍","🥝","🥑"] +
                        ["🍎","🍊","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🍍","🥝","🥑"]

struct ContentView: View {
    @State var theme = food_emojis
    @State var theme_color = Color(red: 0.996, green: 0.384, blue: 0.267)
    
    var body: some View {
        VStack {
            Text("Memorize").font(.largeTitle.bold())
            ScrollView {
                cards
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            themeButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(0..<theme.count, id: \.self) { index in
                CardView(content: theme[index])
                    .aspectRatio(1/1.6, contentMode: .fit)
            }
        }
        .foregroundColor(theme_color)
    }
    
    var themeButtons : some View {
        HStack {
            foodTheme
            sealifeTheme
            fruitTheme
        }
    }
    
    func themeButton(by emoji_set: Array<String>, tcolor: Color, header: String, symbol: String) -> some View {
        VStack {
            Button(action: {
                theme = emoji_set.shuffled()
                theme_color = tcolor
            }, label: {
                Image(systemName: symbol)
            })
            .foregroundColor(theme_color)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .padding(2)
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 20, maxWidth: 90,
                   minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 20, maxHeight: 30,
                   alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(header)
                .font(.footnote)
                .foregroundColor(theme_color)
        }
    }
    
    var foodTheme: some View {
        themeButton(by: food_emojis,
                    tcolor: Color(red: 0.996, green: 0.384, blue: 0.267),
                    header: "Food",
                    symbol: "fork.knife")
    }
    
    var sealifeTheme: some View {
        themeButton(by: sealife_emojis,
                    tcolor: Color(red: 0.529, green: 0.796, blue: 0.725),
                    header: "Sea Life",
                    symbol: "fish")
    }
    
    var fruitTheme: some View {
        themeButton(by: fruit_emojis,
                    tcolor: Color(red: 1, green: 0.502, blue: 0.502),
                    header: "Fruit",
                    symbol: "carrot")
    }
}


struct CardView: View {
    let content: String
    @State var isFaceUp = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(colorScheme == .dark ? .black : .white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
