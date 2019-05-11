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
#   sem last-kids-selection = 0
#   sem graham-crackers = 0
#   sem chocolate = 0
#   sem marshmallows = 0

#ts.write( ["last-kids-selection", 0] )
ts.write( ["graham-crackers", 0] )
ts.write( ["chocolate", 0] )
ts.write( ["marshmallows", 0] )

puts "init-ts: tuple space initialized..."

