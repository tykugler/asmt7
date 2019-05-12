require 'rinda/rinda'
 
#
# cs377
# spring 2019
# The S'mores Problem
# Tyler Kugler
# init-ts.rb
#

# Connect to tuple space
URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

# initialize tuple space
#   sem graham-crackers = 0
#   sem chocolate = 0
#   sem marshmallows = 0
#  
#   int g_count = 0
#   int c_count = 0
#   int m_count = 0

ts.write( ["graham-crackers", 0] )
ts.write( ["chocolate", 0] )
ts.write( ["marshmallows", 0] )

ts.write( ["g_count", 0] )
ts.write( ["c_count", 0] )
ts.write( ["m_count", 0] )

puts "init-ts: tuple space initialized..."

