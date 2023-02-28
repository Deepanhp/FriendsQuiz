module SubmissionsHelper
	def get_time_taken_to_complete_quiz(submission)
		return unless submission&.submitted
		#Time difference in minutes
		((submission.updated_at - submission.created_at)/60).round
	end

	def highlight_submitted_option(option, selected_option_id)
		return '' if option.blank? || selected_option_id.blank?
		return '' if option.id != selected_option_id.to_i
		option.is_answer ? "styled-table-submission-summary-option-correct" : "styled-table-submission-summary-option-wrong"
	end
end
