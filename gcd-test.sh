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
diff $tmp-test1-ans $tmp-err-args || ERROR "error in test1-2"

# 一時ファイルの削除
rm -f $tmp-*
# 正常終了
exit 0

