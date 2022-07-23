#!/bin/sh

gcd () {
  if [ $2 -eq 0 ]; then
    echo $1
  else
    echo `gcd $2 $(( $1 % $2 ))`
  fi
}

# 引数が 2 個であるかどうかのチェック
if [ $# -ne 2 ]; then
  echo "input 2 arguments" 1>&2
  exit 1
fi

# 引数が自然数であるかどうかのチェック
expr $1 + $2 > /dev/null 2>&1
if [ $? -ge 2 ] || [ $1 -eq 0 ] || [ $2 -eq 0 ]; then
  echo "input natural number" 1>&2
  exit 1
fi

# 最大公約数を計算
gcd $1 $2
exit 0

