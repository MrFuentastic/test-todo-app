require 'rails_helper'


RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should change the complete attribute off all tasks in list to true' do
      chores = List.create(name:"chores")
      Task.create(list_id: chores.id, name:"garbage", complete:true, favorite:false, deadline:1.month.from_now)
      Task.create(list_id: chores.id, name:"mow lawn", complete:false, favorite:false, deadline:5.months.ago)
      Task.create(list_id: chores.id, name:"dishes", complete:true, favorite:true, deadline:1.day.ago)
      Task.create(list_id: chores.id, name:"walk z dog", complete:true, favorite:true, deadline:1.hour.ago)
      chores.complete_all_tasks!
      method_worked = true
      chores.tasks.each do |task|
        if task.complete == false
          method_worked = false
        end
      end
      expect(method_worked).to eq(true)
    end
  end

end
