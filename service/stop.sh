#!/bin/bash

for bind in $(pgrep 6tunnel); do
  kill "${bind}"
done
