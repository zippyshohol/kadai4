#!/bin/sh

# 一時ファイルのプレフィックス
tmp=/tmp/$$

# エラーメッセージ
echo "input 2 arguments" > $tmp-err-args
echo "input natural number" > $tmp-err-nat

# テスト失敗時の処理
ERROR_EXIT () {
  # エラーメッセージを標準エラー出力に表示
  echo "$1" >&2
  # 一時ファイルの削除
  rm -f $tmp-*
  # 異常終了
  exit 1
}

# テスト開始
# test1: 引数の数が足りない
./gcd.sh 2> $tmp-test1-ans && ERROR_EXIT "error in test1-1"
diff $tmp-test1-ans $tmp-err-args || ERROR_EXIT "error in test1-2"

# test2: 引数の数が多い
./gcd.sh 1 2 3 2> $tmp-test2-ans && ERROR_EXIT "error in test2-1"
diff $tmp-test2-ans $tmp-err-args || ERROR_EXIT "error in test2-2"

# test3: 引数 1 が数値でない
./gcd.sh hoge 2 2> $tmp-test3-ans && ERROR_EXIT "error in test3-1"
diff $tmp-test3-ans $tmp-err-nat || ERROR_EXIT "error in test3-2"

# test4: 引数 2 が数値でない
./gcd.sh 2 hoge 2> $tmp-test4-ans && ERROR_EXIT "error in test4-1"
diff $tmp-test4-ans $tmp-err-nat || ERROR_EXIT "error in test 4-2"

# 一時ファイルの削除
rm -f $tmp-*
# 正常終了
exit 0

