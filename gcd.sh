#!/bin/sh

# 最大公約数を計算する
GCD () {
  if [ $2 -eq 0 ]; then
    echo $1
  else
    echo `GCD $2 $(( $1 % $2 ))`
  fi
}

# 引数が扱える範囲の自然数であるかどうか判定する
IS_NATURAL_NUMBER () {
  expr $1 + 0 > /dev/null 2>&1
  if [ $? -ge 2 ] || [ $1 -le 0 ]; then
    echo "input natural number"
    exit 1
  fi
}

# 引数が 2 個であることの確認
if [ $# -ne 2 ]; then
  echo "input 2 arguments" 1>&2
  exit 1
fi

# 引数が扱える範囲の自然数であることの確認
IS_NATURAL_NUMBER $1
IS_NATURAL_NUMBER $2

# 最大公約数を計算
GCD $1 $2
exit 0

