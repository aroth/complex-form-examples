class Task < ActiveRecord::Base
  belongs_to :project
  
  # notes
  has_and_belongs_to_many :notes
  accepts_nested_attributes_for :notes
  
  validates_presence_of :name
  
  attr_accessor :raise_exception
  
  after_save :raise_exception_if_needed
  def raise_exception_if_needed
    if @raise_exception.to_i == 1
      raise 'Oh noes!'
    end
  end
end
