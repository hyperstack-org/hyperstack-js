# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require(:default)

BUILD_FILES = %w[hyper-router hyperstack-compiler hyperstack opal].freeze

def compile_js(filename)
  puts "Compiling #{filename}.js..."

  File.binwrite("./dist/#{filename}.js", Opal::Builder.build(filename).to_s)

  puts '...done!'
end

def minify_js(filename)
  puts "Minifying #{filename}.js..."

  js_file     = "./dist/#{filename}.js"
  js_min_file = "./dist/#{filename}.min.js"

  File.open(js_min_file, 'w').write(Uglifier.new(harmony: true).compile(File.read(js_file)))

  puts '...done!'
end

desc 'Compile and minify hyperstack libs'
task :compile do
  Opal.append_path 'lib'

  # Cleanup previous builds
  FileUtils.rm_rf('dist')
  FileUtils.mkdir('dist')

  BUILD_FILES.each do |filename|
    compile_js(filename)
    minify_js(filename)
  end
end

task default: %i[compile]
