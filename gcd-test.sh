#!/bin/sh

# 一時ファイルのプレフィックス
tmp=/tmp/$$

# エラーメッセージ
echo "input 2 arguments" > $tmp-args
echo "input natural number" > $tmp-nat

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
./gcd.sh 2> $tmp-ans && ERROR_EXIT "error in test 1-1"
diff $tmp-ans $tmp-args || ERROR_EXIT "error in test 1-2"

# test2: 引数の数が多い
./gcd.sh 1 2 3 2> $tmp-ans && ERROR_EXIT "error in test 2-1"
diff $tmp-ans $tmp-args || ERROR_EXIT "error in test 2-2"

# test3: 引数 1 が数値でない
./gcd.sh hoge 2 2> $tmp-ans && ERROR_EXIT "error in test 3-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test 3-2"

# test4: 引数 2 が数値でない
./gcd.sh 2 hoge 2> $tmp-ans && ERROR_EXIT "error in test 4-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test 4-2"

# test5: 引数 1 が 0
./gcd.sh 0 2 2> $tmp-ans && ERROR_EXIT "error in test 5-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test 5-2"

# test6: 引数 2 が 0
./gcd.sh 2 0 2> $tmp-ans && ERROR_EXIT "error in test 6-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test 6-2"

# test7: 引数 1 が負
./gcd.sh -1 2 2> $tmp-ans && ERROR_EXIT "error in test 7-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test 7-2"

# test8: 引数 2 が負
./gcd.sh 2 -1 2> $tmp-ans && ERROR_EXIT "error in test 8-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test 8-2"

# test9: 引数 1 が浮動小数点数
./gcd.sh 1.1 2 2> $tmp-ans && ERROR_EXIT "error in test 9-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test 9-2"

# test10: 引数 1 が浮動小数点数
./gcd.sh 2 1.1 2> $tmp-ans && ERROR_EXIT "error in test 10-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test 10-2"

# test11: 引数 1 が扱える範囲外の整数
./gcd.sh 9223372036854775808 2 2> $tmp-ans && ERROR_EXIT "error in test 11-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test 11-2"

# test12: 引数 2 が扱える範囲外の整数
./gcd.sh 2 9223372036854775808 2> $tmp-ans && ERROR_EXIT "error in test 12-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test 12-2"

# test13: gcd が引数 1 と一致
echo 3 > $tmp-exp
./gcd.sh 3 6 > $tmp-ans || ERROR_EXIT "error in test 13-1"
diff $tmp-exp $tmp-ans || ERROR_EXIT "error in test 13-2"

# test14: gcd が引数 2 と一致
echo 3 > $tmp-exp
./gcd.sh 6 3 > $tmp-ans || ERROR_EXIT "error in test 14-1"
diff $tmp-exp $tmp-ans || ERROR_EXIT "error in test 14-2"

# test15: gcd が引数 1 と引数 2 のどちらとも一致しない
echo 6 > $tmp-exp
./gcd.sh 12 18 > $tmp-ans || ERROR_EXIT "error in test 15-1"
diff $tmp-exp $tmp-ans || ERROR_EXIT "error in test 15-2"

# test16: gcd が 1
echo 1 > $tmp-exp
./gcd.sh 5 7 > $tmp-ans || ERROR_EXIT "error in test 16-1"
diff $tmp-exp $tmp-ans || ERROR_EXIT "error in test 16-2"

# 一時ファイルの削除
rm -f $tmp-*
# 正常終了
exit 0

