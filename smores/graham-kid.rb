require 'rinda/rinda'
 
#
# cs377
# spring 2019
# The S'mores Problem
# Tyler Kugler
# graham-kid.rb
#
#

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

while true
    ts.take( ["chocolate", 2] )
    ts.take( ["marshmallows", 2] )

    puts "graham-kid has the marshmallows and chocolate"
    puts "graham-kid is eating their s'more -- yum!"

    ts.write( ["chocolate", 0] )
    ts.write( ["marshmallows", 0])
    ts.write( ["graham-crackers", 0] )

    puts "sent back"

end