require 'sinatra'
require 'open-uri'

require './lib/helpers.rb'

class CurriculumApp < Sinatra::Base

	register Sinatra::R18n
	set :root, File.dirname(__FILE__)

	helpers Curriculum::Helpers

	get '/' do 
		redirect '/en'
	end

	get '/:locale' do
 		get_curriculum_data(params[:locale]) 
 		erb :index
	end

	get '/pdf/:locale' do
		url = "#{base_url}/#{params[:locale]}"	
		
		html = Nokogiri::HTML(open(url))		
		html = html.css('#inner')
		html.css('#pdf').remove
		
		pdf = PDFKit.new(html.to_s)		
		pdf.stylesheets << 'public/css/pdf.css'
		pdf.stylesheets << 'public/css/reset-fonts-grids.css'
		
		pdf.to_file '/tmp/files'
		send_file '/tmp/files', :filename => 'cv_bruno_silveira.pdf', :type => 'Application/octet-stream'
	end

end
