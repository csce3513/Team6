#!/usr/bin/env ruby

require_relative "../lib/planet_defense"

game_root = File.dirname $PROGRAM_NAME
ENV['PATH'] = File.join(game_root, 'lib') + ';' + ENV['PATH']