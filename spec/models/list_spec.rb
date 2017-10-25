require 'rails_helper'


RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should change the complete attribute off all tasks in list to true' do
      chores = List.create(name:"chores")
      Task.create(list_id: chores.id, name:"garbage", complete:true)
      Task.create(list_id: chores.id, name:"mow lawn", complete:false)
      Task.create(list_id: chores.id, name:"dishes", complete:true)
      Task.create(list_id: chores.id, name:"walk z dog", complete:true)

      chores.complete_all_tasks!

      chores.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should complete the snooze hour method for each task' do
      chores = List.create(name:"chores")
      Task.create(list_id: chores.id, name:"garbage", deadline:1.month.from_now)
      Task.create(list_id: chores.id, name:"mow lawn",deadline:5.months.ago)
      Task.create(list_id: chores.id, name:"dishes", deadline:1.day.ago)
      Task.create(list_id: chores.id, name:"walk z dog", deadline:1.hour.ago)
      
      tasks_0_deadline = chores.tasks[0].deadline
      tasks_1_deadline = chores.tasks[1].deadline
      tasks_2_deadline = chores.tasks[2].deadline
      tasks_3_deadline = chores.tasks[3].deadline
      
      chores.snooze_all_tasks!

      expect(chores.tasks[0].deadline).to eq(tasks_0_deadline + 1.hour)
      expect(chores.tasks[1].deadline).to eq(tasks_1_deadline + 1.hour)
      expect(chores.tasks[2].deadline).to eq(tasks_2_deadline + 1.hour)
      expect(chores.tasks[3].deadline).to eq(tasks_3_deadline + 1.hour)
    end
  end

  describe '#total_duration' do
    it 'should return the sum of the durations for all tasks' do
      chores = List.create(name:"chores")
      Task.create(list_id: chores.id, name:"garbage", duration: 100)
      Task.create(list_id: chores.id, name:"mow lawn", duration: 100)
      Task.create(list_id: chores.id, name:"dishes", duration: 100)
      Task.create(list_id: chores.id, name:"walk z dog", duration: 100)

      expect(chores.total_duration).to eq(400)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of the tasks that have a false complete attribute' do
      chores = List.create(name:"chores")
      Task.create(list_id: chores.id, name:"garbage", complete:true)
      Task.create(list_id: chores.id, name:"mow lawn", complete:false)
      Task.create(list_id: chores.id, name:"dishes", complete:false)
      Task.create(list_id: chores.id, name:"walk z dog", complete:true)
      
      test_array = [chores.tasks[1], chores.tasks[2]]
      expect(chores.incomplete_tasks).to eq(test_array)
    end
  end

  describe '#favorite_tasks' do
    it 'should return an array of tasks with a true favorite attribute' do
      chores = List.create(name:"chores")
      Task.create(list_id: chores.id, name:"garbage", favorite:false)
      Task.create(list_id: chores.id, name:"mow lawn", favorite:false)
      Task.create(list_id: chores.id, name:"dishes", favorite:true)
      Task.create(list_id: chores.id, name:"walk z dog", favorite:true)
      
      test_array = [chores.tasks[2], chores.tasks[3]]
      expect(chores.favorite_tasks).to eq(test_array)
    end

  end

end
