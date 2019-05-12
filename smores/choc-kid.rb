require 'rinda/rinda'
 
#
# cs377
# spring 2019
# The S'mores Problem
# Tyler Kugler
# choc-kid.rb
#

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

# At the top of every loop, the chocolate kid will wait until 
# they can take the marshmallows and graham crackers from the 
# last kid. Once successful, they're assemble and eat their 
# s'more. Then they'll hand back every ingredient.

while true
    puts "Chocolate kid is waiting for the graham crackers and marshmallows..."

    ts.take( ["marshmallows", 3] )
    ts.take( ["graham-crackers", 3] )

    puts "Chocolate kid has the graham crackers and marshmallows! They're now assembling and eating -- YUM!"

    # Assembling and eating s'more
    sleep(0.5)

    ts.write( ["marshmallows", 0] )
    ts.write( ["graham-crackers", 0] )
    ts.write( ["chocolate", 0] )

    puts "Chocolate kid is handing back all of the ingredients.\n\n"


end
