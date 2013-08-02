module ApplicationHelper

	def flash_class(type)
		case type
		when :alet
			"alert-error"
		when :notice
			"alert-info"
		else
			""
		end
	end

end
