#!/bin/bash

CSTAT="$(xset -q |grep Caps | awk '{print $4}')"
NSTAT="$(xset -q | grep Num | awk '{print $8}')"

echo "CAPS: $CSTAT NUM: $NSTAT"
