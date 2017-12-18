class Todo < ActiveRecord::Base
  # model association
  has_many :items, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by

  after_create {|todo| todo.message 'create' }
  after_update {|todo| todo.message 'update' }
  after_destroy {|todo| todo.message 'destroy' }

  def message action
    puts "processing action #{action}"

    msg = {
        resource: 'todos',
        action: action,
        id: self.id,
        obj: self,
        channel: "company_#{rand(1..2)}",
    }

    $redis.publish 'rt-change', msg.to_json
  end
end
