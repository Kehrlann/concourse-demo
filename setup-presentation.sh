#!/usr/bin/env bash

git clone https://github.com/hakimel/reveal.js.git presentation
rm presentation/index.html
ln -s $PWD/presentation.html presentation/index.html
rm presentation/img
ln -s $PWD/images presentation/img
cd presentation
npm install
