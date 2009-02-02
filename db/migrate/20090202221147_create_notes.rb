class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.text :body
    end
    create_table :tasks_notes, :id => false do |t|
      t.integer :task_id
      t.integer :note_id
    end
  end
  
  def self.down
    drop_table :notes
    drop_table :tasks_notes
  end
end