# frozen_string_literal: true

require 'bundler'
Bundler.require

require 'json'
require_relative 'fonts_public.pb'

glob = 
fonts = Dir.glob(File.join('..', '**', 'METADATA.pb')).flat_map do |path|
  meta = File.read(path)

  family_proto = Google::Fonts::FamilyProto.parse_from_text(meta)

  directory = path.split('/')[-3..-2].join('/')
  family = %i[name designer license category].each_with_object({ directory: directory }) do |key, obj|
    obj[key] = family_proto.send(key)
  end

  family_proto.fonts.map do |font_proto|
    %i[name style weight filename post_script_name full_name copyright].each_with_object({ family: family }) do |key, obj|
      obj[key] = font_proto.send(key)
    end
  end
end

File.write('fonts.json', JSON.pretty_generate(fonts.sort_by { |f| f[:name] }))
