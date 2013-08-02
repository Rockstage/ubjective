module TasksHelper

	def progress_objectives(task)
		#number_to_percentage(task.objectives.completed.count.to_f / task.objectives.count.to_f, precision: 0)
		if task.objectives.count > 0
			number_to_percentage((task.objectives.completed.count.to_f / task.objectives.count.to_f) * 100, precision: 0)
		else
			number_to_percentage(0, precision: 0)
		end
	end


end
