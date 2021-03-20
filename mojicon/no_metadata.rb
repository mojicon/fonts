# frozen_string_literal: true

require 'bundler'
Bundler.require

require 'json'
require_relative 'fonts_public.pb'

fonts = Dir.glob(File.join('..', '*', '*')).flat_map do |path|
  next if File.exists?("#{path}/METADATA.pb")
  next if path.match?(/\A\.\.\/(tools|axisregistry|catalog|mojicon)/)
  puts path
end
