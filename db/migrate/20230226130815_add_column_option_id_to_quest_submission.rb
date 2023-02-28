class AddColumnOptionIdToQuestSubmission < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_submissions, :option_id, :integer
  end
end
