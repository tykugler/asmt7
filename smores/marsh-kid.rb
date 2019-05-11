require 'rinda/rinda'
 
#
# cs377
# spring 2019
# The S'mores Problem
# Tyler Kugler
# marsh-kid.rb
#
#

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

while true
    ts.take( ["graham-crackers", 1] )
    ts.take( ["chocolate", 1] )

    puts "marsh-kid has the chocolate and graham-crackers"
    puts "marsh-kid is eating their s'more -- yum!"

    ts.write( ["graham-crackers", 0] )
    ts.write( ["chocolate", 0] )
    ts.write( ["marshmallows", 0] )

    puts "sent back"

end