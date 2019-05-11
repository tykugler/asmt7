require 'rinda/rinda'
 
#
# cs377
# spring 2019
# The S'mores Problem
# Tyler Kugler
# choc-kid.rb
#
#

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

while true
    ts.take( ["marshmallows", 3] )
    ts.take( ["graham-crackers", 3] )

    puts "choc-kid has the graham-crackers and marshmallows"
    puts "choc-kid is eating their s'more -- yum!"

    ts.write( ["marshmallows", 0] )
    ts.write( ["graham-crackers", 0] )
    ts.write( ["chocolate", 0] )

    puts "sent back"


end
