#!/bin/bash

pgrep 6tunnel

for bind in $(pgrep 6tunnel); do
  kill "${bind}"
done
