if Category.count == 0
    Category.create([
        {name: 'ウェブアプリ'},
        {name: 'フリーソフト'},
        {name: '有料ソフト'},
        {name: 'ゲーム'}
    ])
end