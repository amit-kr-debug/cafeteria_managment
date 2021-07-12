class Allocation < ApplicationRecord

  def self.available_tables
    total_tables=Notable.all[0].capacity
    all_allocated=Allocation.all
    if all_allocated.length > total_tables
      all_allocated=all_allocated.limit(total_tables)
    end


    allocated=all_allocated.where("time < ? " ,Time.now-1800)
    total_available_tables=allocated.length
    if all_allocated.length < total_tables
      total_available_tables+=(total_tables-all_allocated.length)
    end
    total_available_tables
  end

  def self.allocate_table(user_id)
    total_tables=Notable.all[0].capacity
    all_allocated=Allocation.all
    if all_allocated.length >= total_tables
      all_allocated=all_allocated.limit(total_tables)
      min = all_allocated[0].time
      allocated = all_allocated[0]
      all_allocated.each do |temp|
        if temp.time < min
          allocated = temp
          min = temp.time
        end
      end
      allocated.user_id=user_id
      if allocated.time < Time.now - 1800
        allocated.time = Time.now
      else
        allocated.time = allocated.time+1800
      end
      allocated.save
      return allocated.id
    end
    if all_allocated.length < total_tables
      allocation=Allocation.new(
        time: Time.now,
        user_id: user_id,
      )
      allocation.save
      return allocation.id
    end
  end

  def self.getTimeof(allocation_id)
    find(allocation_id).time
  end

  def self.next_available_time
    total_tables=Notable.all[0].capacity
    all_allocated=Allocation.all
    if all_allocated.length >= total_tables
      all_allocated=all_allocated.limit(total_tables)
      min = all_allocated[0].time
      allocated = all_allocated[0]
      all_allocated.each do |temp|
        if temp.time < min
          allocated = temp
          min = temp.time
        end
      end
    end
    return allocated.time+1800
  end
end
