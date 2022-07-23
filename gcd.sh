#!/bin/sh

# 最大公約数を計算する
gcd () {
  if [ $2 -eq 0 ]; then
    echo $1
  else
    echo `gcd $2 $(( $1 % $2 ))`
  fi
}

# 引数が扱える範囲の自然数であるかどうか判定する
is_natural_number() {
  # 扱える範囲の整数であることの確認
  expr $1 + 0 > /dev/null 2>&1
  if [ $? -ge 2 ]; then
    echo "gcd: $1 is not a number or out of range"
    exit 1
  fi
  
  # 正の整数であることの確認
  if [ $1 -le 0 ]; then
    echo "gcd: $1 is not a natural number"
    exit 1
  fi
}

# 引数が 2 個であることの確認
if [ $# -ne 2 ]; then
  echo "gcd: input 2 arguments" 1>&2
  exit 1
fi

# 引数が扱える範囲の自然数であることの確認
is_natural_number $1
is_natural_number $2

# 最大公約数を計算
gcd $1 $2
exit 0

