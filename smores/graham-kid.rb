require 'rinda/rinda'
 
#
# cs377
# spring 2019
# The S'mores Problem
# Tyler Kugler
# graham-kid.rb
#

URI = "druby://localhost:67671"
DRb.start_service
ts = Rinda::TupleSpaceProxy.new(DRbObject.new(nil, URI))

# At the top of every loop, the graham cracker kid will wait until 
# they can take the marshmallows and chocolate from the 
# last kid. Once successful, they're assemble and eat their 
# s'more. Then they'll hand back every ingredient.

while true
    puts "Graham cracker kid is waiting for the chocolate and marshmallows..."


    ts.take( ["chocolate", 2] )
    ts.take( ["marshmallows", 2] )
    
    puts "Graham cracker kid has the chocolate and marshmallows! They're now assembling and eating -- YUM!"

    # Assembling and eating s'more
    sleep(0.5)

    ts.write( ["chocolate", 0] )
    ts.write( ["marshmallows", 0])
    ts.write( ["graham-crackers", 0] )

    puts "Graham cracker kid is handing back all of the ingredients.\n\n"

end