class Todo < ApplicationRecord
  # model association
  has_many :items, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by



  after_create {|book| book.message 'create' }
  after_update {|book| book.message 'update' }
  after_destroy {|book| book.message 'destroy' }

  def message action
    msg = { resource: 'books',
            action: action,
            id: self.id,
            obj: self }

    $redis.publish 'rt-change', msg.to_json
  end
end
