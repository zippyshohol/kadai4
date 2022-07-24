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

# test5: 引数 1 が 0
./gcd.sh 0 2 2> $tmp-test5-ans && ERROR_EXIT "error in test5-1"
diff $tmp-test5-ans $tmp-err-nat || ERROR_EXIT "error in test 5-2"

# test6: 引数 2 が 0
./gcd.sh 2 0 2> $tmp-test6-ans && ERROR_EXIT "error in test6-1"
diff $tmp-test6-ans $tmp-err-nat || ERROR_EXIT "error in test 6-2"

# test7: 引数 1 が負
./gcd.sh -1 2 2> $tmp-test7-ans && ERROR_EXIT "error in test7-1"
diff $tmp-test7-ans $tmp-err-nat || ERROR_EXIT "error in test 7-2"

# test8: 引数 2 が負
./gcd.sh 2 -1 2> $tmp-test8-ans && ERROR_EXIT "error in test8-1"
diff $tmp-test8-ans $tmp-err-nat || ERROR_EXIT "error in test 8-2"

# test9: 引数 1 が浮動小数点数
./gcd.sh 1.1 2 2> $tmp-test9-ans && ERROR_EXIT "error in test9-1"
diff $tmp-test9-ans $tmp-err-nat || ERROR_EXIT "error in test 9-2"

# test10: 引数 1 が浮動小数点数
./gcd.sh 2 1.1 2> $tmp-test10-ans && ERROR_EXIT "error in test10-1"
diff $tmp-test10-ans $tmp-err-nat || ERROR_EXIT "error in test10-2"

# test11: 引数 1 が扱える範囲外の整数
./gcd.sh 9223372036854775808 2 2> $tmp-test11-ans && ERROR_EXIT "error in test11-1"
diff $tmp-test11-ans $tmp-err-nat || ERROR_EXIT "error in test11-2"

# test12: 引数 2 が扱える範囲外の整数
./gcd.sh 2 9223372036854775808 2> $tmp-test12-ans && ERROR_EXIT "error in test12-1"
diff $tmp-test12-ans $tmp-err-nat || ERROR_EXIT "error in test12-2"

# 一時ファイルの削除
rm -f $tmp-*
# 正常終了
exit 0

