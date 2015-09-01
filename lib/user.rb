class User < ActiveRecord::Base
has_many_through(:habits)


end
