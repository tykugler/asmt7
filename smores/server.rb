require 'rinda/tuplespace'
 
#
# cs377
# spring 2019
# The S'mores Problem
# Tyler Kugler
# server.rb
#

URI = "druby://localhost:67671"
DRb.start_service(URI, Rinda::TupleSpace.new)
DRb.thread.join