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
    flag=false
    total_tables=Notable.all[0].capacity
    all_allocated=Allocation.all
    if all_allocated.length > total_tables
      all_allocated=all_allocated.limit(total_tables)
    end
    all_allocated.each do |allocated|
      if allocated.time+1800 < Time.now
        allocated.user_id=user_id
        allocated.time=Time.now
        flag=true
        allocated.save
        return true
      end
    end

    if flag==false
      if all_allocated.length < total_tables
        allocation=Allocation.new(
          time: Time.now,
          user_id: user_id,
        )
        allocation.save
        return true
      end
    end
    return false
  end

end
