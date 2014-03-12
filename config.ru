require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require './curriculum.rb'

map '/' do
	run CurriculumApp
end