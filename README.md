# firestore_search
Flutterの機能だけで、検索をする機能を実装する。
AppBarに検索機能を実装する。

```dart
Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.redAccent,
            // AppBar検索Form.
            title: Card(
              child: TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: '映画を検索...'),
                onChanged: (val) {
                  // ここにFormの値が入ってくる.
                  setState(() {
                    title = val; // 上で定義した変数に値を保存する.
                  });
                },
              ),
            )),
```

このif文のところで検索候補を探す

```dart
return ListView.builder(
                itemCount: data.size, // データの数をカウントする.
                itemBuilder: (context, index) {
                  if (title.isEmpty) {
                    // ここから、検索ワードを調べる.
                    final doc = data.docs[index].data();
                    return ListTile(
                      title: Text(
                        doc.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        doc.genre,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }
```
