#!/usr/bin/env node
require('coffee-script/register');
var through = require('../README.coffee.md');
process.stdin.pipe(through(process.argv[2])).pipe(process.stdout);