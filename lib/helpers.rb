module Curriculum
	module Helpers

		def get_curriculum_data(lang)
 			@person = OpenStruct.new(YAML.load(File.read("db/#{lang}.yml"))['person'])

      		@person.address = OpenStruct.new(@person.address)
      		@person.skills.map!{ |skill| OpenStruct.new(skill) }
      		@person.jobs.map!{ |job| OpenStruct.new(job) }
      		@person.education.map!{ |edu| OpenStruct.new(edu) }             
		end

		def base_url
 	    	@base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end

  	def mail_to(email)
      		link_to email, "mailto:#{email}"
  	end

    def skype_to(skype_handler)
      		link_to("Skype: #{skype_handler}", "skype:#{skype_handler}")
  	end

  	def link_to(text, url)
      		"<a href=\"#{url}\">#{text}</a>"
   	end

	end
end
