class Todo < ApplicationRecord
  # model association
  has_many :items, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by

  after_create { |todo| todo.message 'create' }
  after_update { |todo| todo.message 'update' }
  after_destroy { |todo| todo.message 'destroy' }

  def message action
    msg = {
      resource: 'todo',
      action: action,
      id: self.id,
      obj: self
    }

    puts 'saved'

    $redis.publish 'model-change', msg.to_json
  end
end
